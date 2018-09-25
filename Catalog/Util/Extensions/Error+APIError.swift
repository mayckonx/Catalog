//
//  Error+APIError.swift
//  Catalog
//
//  Created by Mayckon Barbosa da Silva on 9/23/18.
//  Copyright © 2018 Mayckon Barbosa da Silva. All rights reserved.
//

import Foundation

enum ApiError : Error {
    case notFound
    case requestError
    case connectionError
    case unknown
}

// customize the "localizedString" attribute
// now we can use it to show on the view
extension ApiError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .requestError:
            return NSLocalizedString("Couldn't authenticate", comment: "")
        case .notFound:
            return NSLocalizedString("Invalid Endpoint", comment: "")
        case .unknown:
            return NSLocalizedString("Couldn't connect to server", comment: "")
        case .connectionError:
            return NSLocalizedString("Couldn't connect to server", comment: "")
        }
    }
}
