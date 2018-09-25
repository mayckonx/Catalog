//
//  APIService.swift
//  Catalog
//
//  Created by Mayckon Barbosa da Silva on 9/23/18.
//  Copyright © 2018 Mayckon Barbosa da Silva. All rights reserved.
//

import Foundation
import Moya
import RxSwift


class APIService {
    
    // api provider
    let provider: MoyaProvider<CatalogAPI>
    
    // we use this scheduler to execute the request on the background thread
    private let schedulerBackground: ConcurrentDispatchQueueScheduler
    
    init(isTesting: Bool?=false) {
        if isTesting! == true {
            provider = MoyaProvider<CatalogAPI>(stubClosure: MoyaProvider.immediatelyStub)
        }
        else {
            provider = MoyaProvider<CatalogAPI>(plugins:[NetworkLoggerPlugin(verbose: true)])
        }
        self.schedulerBackground = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
    }
    
    /// Request an array from the server
    /**
     - Parameter token: moya endpoint provider
     - Parameter jsonKey: the key in the json response that represents the data
     - Returns: An observable containing an array of mappable object
     */
    func requestArray<T: Decodable>(_ token: CatalogAPI, jsonKey: String?=nil) -> Observable<[T]> {
        return provider.rx.request(token)
            .observeOn(schedulerBackground)
            .asObservable()
            .catchError({ error -> Observable<Response> in
                // if for any reason the error doesn't be a MoyaError
                // let's return a generic message
                guard let moyaError = (error as? MoyaError) else {
                    return Observable.error(ApiError.connectionError)
                }
                return Observable.error(self.parseError(error: moyaError))
            })
            .map([T].self, atKeyPath: jsonKey)
            .observeOn(MainScheduler.instance)
    }
    
    /// Request an object from the server
    /**
     - Parameter token: moya endpoint provider
     - Parameter jsonKey: the key in the json response that represents the data
     - Returns: An observable containing an array of mappable object
     */
    func requestObject<T: Decodable>(_ token: CatalogAPI, jsonKey: String?=nil) -> Observable<T> {
        return provider.rx.request(token)
            .observeOn(schedulerBackground)
            .asObservable()
            .catchError({ error -> Observable<Response> in
                // if for any reason the error doesn't be a MoyaError
                // let's return a generic message
                guard let moyaError = (error as? MoyaError) else {
                    return Observable.error(ApiError.connectionError)
                }
                return Observable.error(self.parseError(error: moyaError))
            })
            .map(T.self, atKeyPath: jsonKey)
            .observeOn(MainScheduler.instance)
    }
}

// Error treatment extension
extension APIService {
    func parseError(error: MoyaError) -> ApiError {
        // we could extend and do more validations
        // but for this project, I will keep it generic for other situations.
        if let response = error.response {
            switch response.statusCode {
            case 401:
                return ApiError.requestError
            case 404:
                return ApiError.notFound
            default:
                return ApiError.unknown
            }
        }
        // the error doesn't have a response object, so we can't get the status code
        // let's return a generic message
        return ApiError.connectionError
    }
}
