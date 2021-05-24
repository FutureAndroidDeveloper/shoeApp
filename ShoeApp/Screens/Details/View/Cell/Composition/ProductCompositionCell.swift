//
//  ProductCompositionCell.swift
//  HeaderExpandableCell
//
//  Created by Klimenkov, Kirill on 17.05.21.
//

import UIKit

struct ProductCompositionModel {
    let title: String
    let subtitle: String
}

struct ProductCompositionProvider {
    func getCompositionInfo(for product: Any) -> [ProductCompositionModel] {
        return [
            .init(title: "Состав", subtitle: "Акрил 10%"),
            .init(title: "Наружний состав", subtitle: "Полиамид 90%"),
            .init(title: "ID бренда", subtitle: "BK608HK17N")
        ]
    }
}

class ProductCompositionCell: UITableViewCell {
    static let ID = "ProductCompositionCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(model: ProductCompositionModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.subtitle
    }
}
