import UIKit


class CollectionBannerView: UIView {
    
    private struct Constants {
        struct Content {
            static let betweenOffset: CGFloat = 15
            static let edgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            static let imageHeight: CGFloat = 300
        }
    }
    
    private let titleLabel = UILabel()
    private let collectionLabel = UILabel()
    private let bannerImageView = UIImageView()
    
    private let model: CollectionBanner
    
    init(model: CollectionBanner) {
        self.model = model
        super.init(frame: .zero)
        
        build()
        bind()
        setupStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func build() {
        addView(bannerImageView) {
            $0.edges.equalToSuperview()
            $0.height.equalTo(Constants.Content.imageHeight)
        }
        
        let contentContainer = UIView()
        contentContainer.buildVerticalStackOf([titleLabel, collectionLabel],
                                              betweenOffset: Constants.Content.betweenOffset,
                                              insets: Constants.Content.edgeInsets)
        
        bannerImageView.addView(contentContainer) {
            $0.leading.trailing.equalToSuperview()
            $0.center.equalToSuperview()
        }
        
    }
    
    private func bind() {
        bannerImageView.image = model.bannerImage
        titleLabel.text = model.title
        collectionLabel.text = model.collection
    }
    
    private func setupStyles() {
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 35)
        
        collectionLabel.textAlignment = .center
        collectionLabel.textColor = .white
        collectionLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        bannerImageView.contentMode = .scaleAspectFill
    }
    
}
