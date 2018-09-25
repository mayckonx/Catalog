//
//  CatalogAPI.swift
//  Catalog
//
//  Created by Mayckon Barbosa da Silva on 9/23/18.
//  Copyright © 2018 Mayckon Barbosa da Silva. All rights reserved.
//

import Foundation
import Moya

fileprivate struct CatalogAPIConfig {
    static let urlBase = "https://rss.itunes.apple.com/api/v1/us"
    static let musicsEndpoint = "apple-music/coming-soon/all/50/explicit.json"
    static let moviesEndpoint = "movies/top-movies/all/50/explicit.json"
}

enum CatalogAPI {
    case musics
    case movies
}

// I use Moya here because it's provide me an abstraction
// of all concerns involving API service, such as:
// base url, params, headers, kind of http request, etc
// also it's designed to enforce endpoint testability(through sampleData variable).
// It helps keep the code organized, simple and clear even if we get a lot of new services or review the code months later
extension CatalogAPI: TargetType {
    // Http Basic Auth
    
    var headers: [String : String]? {
        return ["Accept": "application/json",
                "Content-Type": "application/json"]
    }
    
    var baseURL: URL { return URL(string: CatalogAPIConfig.urlBase)! }
    
    var path: String {
        switch self {
        case .musics:
            return CatalogAPIConfig.musicsEndpoint
        case .movies:
            return CatalogAPIConfig.moviesEndpoint
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .musics, .movies:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .movies, .musics:
            return .requestPlain
        }
    }
    
    var sampleData: Data {
        switch self {
        case .musics:
            return stubbedResponse("musics")
        case .movies:
            return stubbedResponse("movies")
        }
    }
}

private func stubbedResponse(_ filename: String) -> Data! {
    @objc class TestClass: NSObject { }
    
    let bundle = Bundle(for: TestClass.self)
    let path = bundle.path(forResource: filename, ofType: "json")
    return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
}


