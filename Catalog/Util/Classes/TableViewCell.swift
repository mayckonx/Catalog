//
//  TableViewCell.swift
//  Catalog
//
//  Created by Mayckon Barbosa da Silva on 9/24/18.
//  Copyright © 2018 Mayckon Barbosa da Silva. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class TableViewCell: UITableViewCell {
    
    private(set) var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
