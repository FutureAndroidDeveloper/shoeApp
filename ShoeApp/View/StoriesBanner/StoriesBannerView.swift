import UIKit
import SnapKit


class StoriesBannerView: UIView {
    
    private struct Constants {
        struct Image {
            static let bannerSize = CGSize(width: 0, height: 500)
            static let imageEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        }
        
        struct Info {
            static let titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            static let detailsEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        }
    }
    
    var showStroriesTapped: (([IGStory]) -> Void)?
    
    private let banner = UIImageView()
    private let titleLabel = UILabel()
    private let detailsButton = UIButton()
    
    private var model: StoriesBanner
    
    init(model: StoriesBanner) {
        self.model = model
        super.init(frame: .zero)
        build()
        bind()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func build() {
        addSubview(banner)
        banner.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.Image.imageEdgeInsets)
            $0.height.equalTo(Constants.Image.bannerSize.height)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(Constants.Info.titleEdgeInsets)
        }
        
        addSubview(detailsButton)
        detailsButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(Constants.Info.detailsEdgeInsets)
            $0.leading.trailing.equalToSuperview().inset(Constants.Info.detailsEdgeInsets)
        }
        detailsButton.addTarget(self, action: #selector(openStories), for: .touchUpInside)
    }
    
    private func bind() {
        banner.image = model.bannerImage
        titleLabel.text = model.title
        detailsButton.setTitle("Подробнее", for: .normal)
    }
    
    private func configureUI() {
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
    }
    
    private var viewModel: IGHomeViewModel = IGHomeViewModel()
    
    @objc
    private func openStories() {
        guard let stories = viewModel.getStories()?.otherStories else {
            fatalError("Cant load stories from JSON")
        }
        showStroriesTapped?(stories)
    }
    
}
