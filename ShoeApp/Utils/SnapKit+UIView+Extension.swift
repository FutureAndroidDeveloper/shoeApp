import Foundation
import SnapKit

public extension UIView {
    
    @objc
    func buildVerticalStackOf(views: [UIView],
                              leftRightMargin: CGFloat = 0,
                              verticalPadding: CGFloat = 0,
                              verticalPaddingExceptEdges: Bool = false) {
        var lastView: UIView?
        for view in views {
            addSubview(view)
            
            view.snp.makeConstraints {
                
                if let lastView = lastView {
                    $0.top.equalTo(lastView.snp.bottom).offset(verticalPadding)
                }
                else {
                    $0.top.equalToSuperview().offset(verticalPaddingExceptEdges ? 0 : verticalPadding)
                }
                
                $0.width.equalToSuperview().inset(leftRightMargin)
                $0.centerX.equalToSuperview()
            }
            
            lastView = view
        }
        
        lastView?.snp.makeConstraints { $0.bottom.equalToSuperview().inset(verticalPaddingExceptEdges ? 0 : verticalPadding) }
    }
    
    func buildVerticalStackOf(_ views: [UIView], betweenOffset: CGFloat = 0, insets: UIEdgeInsets = .zero) {
        var lastView: UIView?
        for view in views {
            addSubview(view)
            
            view.snp.makeConstraints {
                
                if let lastView = lastView {
                    $0.top.equalTo(lastView.snp.bottom).offset(betweenOffset)
                }
                else {
                    $0.top.equalToSuperview().inset(insets.top)
                }
                
                $0.left.equalToSuperview().inset(insets.left)
                $0.right.equalToSuperview().inset(insets.right)
            }
            
            lastView = view
        }
        
        lastView?.snp.makeConstraints { $0.bottom.equalToSuperview().inset(insets.bottom) }
    }
    
    func buildHorizontalStackOf(views: [UIView],
                                equalWidth: Bool,
                                betweenOffset: CGFloat = 0,
                                insets: UIEdgeInsets = .zero) {
        var lastView: UIView?
        for view in views {
            addSubview(view)

            view.snp.makeConstraints {

                if let lastView = lastView {
                    $0.left.equalTo(lastView.snp.right).offset(betweenOffset)
                    if equalWidth {
                        $0.width.equalTo(lastView.snp.width)
                    }
                }
                else {
                    $0.left.equalToSuperview().offset(insets.left)
                }

                $0.top.equalToSuperview().offset(insets.top)
                $0.bottom.equalToSuperview().inset(insets.bottom)
                $0.height.equalToSuperview().inset(insets.top + insets.bottom)
            }
            lastView = view
        }
        lastView?.snp.makeConstraints { $0.right.equalToSuperview().inset(insets.right) }
    }
    
    @discardableResult
    func addView(_ view: UIView, constraints: (ConstraintMaker) -> Void) -> UIView {
        addSubview(view)
        view.snp.makeConstraints(constraints)
        return view
    }
}

public extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

public extension UIView {
    
    /**
     Переменная для доступа к safeAreaLayoutGuide при возможности (iOS 11+).
     В случае отсутствия возможности осуществляется доступ к self.snp.
     */
    var safeArea: ConstraintBasicAttributesDSL {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        }
        
        return self.snp
    }
    
}

public extension UIView {
    
    /**
     Проверка видимости представления на экрвне.
     
     - returns: true - представление полностью отображается на экране.
     */
    func isVisible() -> Bool {
        func isVisible(view: UIView, inView: UIView?) -> Bool {
            guard let inView = inView else {
                return true
            }
            
            let viewFrame = inView.convert(view.bounds, from: view)
            
            if inView.bounds.contains(viewFrame) {
                return isVisible(view: view, inView: inView.superview)
            }

            return false
        }
        return isVisible(view: self, inView: self.superview)
    }
    
}
