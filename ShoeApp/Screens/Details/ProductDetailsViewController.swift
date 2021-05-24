//
//  ProductDetailsViewController.swift
//  ShoeApp
//
//  Created by Klimenkov, Kirill on 24.05.21.
//

import UIKit
import ExpandableCell
import MXParallaxHeader
import FSPagerView
import SnapKit

class ProductDetailsViewController: UIViewController {

    private var token: NSKeyValueObservation?
    
    private let tableView = ExpandableTableView(frame: .zero, style: .grouped)
    private let pagerView = FSPagerView()
    private let pageControl = FSPageControl()
    
    private var provider: ProductCellProvider!
    
    let header = ProductSizeHeaderView(model: ProductSizeHeader(title: "Off-White", subtitle: "футболка Caravaggio Boy", cost: "$500"))
    
    let compositionModel = ProductCompositionProvider().getCompositionInfo(for: "MyProduct")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let descrModel = ProductDescriptionModel(productDescription: "Description Text sooo long that it can take a lot of free space.", productId: "Product ID: Random ID HERE", productColor: "Color: Black")
        
        
        let provModel = ProductDetailsViewModel(descriptionModel: descrModel,
                                                compositionModels: compositionModel,
                                                designerText: "Text about designer")
        provider = ProductCellProvider(viewModel: provModel)
        provider.headerView = header
        
        view.backgroundColor = .white
        pagerView.backgroundColor = .white
        tableView.backgroundColor = .white
        
        pagerView.dataSource = self
        pagerView.delegate = self
        
        tableView.expandableDelegate = provider
        tableView.animation = .automatic
        tableView.separatorStyle = .none
        
        tableView.register(UINib(nibName: "ProductDescriptionCell", bundle: nil), forCellReuseIdentifier: ProductDescriptionCell.ID)
        tableView.register(UINib(nibName: "ProductCompositionCell", bundle: nil), forCellReuseIdentifier: ProductCompositionCell.ID)
        tableView.register(UINib(nibName: "DesignerCell", bundle: nil), forCellReuseIdentifier: DesignerCell.ID)
        tableView.register(UINib(nibName: "ExpandableDescriptionCell", bundle: nil), forCellReuseIdentifier: ExpandableDescriptionCell.ID)
        tableView.register(UINib(nibName: "RecomendationCell", bundle: nil), forCellReuseIdentifier: RecomendationCell.ID)
        tableView.register(UINib(nibName: "ContactsCell", bundle: nil), forCellReuseIdentifier: ContactsCell.ID)
        
        build()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        token = tableView.parallaxHeader.observe(\.progress) { [weak self] object, change in
            guard let self = self else {
                return
            }
            
            let navHeight = self.navigationController?.navigationBar.frame.height ?? 0
            let percentage = navHeight / self.tableView.parallaxHeader.height
            
            
            if (0...percentage).contains(object.progress) {
                self.header.changeInfoAlpha(object.progress / percentage)
                self.navigationItem.titleView = nil
                let appearance = self.navigationController?.navigationBar.standardAppearance
                appearance?.backgroundColor = .clear
            }
            
            if (percentage...1).contains(object.progress) {
                self.header.changeInfoAlpha(1)
                self.navigationItem.titleView?.alpha = 0
            }
            
            if object.progress.isZero {
                self.navigationItem.setTitle("Santoni", subtitle: "$589")
                let appearance = self.navigationController?.navigationBar.standardAppearance
                appearance?.backgroundColor = .white
            }
        }
        
        tableView.open(at: .init(row: 0, section: 0))
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.pagerView.itemSize = CGSize(width: view.frame.width,
                                         height: 350)
    }
    
    private func build() {
        
        // Create a pager view
        pagerView.interitemSpacing = 20
        pagerView.isInfinite = true
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        
        let container = UIView()
        
        container.addSubview(pagerView)
        pagerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width)
        }
        pageControl.numberOfPages = 3
        pageControl.setFillColor(.lightGray, for: .normal)
        pageControl.setFillColor(.black, for: .selected)
        pageControl.interitemSpacing = 20
        pageControl.setPath(UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)), for: .normal)
        pageControl.setPath(UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)), for: .selected)
        
        
        pagerView.addSubview(pageControl)
        pageControl.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.centerX.equalToSuperview()
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        let standard = UINavigationBarAppearance()
        standard.configureWithTransparentBackground()
        standard.backgroundColor = .clear
        standard.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.standardAppearance = standard
        
        tableView.expansionStyle = .multi
        tableView.parallaxHeader.view = container
        tableView.parallaxHeader.height = 350
        tableView.parallaxHeader.mode = .fill
        tableView.parallaxHeader.minimumHeight = 0
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

// MARK: - FSPagerViewDataSource, FSPagerViewDelegate
extension ProductDetailsViewController: FSPagerViewDataSource, FSPagerViewDelegate {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 3
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: "banner")
        return cell
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControl.currentPage = pagerView.currentIndex
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: false)
    }
}
