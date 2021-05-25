//
//  BottomPickerViewController.swift
//  ShoeApp
//
//  Created by Klimenkov, Kirill on 25.05.21.
//

import UIKit
import BottomPopup

class BottomPickerViewController: BottomPopupViewController, BottomPopupDelegate {
    
    var pickedSize: ((String) -> Void)?
    
    private let sizePicker: SizePickerView
    private let model: ProductNotificationSizeModel
        
    init(model: ProductNotificationSizeModel) {
        self.model = model
        sizePicker = SizePickerView(model: model)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupDelegate = self
        build()
        setStyles()
    }
    
    private func build() {
        view.addView(sizePicker) {
            $0.edges.equalToSuperview()
        }
        
        sizePicker.saveButtonTapped = {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func setStyles() {
        view.backgroundColor = .white
    }
    
    // MARK: - BottomPopupDelegate

    func bottomPopupDidDismiss() {
        guard let size = sizePicker.getSelectedSize() else {
            return
        }
        pickedSize?(size)
    }
    
}
