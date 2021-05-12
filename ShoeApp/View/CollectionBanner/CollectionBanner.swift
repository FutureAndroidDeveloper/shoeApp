import UIKit


struct CollectionBanner: CollectionBannerModel{
    var bannerImage: UIImage
    var collection: String
    var title: String
    
    init(title: String, collection: String, image: UIImage) {
        self.title = title.uppercased()
        self.collection = collection
        self.bannerImage = image
    }
}
