//
//  IconedLabel.swift
//  HeaderExpandableCell
//
//  Created by Klimenkov, Kirill on 18.05.21.
//

import UIKit
import SnapKit

struct IconedLabelModel {
        
    enum IconAligment {
        case left
        case right
    }
    
    var title: String
    var icon: UIImage
    var aligment: IconAligment?
    var iconOffset: CGFloat?
    var iconSize: CGSize?
    
    init(title: String, icon: UIImage, aligment: IconAligment? = .left, offset: CGFloat? = nil, size: CGSize? = nil) {
        self.title = title
        self.icon = icon
        self.aligment = aligment
        self.iconOffset = offset
        self.iconSize = size
    }
    
}

class IconedLabel: UIView {
    
    private struct Constants {
        static let space = " "
        static let defaultIconOffset: CGFloat = 8
    }
        
    let label = UILabel()
    var iconDidTapped: (() -> Void)?
    
    private let gestureRecognizer = UITapGestureRecognizer()
    
    init() {
        super.init(frame: .zero)
        build()
    }
        
    init(model: IconedLabelModel) {
        super.init(frame: .zero)
        build()
        setModel(model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(_ model: IconedLabelModel) {
        let aligment = model.aligment ?? .left
        let offset = model.iconOffset ?? Constants.defaultIconOffset
        let size = model.iconSize ?? model.icon.size
        bind(title: model.title, icon: model.icon, aligment: aligment, offset: offset, size: size)
        addHandler()
    }
    
    private func build() {
        addSubview(label)
        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func addHandler() {
        label.removeGestureRecognizer(gestureRecognizer)
        gestureRecognizer.addTarget(self, action: #selector(didTapLabel(sender:)))
        label.addGestureRecognizer(gestureRecognizer)
        label.isUserInteractionEnabled = true
    }
    
    private func bind(title: String, icon: UIImage, aligment: IconedLabelModel.IconAligment, offset: CGFloat, size: CGSize) {
        let resultString = NSMutableAttributedString()

        // создание вложения
        let imageAttachment = NSTextAttachment()
        let y = (label.font.capHeight - icon.size.height).rounded() / 2
        imageAttachment.image = icon
        imageAttachment.bounds = CGRect(origin: CGPoint(x: 0, y: y), size: size)

        // обертка над вложением в виде строки
        let imageString = NSAttributedString(attachment: imageAttachment)
        let titleString = NSAttributedString(string: title)
        
        switch aligment {
        case .left:
            resultString.append(imageString)
            let space = NSAttributedString(string: Constants.space, attributes: [.kern: offset])
            resultString.append(space)
            resultString.append(titleString)
        case .right:
            resultString.append(titleString)
            let space = NSAttributedString(string: Constants.space, attributes: [.kern: offset])
            resultString.append(space)
            resultString.append(imageString)
        }

        label.attributedText = resultString
    }
    
    @objc
    private func didTapLabel(sender: UITapGestureRecognizer) {
        guard
            let index = label.characterIndexTapped(tap: sender),
            let _ = label.attributedText?.attribute(NSAttributedString.Key.attachment, at: index, effectiveRange: nil) as? NSTextAttachment else {
            return
        }
        iconDidTapped?()
    }
    
}


extension UILabel {
    func characterIndexTapped(tap: UITapGestureRecognizer) -> Int? {
        guard attributedText != nil else { return nil }
        // Create instances for NSLayoutManager, NSTextContainer, and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: .zero)
        let textStorage = NSTextStorage(attributedString: attributedText!)
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        textContainer.lineFragmentPadding = 0
        textContainer.lineBreakMode = lineBreakMode
        textContainer.maximumNumberOfLines = numberOfLines
        // Calculate the tap location in terms of character index
        let location = tap.location(in: self)
        let size = bounds.size
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (size.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (size.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        let locationOfTouchInTextContainer = CGPoint(x: location.x - textContainerOffset.x, y: location.y - textContainerOffset.y)
        return layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
    }
}
