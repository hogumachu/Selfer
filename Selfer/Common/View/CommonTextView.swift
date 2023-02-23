//
//  CommonTextView.swift
//  Selfer
//
//  Created by 홍성준 on 2023/02/23.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

final class CommonTextView: UIView {
    
    var title: String? {
        get {  self.titleLabel.text }
        set {  self.titleLabel.text = newValue }
    }
    
    func updateTextViewInset(_ inset: UIEdgeInsets) {
        self.textView.snp.updateConstraints { make in
            make.edges.equalToSuperview().inset(inset)
        }
    }
    
    @discardableResult
    override func becomeFirstResponder() -> Bool {
        self.textView.becomeFirstResponder()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
        self.setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        self.addSubview(self.textContainerView)
        self.textContainerView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        self.textContainerView.addSubview(self.textView)
        self.textView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupAttributes() {
        self.titleLabel.do {
            $0.font = .systemFont(ofSize: 22, weight: .bold)
            $0.textAlignment = .center
        }
        
        self.textContainerView.do {
            $0.layer.cornerRadius = 16
        }
        
        self.textView.do {
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
        }
    }
    
    let titleLabel = UILabel(frame: .zero)
    let textContainerView = UIView(frame: .zero)
    let textView = UITextView(frame: .zero)
    
}

extension Reactive where Base: CommonTextView {
    
    var text: ControlEvent<String?> {
        let source = base.textView.rx.text
        return ControlEvent(events: source)
    }
    
}
