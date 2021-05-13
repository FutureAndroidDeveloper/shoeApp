import UIKit


class MainFooterView: UIView {
    
    private struct Constants {
        static let height: CGFloat = 150
    }
    
    var swapButtonTap: (() -> Void)?
    
    private let backgroundImageView = UIImageView()
    private let swapButton = UIButton()
    
    private let model: MainFooter
    
    init(model: MainFooter) {
        self.model = model
        super.init(frame: .zero)
        build()
        bind()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func build() {
        addView(backgroundImageView) {
            $0.edges.equalToSuperview()
        }
        
        backgroundImageView.addView(swapButton) {
            $0.center.equalToSuperview()
        }
        swapButton.addTarget(self, action: #selector(swapButtonTapped), for: .touchUpInside)
        
        snp.makeConstraints {
            $0.height.equalTo(Constants.height)
        }
    }
    
    private func bind() {
        backgroundImageView.image = model.image
        swapButton.setTitle(model.buttonTitle, for: .normal)
    }
    
    private func setStyles() {

        swapButton.contentEdgeInsets = UIEdgeInsets(top: 15, left: 30, bottom: 15, right: 30)
        swapButton.setTitleColor(.black, for: .normal)
        swapButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        swapButton.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        
        swapButton.layer.cornerRadius = 5
    }
    
    @objc
    private func swapButtonTapped() {
        swapButtonTap?()
    }
    
}
