//
//  SizePicker.swift
//  ShoeApp
//
//  Created by Klimenkov, Kirill on 24.05.21.
//

import UIKit
import SnapKit

class SizePickerView: UIView {
    
    private struct Constants {
        static let numberOfComponents = 1
        static let rowHeight: CGFloat = 35
        static let emptyNumberOfRows = 0
        static let firstComponentIndex = 0
    }
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var saveButton: UIButton!
    
    var saveButtonTapped: (() -> Void)?
        
    private var model: ProductNotificationSizeModel?
    
    init(model: ProductNotificationSizeModel) {
        super.init(frame: .zero)
        self.model = model
        commonInit()
        setStyles()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        setStyles()
    }
    
    func getSelectedSize() -> String? {
        let row = pickerView.selectedRow(inComponent: Constants.firstComponentIndex)
        return model?.sizes[row]
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("SizePickerView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    private func setStyles() {
        saveButton.layer.cornerRadius = 5
    }
    
    @IBAction func saveTapped(_ sender: UIButton) {
        saveButtonTapped?()
    }
    
}


extension SizePickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return Constants.numberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let model = self.model else {
            return Constants.emptyNumberOfRows
        }
        return model.sizes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let model = self.model else {
            return nil
        }
        return model.sizes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return Constants.rowHeight
    }
    
}
