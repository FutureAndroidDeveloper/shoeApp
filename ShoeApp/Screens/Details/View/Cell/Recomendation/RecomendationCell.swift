//
//  RecomendationCell.swift
//  HeaderExpandableCell
//
//  Created by Klimenkov, Kirill on 18.05.21.
//

import UIKit

struct RecomendationCellModel {
//    private let productModels: [RecomendationModel]
    
    var firstLineModels: [RecomendationModel] {
        let photo = UIImage(named: "saucony")!
        return [
            .init(title: "Saint Laurent", cost: "$604", productPhoto: photo),
            .init(title: "Saint Laurent", cost: "$532", productPhoto: photo),
        ]
    }
    
    var secondLineModels: [RecomendationModel] {
        let photo = UIImage(named: "saucony")!
        return [
            .init(title: "Maison Margiela", cost: "$463", productPhoto: photo),
            .init(title: "Veja", cost: "$161", productPhoto: photo),
        ]
    }
}

class RecomendationCell: UITableViewCell {
    
    private struct Constants {
        static let numberOfLines = 2
        static let itemsForRow = 2
    }
    
    static let ID = "RecomendationCell"
    
    private var recomendationViews: [RecomendationView] = []
    
    @IBOutlet weak var firstLineStack: UIStackView!
    @IBOutlet weak var secondLineStack: UIStackView!
    @IBOutlet weak var showAllButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setStyles()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(model: RecomendationCellModel) {
        let firstLineViews = firstLineStack.arrangedSubviews.compactMap { $0 as? RecomendationView }
        zip(model.firstLineModels, firstLineViews).forEach {
            $1.setModel($0)
        }
        
        
        let secondLineViews = secondLineStack.arrangedSubviews.compactMap { $0 as? RecomendationView }
        zip(model.secondLineModels, secondLineViews).forEach {
            $1.setModel($0)
        }
        
        firstLineStack.spacing = firstLineStack.frame.width / 6
        secondLineStack.spacing = secondLineStack.frame.width / 6
    }
    
    private func setStyles() {
        showAllButton.setTitleColor(.black, for: .normal)
        showAllButton.backgroundColor = .clear
        showAllButton.layer.cornerRadius = 5
        showAllButton.layer.borderWidth = 1
        showAllButton.layer.borderColor = UIColor.opaqueSeparator.cgColor
        showAllButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        selectionStyle = .none
//        signUpButton.titleLabel?.adjustsFontSizeToFitWidth = true
//
//        signInButton.setTitleColor(.white, for: .normal)
//        signInButton.backgroundColor = .black
//        signInButton.layer.cornerRadius = 5
    }
}
