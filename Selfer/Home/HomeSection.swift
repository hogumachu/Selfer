//
//  HomeSection.swift
//  Selfer
//
//  Created by 홍성준 on 2023/02/22.
//

import RxDataSources

struct HomeSection {
    
    var items: [HomeItem]
    
}

enum HomeItem {
    
    case questionModel(HomeQuestionTableViewCellModel)
    
}

extension HomeSection: SectionModelType {
    
    init(original: HomeSection, items: [HomeItem]) {
        self = original
        self.items = items
    }
    
}
