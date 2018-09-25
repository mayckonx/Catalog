//
//  MovieViewController.swift
//  Catalog
//
//  Created by Mayckon Barbosa da Silva on 9/24/18.
//  Copyright © 2018 Mayckon Barbosa da Silva. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class MovieViewController: UIViewController, Alertable {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: MovieViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.bindViewModel()
        
        self.viewModel.inputs.viewDidLoad()
    }
    
    func bindViewModel() {
        // inputs
        self.tableView.rx.itemSelected.subscribe(onNext: { indexPath in
            self.tableView.deselectRow(at: indexPath, animated: true)
        }).disposed(by: disposeBag)
        
        
        tableView.rx.modelSelected(Media.self)
            .bind(to: viewModel.inputs.movieSelected)
            .disposed(by: disposeBag)
        
        // outputs
        self.viewModel.outputs.movies
            .drive(tableView.rx.items(cellIdentifier: "MediaTableViewCell", cellType: MediaTableViewCell.self)) { (row, element, cell) in
                cell.configure(element)
            }
            .disposed(by: disposeBag)
        
        self.viewModel.outputs.fetching
            .drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)
        
        self.viewModel.outputs.fetching
            .drive(tableView.refreshControl!.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        
        self.viewModel.outputs.errorMessage
            .drive(onNext: { [weak self] errorMessage in
                self?.showAlert(of: .error, message: errorMessage)
            })
            .disposed(by: disposeBag)
    }
}

extension MovieViewController {
    func setupUI() {
        self.setupTableView()
    }
    
    func setupTableView() {
        // clear empty rows
        self.tableView.tableFooterView = UIView()
        self.tableView.refreshControl = UIRefreshControl()
    }
}

