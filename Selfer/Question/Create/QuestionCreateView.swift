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
        self.setupKeyboardNotification()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updatePage(_ page: Int) {
        if page == 1 {
            self.questionTextViewLeadingConstraint?.update(offset: -self.bounds.width)
            self.answerTextView.becomeFirstResponder()
        } else {
            self.questionTextViewLeadingConstraint?.update(offset: 20)
            self.questionTextView.becomeFirstResponder()
        }
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    private struct ViewConstraint {
        
        static let questionTitle = "질문을 입력하세요"
        static let answerTitle = "응답을 입력하세요"
        
        static let textViewContainerColor = UIColor.white
        static let backgroundColor = UIColor.lightGray
        static let textViewFont = UIFont.systemFont(ofSize: 17, weight: .regular)
        static let textViewInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        static let textViewContentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        
    }
    
    private func setupLayout() {
        self.addSubview(self.addButton)
        self.addButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
            self.buttonBottomConstraint = make.bottom.equalToSuperview().offset(-20).constraint
        }
        
        self.addSubview(self.questionTextView)
        self.questionTextView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.width.equalToSuperview().offset(-40)
            make.bottom.equalTo(self.addButton.snp.top).offset(-20)
            self.questionTextViewLeadingConstraint = make.leading.equalToSuperview().offset(20).constraint
        }
        
        self.addSubview(self.answerTextView)
        self.answerTextView.snp.makeConstraints { make in
            make.top.bottom.width.equalTo(self.questionTextView)
            make.leading.equalTo(self.questionTextView.snp.trailing).offset(60)
        }
    }
    
    private func setupAttributes() {
        self.backgroundColor = ViewConstraint.backgroundColor
        
        self.questionTextView.do {
            $0.title = ViewConstraint.questionTitle
            $0.textContainerView.backgroundColor = ViewConstraint.textViewContainerColor
            $0.textView.font = ViewConstraint.textViewFont
            $0.textView.contentInset = ViewConstraint.textViewContentInset
            $0.updateTextViewInset(ViewConstraint.textViewInset)
        }
        
        self.answerTextView.do {
            $0.title = ViewConstraint.answerTitle
            $0.textContainerView.backgroundColor = ViewConstraint.textViewContainerColor
            $0.textView.font = ViewConstraint.textViewFont
            $0.textView.contentInset = ViewConstraint.textViewContentInset
            $0.updateTextViewInset(ViewConstraint.textViewInset)
        }
        
        self.addButton.do {
            $0.backgroundColor = .systemPink
        }
    }
    
    private func setupKeyboardNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }

        self.buttonBottomConstraint?.update(offset: -keyboardSize.height - 20)
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.layoutIfNeeded()
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        self.buttonBottomConstraint?.update(offset: -20)
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
    
    private var questionTextViewLeadingConstraint: Constraint?
    private var buttonBottomConstraint: Constraint?
    
    let questionTextView = CommonTextView(frame: .zero)
    let answerTextView = CommonTextView(frame: .zero)
    let addButton = UIButton(frame: .zero)
    
}

extension Reactive where Base: QuestionCreateView {
    
    var addButtonTap: ControlEvent<Void> {
        let source = base.addButton.rx.tap
        return ControlEvent(events: source)
    }
    
    var questionText: ControlEvent<String?> {
        let source = base.answerTextView.rx.text
        return ControlEvent(events: source)
    }
    
    var answerText: ControlEvent<String?> {
        let source = base.answerTextView.rx.text
        return ControlEvent(events: source)
    }
    
    var page: Binder<Int> {
        return Binder(self.base) { view, page in
            view.updatePage(page)
        }
    }
    
}
