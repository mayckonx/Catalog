//
//  MediaTableViewCell.swift
//  Catalog
//
//  Created by Mayckon Barbosa da Silva on 9/23/18.
//  Copyright © 2018 Mayckon Barbosa da Silva. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RealmSwift

enum FavoriteState {
    case favourited, notFavourited
}

class MediaTableViewCell: TableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblArtistName: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var imgAlbum: UIImageView!
    @IBOutlet weak var btnRate: UIButton!
    
    var didFavorite: (() -> Void)?
    var didUnfavorite: (() -> Void)?
    var media: Media!
    let databaseService: MediaDatabase = DatabaseService()
    
    var viewState: FavoriteState = .notFavourited {
        didSet {
            if viewState == .notFavourited {
                btnRate.setImage(UIImage(named: "rateoff.png"), for: .normal)
            } else {
                btnRate.setImage(UIImage(named: "rateon.png"), for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        didFavorite = {
            self.databaseService.favorite(media: self.media)
        }
        
        didUnfavorite = {
            self.databaseService.unfavorite(media: self.media)
        }
    }

    func configure(_ media: Media) {
        self.media = media
        self.lblName.text = media.name
        self.lblArtistName.text = media.artistName
        self.lblReleaseDate.text = String.presentationDate(media.releaseDate) 
        self.imgAlbum.kf.setImage(with: URL(string:media.albumUrl))
        self.viewState = .notFavourited
        
        databaseService.isFavoriteMedia(media: media)
            .subscribe(onNext: { [weak self] (result) in
                if result.count > 0 {
                    self?.viewState = .favourited
                } else {
                    self?.viewState = .notFavourited
                }
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction func changeFavoriteState(_ sender: Any) {
        if viewState == .favourited {
            didUnfavorite?()
            viewState = .notFavourited
        } else {
            viewState = .favourited
            didFavorite?()
        }
    }
}
