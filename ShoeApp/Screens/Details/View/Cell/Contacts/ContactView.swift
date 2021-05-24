//
//  ContactView.swift
//  HeaderExpandableCell
//
//  Created by Klimenkov, Kirill on 18.05.21.
//

import UIKit

struct ContactModel {
    let icon: UIImage
    let title: String
    let handler: (() -> Void)
    
    init(title: String, icon: UIImage, handler: @escaping (() -> Void)) {
        self.icon = icon
        self.title = title
        self.handler = handler
    }
}

class ContactView: UIView {
    
    private struct Constants {
        static let iconSize = CGSize(width: 20, height: 20)
    }
    
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let tapRecognizer = UITapGestureRecognizer()
    
    private var model: ContactModel?
    
    init() {
        super.init(frame: .zero)
        build()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        build()
        setStyles()
    }
    
    func setModel(_ model: ContactModel) {
        self.model = model
        bind()
    }
    
    private func build() {
        iconImageView.snp.makeConstraints {
            $0.size.equalTo(Constants.iconSize)
        }
        let contentStack = UIStackView(arrangedSubviews: [iconImageView, titleLabel])
        contentStack.axis = .vertical
        contentStack.spacing = 4
        contentStack.alignment = .center
        
        addView(contentStack) {
            $0.center.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func bind() {
        guard let model = model else {
            return
        }
        iconImageView.image = model.icon
        titleLabel.text = model.title
        setHandler()
    }
    
    private func setStyles() {
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.opaqueSeparator.cgColor
    }
    
    private func setHandler() {
        self.removeGestureRecognizer(tapRecognizer)
        tapRecognizer.addTarget(self, action: #selector(handleTap))
        self.addGestureRecognizer(tapRecognizer)
    }
    
    @objc
    private func handleTap() {
        model?.handler()
    }
    
}
