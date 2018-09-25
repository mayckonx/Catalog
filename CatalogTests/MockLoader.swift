//
//  MockLoader.swift
//  CatalogTests
//
//  Created by Mayckon Barbosa da Silva on 9/24/18.
//  Copyright © 2018 Mayckon Barbosa da Silva. All rights reserved.
//

import Foundation
import Moya

@testable import Catalog

struct MockLoader {
    
    let data: Data
    let json: String
    
    init?(file: String, withExtension fileExt: String = "json", in bundle:Bundle = Bundle.main) {
        guard let path = bundle.path(forResource: file, ofType: fileExt) else {
            return nil
        }
        let pathURL = URL(fileURLWithPath: path)
        do {
            data = try Data(contentsOf: pathURL, options: .dataReadingMapped)
            if let decoded = NSString(data: data, encoding: 0) as String? {
                json = decoded
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
    
    
}
extension MockLoader {
    func map<T: Codable>(to type: T.Type) -> T? {
        guard let data = json.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    func mapArray<T: Codable>(to type: [T].Type, keyPath: String?="") -> [T]? {
        guard let data = json.data(using: .utf8) else { return nil }
        let response = Response(statusCode: 200, data: data)
        return try! response.map([T].self, atKeyPath: keyPath)
    }
}


