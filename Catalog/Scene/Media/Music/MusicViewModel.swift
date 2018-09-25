//
//  MusicViewModel.swift
//  Catalog
//
//  Created by Mayckon Barbosa da Silva on 9/23/18.
//  Copyright © 2018 Mayckon Barbosa da Silva. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxRealm

protocol MusicViewModelInput {
    func viewDidLoad()
    var musicSelected: AnyObserver<Media> { get }
}

protocol MusicViewModelOutput {
    var musics: Driver<[Media]> { get }
    var fetching: Driver<Bool> { get }
    var errorMessage: Driver<String> { get }
}

protocol MusicViewModelType {
    var inputs: MusicViewModelInput { get }
    var outputs: MusicViewModelOutput { get }
}

final class MusicViewModel: MusicViewModelType, MusicViewModelInput, MusicViewModelOutput {
    
    var inputs: MusicViewModelInput { return self }
    var outputs: MusicViewModelOutput { return self }
    
    // inputs
    var musicSelected: AnyObserver<Media>
    
    // outputs
    var fetching: Driver<Bool>
    var musics: Driver<[Media]>
    var errorMessage: Driver<String>
    
    // auxiliar vars
    private var networkService: MusicServiceNetwork!
    private let errorMessageSubject = PublishSubject<String>()
    private let disposeBag = DisposeBag()
    
    init(networkService: MusicServiceNetwork) {
        self.networkService = networkService
        let activityIndicator = ActivityIndicator()
        self.fetching = activityIndicator.asDriver()
        self.errorMessage = errorMessageSubject.asDriverOnErrorJustComplete()
        self.musics = .empty()
        let musicSelectedSubject = PublishSubject<Media>()
        self.musicSelected = musicSelectedSubject.asObserver()
        
        self.musics = viewDidLoadSubject.asObservable()
            .flatMapLatest({ _ in
                self.networkService.getMusics()
                .trackActivity(activityIndicator)
            })
            .catchError({ [weak self] error -> Observable<[Media]> in
                self?.errorMessageSubject.onNext(error.localizedDescription)
                return Observable.empty()
            })
            .asDriverOnErrorJustComplete()
        
        //
        musicSelectedSubject.asObservable()
            .subscribe(onNext: { media in
                guard let url = URL(string: media.url) else {
                    return
                }
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    private let viewDidLoadSubject = PublishSubject<Void>()
    func viewDidLoad() {
       self.viewDidLoadSubject.onNext(())
    }
}
