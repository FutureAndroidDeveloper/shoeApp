//
//  RecomendationView.swift
//  HeaderExpandableCell
//
//  Created by Klimenkov, Kirill on 18.05.21.
//

import UIKit

struct RecomendationModel {
    let title: String
    let cost: String
    let productPhoto: UIImage
}

class RecomendationView: UIView {
    
    private let productImageView = UIImageView()
    private let productTitleLabel = UILabel()
    private let productCostLabel = UILabel()
    
    private var model: RecomendationModel?
    
    init() {
        super.init(frame: .zero)
        build()
        bind()
        setStyles()
    }
    
    init(model: RecomendationModel) {
        self.model = model
        super.init(frame: .zero)
        build()
        bind()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        build()
        bind()
        setStyles()
    }
    
    func setModel(_ model: RecomendationModel) {
        self.model = model
        bind()
    }
    
    private func build() {
        addSubview(productImageView)
        productImageView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(productImageView.snp.width)
        }
        
        let productInfoContainer = UIView()
        productInfoContainer.buildVerticalStackOf([productTitleLabel, productCostLabel],
                                                  betweenOffset: 8,
                                                  insets: .zero)
        
        addView(productInfoContainer) {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(productImageView.snp.bottom).offset(0)
        }
        
    }
    
    private func bind() {
        productImageView.image = model?.productPhoto
        productTitleLabel.text = model?.title
        productCostLabel.text = model?.cost
    }
    
    private func setStyles() {
        productTitleLabel.textAlignment = .center
        productTitleLabel.font = UIFont.boldSystemFont(ofSize: 13)
        
        productCostLabel.textAlignment = .center
        productCostLabel.font = UIFont.systemFont(ofSize: 14)
    }
    
}
