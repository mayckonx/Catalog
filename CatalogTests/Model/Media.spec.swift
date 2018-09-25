//
//  Media.spec.swift
//  CatalogTests
//
//  Created by Mayckon Barbosa da Silva on 9/24/18.
//  Copyright © 2018 Mayckon Barbosa da Silva. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Catalog

class MediaSpec: QuickSpec {
    override func spec() {
        describe("Media model") {
            var media: Media!
            context("got a media with all data set") {
                beforeEach {
                    let testBundle = Bundle(for: type(of: self))
                    let mockLoader = MockLoader(file: "media", withExtension: "json", in: testBundle)
                    media = mockLoader?.map(to: Media.self)
                }
                it("should be able to create a media") {
                    expect(media).toNot(beNil())
                }
                it("should be all data set") {
                    expect(media.id.count).to(beGreaterThan(0))
                    expect(media.name.count).to(beGreaterThan(0))
                    expect(media.artistName.count).to(beGreaterThan(0))
                    expect(media.url.count).to(beGreaterThan(0))
                    expect(media.kind.count).to(beGreaterThan(0))
                    expect(media.albumUrl.count).to(beGreaterThan(0))
                    expect(media.releaseDate.count).to(beGreaterThan(0))
                }
            }
            context("got a media json with nil data") {
                beforeEach {
                    let testBundle = Bundle(for: type(of: self))
                    let mockLoader = MockLoader(file: "media-null-data", withExtension: "json", in: testBundle)
                    media = mockLoader?.map(to: Media.self)
                }
                it("should not be able to create a media") {
                    expect(media).to(beNil())
                }
            }
        }
    }
}


