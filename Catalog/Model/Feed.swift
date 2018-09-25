//
//  Feeds.swift
//  Catalog
//
//  Created by Mayckon Barbosa da Silva on 9/23/18.
//  Copyright © 2018 Mayckon Barbosa da Silva. All rights reserved.
//

import Foundation

struct Feed: Codable {
    var results: [Media]
    private enum CodingKeys: String, CodingKey {
        case results
    }
}
