//
//  ExpandableDescriptionCell.swift
//  ShoeApp
//
//  Created by Klimenkov, Kirill on 24.05.21.
//

import UIKit
import ExpandableCell

class ExpandableDescriptionCell: ExpandableCell {
    
    private struct Constants {
        struct Arrow {
            static let rightMargin: CGFloat = 40
        }
    }
    
    static let ID = "ExpandableDescriptionCell"
    static let defaultHeight: CGFloat = 50

    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(title: String) {
        titleLabel.text = title
    }
    
    private func setup() {
        arrowImageView.image = UIImage(systemName: "chevron.down")
        tintColor = .black
        rightMargin = Constants.Arrow.rightMargin
        selectionStyle = .none
    }
    
}
