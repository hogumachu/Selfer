//
//  UIViewController+Rx.swift
//  Selfer
//
//  Created by 홍성준 on 2023/02/22.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    
    var viewDidLoad: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewDidLoad)).map { _ in }
        return ControlEvent(events: source)
    }
    
}
