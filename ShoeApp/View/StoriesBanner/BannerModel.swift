import UIKit

protocol BannerModel {
    var title: String { get }
    var bannerImage: UIImage { get }
}


protocol CollectionBannerModel: BannerModel {
    var collection: String { get }
}
