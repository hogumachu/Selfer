//
//  HomeViewController.swift
//  Selfer
//
//  Created by 홍성준 on 2023/02/22.
//

import UIKit
import SnapKit
import Then
import ReactorKit
import RxCocoa
import RxDataSources

final class HomeViewController: UIViewController, View {
    
    typealias Reactor = HomeViewReactor
    
    init(reactor: HomeViewReactor) {
        defer { self.reactor = reactor }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupHomeView()
    }
    
    func bind(reactor: HomeViewReactor) {
        self.rx.viewDidLoad
            .map { Reactor.Action.refresh }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.isLoading }
        .distinctUntilChanged()
        .bind(to: self.homeView.rx.isLoading)
        .disposed(by: self.disposeBag)
        
        self.homeView.tableView.rx
            .setDelegate(self)
            .disposed(by: self.disposeBag)
        
        self.homeView.tableView.rx
            .itemSelected
            .withUnretained(self.homeView.tableView)
            .subscribe(onNext: { tableView, indexPath in
                tableView.deselectRow(at: indexPath, animated: false)
            })
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.sections }
        .bind(to: self.homeView.tableView.rx.items(dataSource: self.dataSource))
        .disposed(by: self.disposeBag)
    }
    
    private func setupHomeView() {
        self.view.addSubview(self.homeView)
        self.homeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private let dataSource = RxTableViewSectionedReloadDataSource<HomeSection>(configureCell: { _, tableView, indexPath, item in
        switch item {
        case .questionModel(let model):
            guard let cell = tableView.dequeueReusableCell(cell: HomeQuestionTableViewCell.self, for: indexPath) else {
                return UITableViewCell()
            }
            cell.configure(model)
            return cell
        }
    })
    
    private let homeView = HomeView(frame: .zero)
    var disposeBag = DisposeBag()
    
}

extension HomeViewController: UITableViewDelegate { }
