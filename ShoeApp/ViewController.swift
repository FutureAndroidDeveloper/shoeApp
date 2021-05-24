//
//  ViewController.swift
//  ShoeApp
//
//  Created by Кирилл Клименков on 8.05.21.
//

import UIKit

class ViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    
//    let productsOffer = ProductsOfferView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "FARFETCH"
//        navigationItem.rightBarButtonItem
        
        build()
    }

    private func build() {
        view.backgroundColor = .white
        scrollView.delaysContentTouches = false
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        let model = StoriesBanner(title: "Наручные часы", bannerImage: UIImage(named: "testImage")!)
        let banner = StoriesBannerView(model: model)
        banner.showStroriesTapped = showStories(_:)
        
        
        let contentContainer = UIView()
        let loginBanner = LoginBanner()
        
        let collectionModel = CollectionBanner(title: "Новый взгляд на преппи",
                                               collection: "В коллекции Polo Ralph Lauren",
                                               image: UIImage(named: "collectionBannerTest")!)
        
        let collectionBanner = CollectionBannerView(model: collectionModel)
        
        let productsOfferModel = ProductsOffer(title: "Специально для вас", subtitle: "Персонализированная подборка")
        let productsOffer = ProductsOfferView(model: productsOfferModel)
        
        productsOffer.productSelected = { [weak self] in
            let detailsViewController = ProductDetailsViewController()
            self?.navigationController?.pushViewController(detailsViewController, animated: true)
        }
        
        
        let pager = ActualPagerView()
        
        let header = MainHeaderView()
        
        let footerModel = MainFooter(image: UIImage(named: "testImage")!, buttonTitle: "Для нее")
        let footer = MainFooterView(model: footerModel)
        footer.swapButtonTap = reloadContent
        
        contentContainer.buildVerticalStackOf([header, loginBanner, collectionBanner, productsOffer, banner, pager, footer],
                                              betweenOffset: 50,
                                              insets: .zero)
        
        
        scrollView.addView(contentContainer) {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(0).priority(.low)
        }
    }
    
    private func showStories(_ stories: [IGStory]) {
        let storiesViewController = IGStoryPreviewController(stories: stories, handPickedStoryIndex: 0)
        
        present(storiesViewController, animated: true, completion: nil)
    }
    
    private func reloadContent() {
        print("Reload content now!")
    }
    
}

