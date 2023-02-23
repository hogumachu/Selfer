//
//  QuestionCreateViewController.swift
//  Selfer
//
//  Created by 홍성준 on 2023/02/22.
//

import UIKit
import SnapKit
import Then
import RxSwift
import ReactorKit

final class QuestionCreateViewController: UIViewController, View {
    
    typealias Reactor = QuestionCreateViewReactor
    
    init(reactor: QuestionCreateViewReactor) {
        defer { self.reactor = reactor }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCreateView()
    }
    
    func bind(reactor: QuestionCreateViewReactor) {
        self.rx.viewDidAppear
            .withUnretained(self)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { viewController, _ in viewController.createView.updatePage(0) })
            .disposed(by: self.disposeBag)
        
        self.createView.rx.addButtonTap
            .map { Reactor.Action.addButtonTap }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
            
        self.createView.rx.questionText
            .map { Reactor.Action.updateQuestion($0 ?? "") }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.createView.rx.answerText
            .map { Reactor.Action.updateAnswer($0 ?? "") }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.page }
        .skip(1)
        .distinctUntilChanged()
        .bind(to: self.createView.rx.page)
        .disposed(by: self.disposeBag)
    }
    
    private func setupCreateView() {
        self.view.addSubview(self.createView)
        self.createView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private let createView = QuestionCreateView(frame: .zero)
    var disposeBag = DisposeBag()
    
}
