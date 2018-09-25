//
//  MusicViewModel.swift
//  CatalogTests
//
//  Created by Mayckon Barbosa da Silva on 9/24/18.
//  Copyright © 2018 Mayckon Barbosa da Silva. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Moya
import RxSwift
import RxCocoa
import RxTest
import RxBlocking

@testable import Catalog

class MusicViewModelSpec: QuickSpec {
    var testScheduler: TestScheduler!
    var disposeBag: DisposeBag!
    var networkService: MusicServiceNetwork!
    var viewModel: MusicViewModel!
    var trigger: Driver<Void>!
    
    override func spec() {
        
        beforeEach {
            self.testScheduler = TestScheduler(initialClock: 0)
            self.disposeBag = DisposeBag()
            self.networkService = MusicService(true)
            self.viewModel = MusicViewModel(networkService: self.networkService)
            
            self.viewModel.viewDidLoad()
        }
        
        context("triggered to fetch music") {
            it("Return array of media") {
                let musics = self.viewModel.outputs.musics
                guard let result = try! musics.toBlocking().first() else { return }
                expect(result.count).to(beGreaterThan(0))
            }
        }
    }
}

