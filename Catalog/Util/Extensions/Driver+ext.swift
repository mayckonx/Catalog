//
//  Driver+ext.swift
//  Catalog
//
//  Created by Mayckon Barbosa da Silva on 9/23/18.
//  Copyright © 2018 Mayckon Barbosa da Silva. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Driver where E == Bool {
    /// Boolean not operator
    public func not() -> Driver<Bool> {
        return self.map(!).asDriver(onErrorJustReturn: false)
    }
}
