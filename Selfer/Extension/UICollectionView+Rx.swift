//
//  UICollectionView+Rx.swift
//  Selfer
//
//  Created by 홍성준 on 2023/02/22.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

extension Reactive where Base: UICollectionView {
    
    func itemSelected<T>(dataSource: CollectionViewSectionedDataSource<T>) -> ControlEvent<T.Item> {
        let source = self.itemSelected.map { indexPath in dataSource[indexPath] }
        return ControlEvent(events: source)
    }
    
}
