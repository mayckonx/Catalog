//
//  RMMedia.swift
//  Catalog
//
//  Created by Mayckon Barbosa da Silva on 9/24/18.
//  Copyright © 2018 Mayckon Barbosa da Silva. All rights reserved.
//

import Foundation
import RealmSwift

final class RMFavoriteMedia: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var artistName: String = ""
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var albumUrl: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var kind: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}


extension Media {
    func mapToRealm() -> RMFavoriteMedia {
        return RMFavoriteMedia.build { object in
            object.id = id
            object.artistName = artistName
            object.releaseDate = releaseDate
            object.name = name
            object.albumUrl = albumUrl
            object.url = url
            object.kind = kind
        }
    }
}

extension RMFavoriteMedia {
    func mapToModel() -> Media {
        return Media(id: id,
                       artistName: artistName,
                       releaseDate: releaseDate,
                       name: name,
                       albumUrl: albumUrl,
                       url: url,
                       kind: kind)
    }
}

