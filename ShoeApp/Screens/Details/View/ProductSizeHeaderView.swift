//
//  ProductSizeHeaderView.swift
//  HeaderExpandableCell
//
//  Created by Klimenkov, Kirill on 15.05.21.
//

import UIKit

struct Lol {
    
}

struct ProductSizeHeader {
    let title: String
    let subtitle: String
    let cost: String
//    let availableSizes
}

class ProductSizeHeaderView: UIView {
    
    private struct Constants {
        struct Content {
            static let spacing: CGFloat = 6
            static let edgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)
        }
        
        struct Size {
            static let edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
            static let offset: CGFloat = 30
        }
    }
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let costLabel = UILabel()
    private let sizeView = ProductSizeView()
    
    private let model: ProductSizeHeader
    
    init(model: ProductSizeHeader) {
        self.model = model
        super.init(frame: .zero)
        build()
        bind()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeInfoAlpha(_ alpha: CGFloat) {
        titleLabel.alpha = alpha
        subtitleLabel.alpha = alpha
        costLabel.alpha = alpha
    }
    
    private func build() {
        let contentStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, costLabel])
        contentStack.axis = .vertical
        contentStack.alignment = .center
        contentStack.distribution = .equalSpacing
        contentStack.spacing = Constants.Content.spacing
        
        addSubview(contentStack)
        contentStack.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(Constants.Content.edgeInsets)
        }
        
        addSubview(sizeView)
        sizeView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(Constants.Size.edgeInsets)
            $0.top.equalTo(contentStack.snp.bottom).offset(Constants.Size.offset)
        }
    }
    
    private func bind() {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        costLabel.text = model.cost
    }
    
    private func setStyles() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        costLabel.font = UIFont.systemFont(ofSize: 14)
    }
    
}
