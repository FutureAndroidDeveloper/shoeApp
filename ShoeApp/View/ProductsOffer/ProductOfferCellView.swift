
import UIKit
import FaveButton

class ProductOfferCellView: UICollectionViewCell {
    static let reuseIdentifier = "ProductOfferCellView"
    
    static let myHeight: CGFloat = 320
    
    private let productImageView = UIImageView()
    private let seasonLabel = UILabel()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let costLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        build()
        setupStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func build() {
        contentView.addView(productImageView) {
            $0.top.leading.trailing.equalToSuperview()
//            $0.edges.equalToSuperview()
//            $0.height.equalTo(100)
            $0.height.equalToSuperview().dividedBy(1.5)
        }
        
        let faveButton = FaveButton(frame: .zero, faveIconNormal: UIImage(named: "star"))
        faveButton.delegate = self
        productImageView.addView(faveButton) {
            $0.top.trailing.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 0))
            $0.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        let infoContainer = UIView()
        infoContainer.buildVerticalStackOf([seasonLabel, titleLabel, descriptionLabel],
                                           betweenOffset: 4,
                                           insets: .zero)
        
        let contentContainer = UIView()
        contentContainer.buildVerticalStackOf([infoContainer, costLabel],
                                              betweenOffset: 12,
                                              insets: .zero)
        
        contentView.addView(contentContainer) {
//            $0.top.equalTo(productImageView.snp.bottom).inset(UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0))
//            $0.top.equalTo(productImageView.snp.bottom).offset(30)
//            $0.top.equalTo(productImageView.snp.bottom).inset(30)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    func bind(model: ProductOfferCell) {
        productImageView.image = model.image
        seasonLabel.text = model.season
        titleLabel.text = model.name
        descriptionLabel.text = model.productDescription
        costLabel.text = model.cost
    }
    
    private func setupStyles() {
        //        productImageView.contentMode = .scaleAspectFit
        //        productImageView.contentMode = .scaleToFill
        productImageView.contentMode = .scaleAspectFill
        
        seasonLabel.textAlignment = .center
        seasonLabel.textColor = .lightGray
        seasonLabel.font = UIFont.systemFont(ofSize: 14)
        
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        
        costLabel.font = UIFont.systemFont(ofSize: 14)
        costLabel.textAlignment = .center
    }
    
}

extension ProductOfferCellView: FaveButtonDelegate {
    func faveButton(_ faveButton: FaveButton, didSelected selected: Bool) {
        print("is selected = \(selected)")
    }
    
    func faveButtonDotColors(_ faveButton: FaveButton) -> [DotColors]? {
        return [(UIColor.blue, UIColor.red)]
    }
    
}
