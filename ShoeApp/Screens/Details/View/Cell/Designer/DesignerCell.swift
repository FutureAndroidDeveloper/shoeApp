//
//  DesignerCell.swift
//  HeaderExpandableCell
//
//  Created by Klimenkov, Kirill on 17.05.21.
//

import UIKit

class DesignerCell: UITableViewCell {
    static let ID = "DesignerCell"

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var collectionView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setStyle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(text: String) {
        descriptionLabel.text = text
    }
    
    private func setStyle() {
        collectionView.layer.cornerRadius = 5
        collectionView.layer.borderWidth = 1
        collectionView.layer.borderColor = UIColor.opaqueSeparator.cgColor
        selectionStyle = .none
    }
}
