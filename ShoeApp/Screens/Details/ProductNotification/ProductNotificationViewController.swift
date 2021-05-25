//
//  ProductNotificationViewController.swift
//  ShoeApp
//
//  Created by Klimenkov, Kirill on 24.05.21.
//

import UIKit
import BottomPopup

class ProductNotificationViewController: UIViewController {

    @IBOutlet weak var sizeView: ProductNotificationSizeView!
    @IBOutlet weak var pushSwitch: UISwitch!
    
    private var pickerController: BottomPickerViewController?
    private var size: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Сообщите, когда товар появится"
        bind()
    }
    
    private func bind() {
        let model = ProductNotificationSizeModel(sizes: ["1", "3", "8", "2", "7", "4", "5"])
        sizeView.bind(model)
        sizeView.sizeTapped = presentPicker
        
        pickerController = BottomPickerViewController(model: model)
        pickerController?.pickedSize = { [weak self] in
            guard let self = self else {
                return
            }
            self.size = $0
            self.sizeView.setSize($0)
            self.pushSwitch.setOn(true, animated: true)
            self.pushChanged(self.pushSwitch)
        }
    }

    @IBAction func pushChanged(_ sender: UISwitch) {
        switch sender.isOn {
        case true:
            if let _ = self.size {
                // save notification
            } else {
                sender.setOn(false, animated: true)
                presentPicker()
            }
            
        case false:
            print("off")
            // remove notification
        }
    }
    
    private func presentPicker() {
        guard let viewController = pickerController else {
            return
        }
        present(viewController, animated: true, completion: nil)
    }
    
}
