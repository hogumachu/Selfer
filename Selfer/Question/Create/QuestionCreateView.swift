//
//  QuestionCreateView.swift
//  Selfer
//
//  Created by 홍성준 on 2023/02/22.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

final class QuestionCreateView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
        self.setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private struct ViewConstraint {
        static let questionTextFieldPlaceholder = "질문을 입력하세요"
        
        
    }
    
    private func setupLayout() {
        self.addSubview(self.questionTextField)
        self.questionTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        self.addSubview(self.addButton)
        self.addButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        self.addSubview(self.answerTextView)
        self.answerTextView.snp.makeConstraints { make in
            make.top.equalTo(self.questionTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(self.addButton.snp.top).offset(-20)
        }
    }
    
    private func setupAttributes() {
        self.backgroundColor = .white
        
        self.questionTextField.do {
            $0.placeholder = ViewConstraint.questionTextFieldPlaceholder
        }
        
        self.addButton.do {
            $0.backgroundColor = .systemPink
        }
    }
    
    let questionTextField = UITextField(frame: .zero)
    let answerTextView = UITextView(frame: .zero)
    let addButton = UIButton(frame: .zero)
    
}

extension Reactive where Base: QuestionCreateView {
    
    var addButtonTap: ControlEvent<Void> {
        let source = base.addButton.rx.tap
        return ControlEvent(events: source)
    }
    
    var questionText: ControlEvent<String?> {
        let source = base.questionTextField.rx.text
        return ControlEvent(events: source)
    }
    
    var answerText: ControlEvent<String?> {
        let source = base.answerTextView.rx.text
        return ControlEvent(events: source)
    }
    
}
