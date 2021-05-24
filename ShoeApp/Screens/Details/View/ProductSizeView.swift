//
//  ProductSizeView2.swift
//  HeaderExpandableCell
//
//  Created by Klimenkov, Kirill on 17.05.21.
//

import UIKit
import PinterestSegment

class ProductSizeView: UIView {
    
    private struct Constants {
        static let height: CGFloat = 35
        
        struct SizeTable {
            static let edgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        }
        
        struct Notification {
            static let edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        }
    }

    
    private let segment = PinterestSegment()
    private let sizeTableLabel = IconedLabel()
    private let notificationLabel = IconedLabel()
    
    init() {
        super.init(frame: .zero)
        build()
        bind()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func build() {
        
        addSubview(sizeTableLabel)
        sizeTableLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(Constants.SizeTable.edgeInsets)
        }
        
        addSubview(notificationLabel)
        notificationLabel.snp.makeConstraints {
            $0.trailing.top.equalToSuperview().inset(Constants.Notification.edgeInsets)
        }
        
        addSubview(segment)
        segment.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.size.equalTo(Constants.height)
        }
        
        segment.valueChange = { index in
          print(index)
        }
    }
    
    private func bind() {
        segment.titles = ["35 RU", "35.5 RU", "36 RU", "36.5 RU", "37 RU", "37.5 RU", "38 RU", "38.5 RU", "39 RU", "39.5 RU", "40 RU"]
        
//        segment.titles = ["35 RU", "LOL"]

        sizeTableLabel.setModel(.init(title: "Размер", icon: UIImage(named: "ruler")!, aligment: .right))
        sizeTableLabel.iconDidTapped = {
            print("size tapped")
        }
        
        notificationLabel.setModel(.init(title: "Нет нужного размера?", icon: UIImage(named: "notification")!, aligment: .right))
        notificationLabel.iconDidTapped = {
            print("notification tapped")
        }
    }
    
    private func setStyles() {
        var style = PinterestSegmentStyle()
        style.indicatorColor = UIColor(white: 0.95, alpha: 1)
        style.titleMargin = 15
        style.titlePendingHorizontal = 14
        style.titlePendingVertical = 14
        style.titleFont = UIFont.boldSystemFont(ofSize: 14)
        style.normalTitleColor = UIColor.darkGray
        style.selectedTitleColor = UIColor.black
        segment.style = style
        
        sizeTableLabel.label.font = UIFont.systemFont(ofSize: 14)
        notificationLabel.label.font = UIFont.systemFont(ofSize: 14)
    }
    
}

