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
        // TODO: - Bind View & Reactor
    }
    
    private func setupHomeView() {
        self.view.addSubview(self.homeView)
        self.homeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private let homeView = HomeView(frame: .zero)
    var disposeBag = DisposeBag()
    
}
