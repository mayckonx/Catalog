//
//  MovieService.swift
//  Catalog
//
//  Created by Mayckon Barbosa da Silva on 9/24/18.
//  Copyright © 2018 Mayckon Barbosa da Silva. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


protocol MovieServiceNetwork {
    func getMovies() -> Observable<[Media]>
}

final class MovieService: MovieServiceNetwork {
  
    private var apiService: APIService!
    
    init(_ isTesting:Bool?=false) {
        apiService = APIService(isTesting: isTesting)
    }
    func getMovies() -> Observable<[Media]> {
        let feeds: Observable<Feed> = apiService.requestObject(.movies, jsonKey: "feed")
        return feeds.flatMap({ feed -> Observable<[Media]> in
            return Observable.of(feed.results)
        })
    }
}

