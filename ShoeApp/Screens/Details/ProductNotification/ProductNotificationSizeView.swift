//
//  ProductNotificationSizeView.swift
//  ShoeApp
//
//  Created by Klimenkov, Kirill on 24.05.21.
//

import UIKit

struct ProductNotificationSizeModel {
    let sizes: [String]
    
    var placeholder: String? {
        if sizes.count == 1 {
            return "Всего один размер"
        } else if sizes.count > 1 {
            return "Выберите размер"
        } else {
            return nil
        }
    }
    
}

class ProductNotificationSizeView: UIView {
    
    private struct Constants {
        static let height: CGFloat = 35
        
        struct SizeLabel {
            static let edgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 8)
        }
        
        struct Icon {
            static let edgeInsets = UIEdgeInsets(top: 8, left: 6, bottom: 8, right: 6)
        }
        
        struct Layer {
            static let borderWidth: CGFloat = 0.8
            static let borderColor = UIColor.opaqueSeparator.cgColor
            static let cornerRadius: CGFloat = 5
        }
    }
    
    var sizeTapped: (() -> Void)?
    
    private let sizeLabel = EdgeInsetLabel()
    private let iconView = UIButton()
    private let tapRecognizer = UITapGestureRecognizer()
    private var model: ProductNotificationSizeModel?
    
    init() {
        super.init(frame: .zero)
        build()
        addTapListener()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        build()
        addTapListener()
        setStyles()
    }
    
    func bind(_ model: ProductNotificationSizeModel) {
        sizeLabel.text = model.placeholder
        self.model = model
    }
    
    func setSize(_ size: String) {
        sizeLabel.text = size
    }
    
    private func build() {
        addSubview(sizeLabel)
        sizeLabel.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.height.equalTo(Constants.height)
        }
        
        iconView.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        iconView.isUserInteractionEnabled = false
        addSubview(iconView)
        iconView.snp.makeConstraints {
            $0.trailing.top.bottom.equalToSuperview()
            $0.leading.equalTo(sizeLabel.snp.trailing)
            $0.height.equalTo(Constants.height)
        }
    }
    
    private func setStyles() {
        configureLayer(of: sizeLabel, corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner])
        sizeLabel.textInsets = Constants.SizeLabel.edgeInsets

        configureLayer(of: iconView, corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        iconView.tintColor = .black
        iconView.contentEdgeInsets = Constants.Icon.edgeInsets
    }
    
    private func configureLayer(of view: UIView, corners: CACornerMask? = nil) {
        view.layer.borderWidth = Constants.Layer.borderWidth
        view.layer.borderColor = Constants.Layer.borderColor
        view.layer.cornerRadius = Constants.Layer.cornerRadius
        view.layer.maskedCorners = corners ?? []
        view.backgroundColor = .clear
        view.clipsToBounds = true
    }
    
    private func addTapListener() {
        tapRecognizer.addTarget(self, action: #selector(handleTap))
        addGestureRecognizer(tapRecognizer)
    }
    
    @objc
    private func handleTap() {
        sizeTapped?()
    }
    
}
