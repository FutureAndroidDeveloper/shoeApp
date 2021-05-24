//
//  ContactsCell.swift
//  HeaderExpandableCell
//
//  Created by Klimenkov, Kirill on 18.05.21.
//

import UIKit

class ContactsCell: UITableViewCell {

    static let ID = "ContactsCell"
    
    @IBOutlet weak var firstContactView: ContactView!
    @IBOutlet weak var secondContactView: ContactView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(firstModel: ContactModel, secondModel: ContactModel) {
        firstContactView.setModel(firstModel)
        secondContactView.setModel(secondModel)
    }
    
}
