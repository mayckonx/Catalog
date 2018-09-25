//
//  MediaRealmManager.swift
//  Catalog
//
//  Created by Mayckon Barbosa da Silva on 9/24/18.
//  Copyright © 2018 Mayckon Barbosa da Silva. All rights reserved.
//

import Foundation
import RxRealm
import RealmSwift
import RxSwift

protocol MediaDatabase {
    func isFavoriteMedia(media: Media) -> Observable<Results<RMFavoriteMedia>>
    func favorite(media: Media)
    func favorites(filter predicateFormat: String?) -> Observable<Results<RMFavoriteMedia>>
    func unfavorite(media: Media)
}

struct DatabaseService: MediaDatabase {
    
    let disposeBag = DisposeBag()
    
    func isFavoriteMedia(media: Media) -> Observable<Results<RMFavoriteMedia>>{
        return favorites(filter: "id == '\(media.id)' AND kind == '\(media.kind)'")
    }
    
    func favorite(media: Media) {
        let mediaRealm = media.mapToRealm()
        Observable.just(mediaRealm)
            .subscribe(Realm.rx.add())
            .disposed(by: disposeBag)
    }
    
    func favorites(filter predicateFormat: String? = nil) -> Observable<Results<RMFavoriteMedia>> {
        guard let realm = try? Realm() else {
            return Observable.empty()
        }
        var results: Results<RMFavoriteMedia> = realm.objects(RMFavoriteMedia.self)
        if let predicate = predicateFormat {
            results = results.filter(predicate)
        }
        
        return Observable.collection(from: results)
    }
    
    func unfavorite(media: Media) {
        favorites(filter: "id == '\(media.id)' AND kind == '\(media.kind)'")
            .subscribe(Realm.rx.delete())
            .dispose()
    }
    
}
