import UIKit

/**
 Класс наследник UIButton для получения нажатия UIControl.Event.touchUpInside в виде колбэка.
 Обработку нажатия создаёт при инициализации.
 */
public class ClousureButton: UIButton {

    private var action: (() -> Void)?

    public func on(action: @escaping () -> Void) {
        guard self.action == nil else {
            return
        }
        self.action = action
        addTarget(self, action: #selector(handleAction), for: .touchUpInside)
    }
    
    @objc
    private func handleAction() {
        self.action?()
    }
}
