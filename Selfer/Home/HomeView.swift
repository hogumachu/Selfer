//
//  HomeView.swift
//  Selfer
//
//  Created by 홍성준 on 2023/02/22.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

final class HomeView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
        self.setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.addSubview(self.addButton)
        self.addButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 50, height: 50))
            make.trailing.bottom.equalToSuperview().inset(30)
        }
        
        self.addSubview(self.loadingView)
        self.loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupAttributes() {
        self.tableView.do {
            $0.registerCell(cell: HomeQuestionTableViewCell.self)
        }
        
        self.loadingView.do {
            $0.backgroundColor = .black.withAlphaComponent(0.8)
        }
        
        self.addButton.do {
            $0.backgroundColor = .systemPink
        }
    }
    
    let tableView = UITableView(frame: .zero)
    let addButton = UIButton(frame: .zero)
    let loadingView = UIView(frame: .zero)
    
}

extension HomeView: Loadable {
    
    func showLoading() {
        self.loadingView.isHidden = false
    }
    
    func hideLoading() {
        self.loadingView.isHidden = true
    }
    
}

extension Reactive where Base: HomeView {
    
    var addButtonTap: ControlEvent<Void> {
        let soruce = base.addButton.rx.tap
        return ControlEvent(events: soruce)
    }
    
}
