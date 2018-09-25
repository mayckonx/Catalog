//
//  MovieViewModel.swift
//  Catalog
//
//  Created by Mayckon Barbosa da Silva on 9/24/18.
//  Copyright © 2018 Mayckon Barbosa da Silva. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol MovieViewModelInput {
    func viewDidLoad()
    
    var movieSelected: AnyObserver<Media> { get }
}

protocol MovieViewModelOutput {
    var movies: Driver<[Media]> { get }
    var fetching: Driver<Bool> { get }
    var errorMessage: Driver<String> { get }
}

protocol MovieViewModelType {
    var inputs: MovieViewModelInput { get }
    var outputs: MovieViewModelOutput { get }
}

final class MovieViewModel: MovieViewModelType, MovieViewModelInput, MovieViewModelOutput {
    
    var inputs: MovieViewModelInput { return self }
    var outputs: MovieViewModelOutput { return self }
    
    // inputs
    var movieSelected: AnyObserver<Media>
    
    // outputs
    var fetching: Driver<Bool>
    var movies: Driver<[Media]>
    var errorMessage: Driver<String>
    
    // auxiliar vars
    private var networkService: MovieServiceNetwork!
    private let errorMessageSubject = PublishSubject<String>()
    private let disposeBag = DisposeBag()
    
    init(networkService: MovieServiceNetwork) {
        self.networkService = networkService
        let activityIndicator = ActivityIndicator()
        self.fetching = activityIndicator.asDriver()
        self.errorMessage = errorMessageSubject.asDriverOnErrorJustComplete()
        self.movies = .empty()
        let movieSelectedSubject = PublishSubject<Media>()
        self.movieSelected = movieSelectedSubject.asObserver()
        
        self.movies = viewDidLoadSubject.asObservable()
            .flatMapLatest({ _ in
                self.networkService.getMovies()
                    .trackActivity(activityIndicator)
            })
            .catchError({ [weak self] error -> Observable<[Media]> in
                self?.errorMessageSubject.onNext(error.localizedDescription)
                return Observable.empty()
            })
            .asDriverOnErrorJustComplete()
        
        //
        movieSelectedSubject.asObservable()
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
