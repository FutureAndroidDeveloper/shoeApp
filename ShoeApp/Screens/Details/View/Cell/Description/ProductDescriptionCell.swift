import UIKit

struct ProductDescriptionModel {
    let productDescription: String
    let productId: String
    let productColor: String
    
    func getHeight(for width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 14)
        let height = productDescription.heightWithConstrainedWidth(width: width - 20, font: font)
        let const: CGFloat = 150
        
        return height + const
    }
}

class ProductDescriptionCell: UITableViewCell {
    static let ID = "ProductDescriptionCell"
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var idModelLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    
    private var model: ProductDescriptionModel?
    
    func bind(model: ProductDescriptionModel) {
        self.model = model
        descriptionLabel.text = model.productDescription
        idModelLabel.text = model.productId
        colorLabel.text = model.productColor
        setStyles()
    }

    private func setStyles() {
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        selectionStyle = .none
    }
}

extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                                            attributes: [.font: font],
                                            context: nil)
        return boundingBox.height
    }
}

extension UINavigationItem {

  func setTitle(_ title: String, subtitle: String) {
    let appearance = UINavigationBar.appearance()
    let textColor = appearance.titleTextAttributes?[NSAttributedString.Key.foregroundColor] as? UIColor ?? .black

    let titleLabel = UILabel()
    titleLabel.text = title
    titleLabel.font = .preferredFont(forTextStyle: UIFont.TextStyle.headline)
    titleLabel.textColor = textColor

    let subtitleLabel = UILabel()
    subtitleLabel.text = subtitle
    subtitleLabel.font = .preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
    subtitleLabel.textColor = textColor

    let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
    stackView.distribution = .equalCentering
    stackView.alignment = .center
    stackView.axis = .vertical

    self.titleView = stackView
  }
}
