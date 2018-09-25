//
//  Music.swift
//  Catalog
//
//  Created by Mayckon Barbosa da Silva on 9/23/18.
//  Copyright © 2018 Mayckon Barbosa da Silva. All rights reserved.
//

import Foundation

struct Media: Codable {
    var id: String
    var artistName: String
    var releaseDate: String
    var name: String
    var albumUrl: String
    var url: String
    var kind: String
    private enum CodingKeys: String, CodingKey {
        case id
        case artistName
        case releaseDate
        case name
        case albumUrl = "artworkUrl100"
        case url
        case kind
    }
}
