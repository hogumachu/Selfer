//
//  Loadable.swift
//  Selfer
//
//  Created by 홍성준 on 2023/02/22.
//

import UIKit
import RxSwift

protocol Loadable: AnyObject {
    
    func showLoading()
    func hideLoading()
    
}

extension Reactive where Base: Loadable {
    
    var isLoading: Binder<Bool> {
        return Binder(self.base) { loadable, isLoading in
            if isLoading {
                loadable.showLoading()
            } else {
                loadable.hideLoading()
            }
        }
    }
    
}
