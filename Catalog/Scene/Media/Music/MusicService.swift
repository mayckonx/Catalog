//
//  MusicService.swift
//  Catalog
//
//  Created by Mayckon Barbosa da Silva on 9/23/18.
//  Copyright © 2018 Mayckon Barbosa da Silva. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift
import RxRealm

protocol MusicServiceNetwork {
    func getMusics() -> Observable<[Media]>
}

final class MusicService: MusicServiceNetwork {

    private var apiService: APIService!
    
    init(_ isTesting:Bool?=false) {
          apiService = APIService(isTesting: isTesting)
    }
    func getMusics() -> Observable<[Media]> {
        let feeds: Observable<Feed> = apiService.requestObject(.musics, jsonKey: "feed")
        return feeds.flatMap({ feed -> Observable<[Media]> in
            return Observable.of(feed.results)
        })
    }
}
