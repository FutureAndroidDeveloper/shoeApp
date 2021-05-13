import UIKit


class MainHeaderView: UIView {
    
    private struct Constants {
        static let height: CGFloat = 50
    }
    
    private let titleLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        build()
        bind()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func build() {
        addView(titleLabel) {
            $0.center.equalToSuperview()
        }
        snp.makeConstraints {
            $0.height.equalTo(Constants.height)
        }
    }
    
    private func bind() {
        titleLabel.text = "Новые модели каждый день"
    }
    
    private func setStyles() {
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    }
    
}
