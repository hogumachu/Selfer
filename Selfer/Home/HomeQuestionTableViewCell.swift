//
//  HomeQuestionTableViewCell.swift
//  Selfer
//
//  Created by 홍성준 on 2023/02/22.
//

import UIKit
import SnapKit
import Then

struct HomeQuestionTableViewCellModel {
    
    let title: String
    let subtitle: String
    
}

final class HomeQuestionTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLayout()
        self.setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private struct ViewConstraint {
        
        static let containerViewBackgroundColor = UIColor.lightGray
        static let containerViewCornerRadius: CGFloat = 8
        
        static let titleColor = UIColor.black
        static let titleFont = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        static let subtitleColor = UIColor.darkGray
        static let subtitleFont = UIFont.systemFont(ofSize: 17, weight: .regular)
        
    }
    
    func configure(_ model: HomeQuestionTableViewCellModel) {
        self.titleLabel.text = model.title
        self.subtitleLabel.text = model.subtitle
    }
    
    private func setupLayout() {
        self.contentView.addSubview(self.containerView)
        self.containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.containerView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(20)
        }
        
        self.containerView.addSubview(self.subtitleLabel)
        self.subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func setupAttributes() {
        self.containerView.do {
            $0.backgroundColor = ViewConstraint.containerViewBackgroundColor
            $0.layer.cornerRadius = ViewConstraint.containerViewCornerRadius
        }
        
        self.titleLabel.do {
            $0.textColor = ViewConstraint.titleColor
            $0.font = ViewConstraint.titleFont
        }
        
        self.subtitleLabel.do {
            $0.textColor = ViewConstraint.subtitleColor
            $0.font = ViewConstraint.subtitleFont
        }
    }
    
    private let containerView = UIView(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)
    private let subtitleLabel = UILabel(frame: .zero)
    
}
