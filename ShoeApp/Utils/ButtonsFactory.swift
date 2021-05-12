import UIKit


/**
 Фабрика для создания кнопок.
 */
class ButtonsFactory {
    
    /**
     Выравнивание кнопки IconedButtonView в контейнере.
     */
    enum Alignment {
        case
        
        /**
         По левому краю.
         */
        left,
             
        /**
         По центру.
         */
        center,
            
        /**
         По ширине.
         */
        justify
    }
    
    
    /**
     Создать кнопку c иконкой без текста.
     
     - Parameters:
        - icon: Иконка для всех состояний.
        - onTap: Обработчик нажатия на кнопку.
     
     - Returns: кнопка в вью-контейнере (необходим для отображения тени).
     */
    static func createIconedButton(icon: UIImage, _ onTap: @escaping () -> Void) -> UIView {
        let imageView = UIImageView(image: icon)
        let view = ClousureButton(type: .roundedRect)
        view.on {
            onTap()
        }
        
        view.addView(imageView) {
            $0.edges.equalToSuperview()
        }
        return createContainer(view, .justify)
    }
    
    private static func createContainer(_ embeddedView: UIView, _ alignment: Alignment) -> UIView {
        let container = UIView()
        
        container.addView(embeddedView) {
            $0.top.bottom.equalToSuperview()
            
            if alignment == .left {
                $0.leading.equalToSuperview()
                $0.trailing.lessThanOrEqualToSuperview()
            }
            else if alignment == .center {
                $0.leading.greaterThanOrEqualToSuperview()
                $0.trailing.lessThanOrEqualToSuperview()
                $0.centerX.equalToSuperview()
            }
            else if alignment == .justify {
                $0.leading.trailing.equalToSuperview()
            }
        }
        
        return container
    }
    
}
