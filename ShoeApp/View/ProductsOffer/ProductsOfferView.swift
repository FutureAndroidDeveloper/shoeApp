import UIKit
import CenteredCollectionView

class ProductsOfferView: UIView {
    let centeredCollectionViewFlowLayout = CenteredCollectionViewFlowLayout()
    let collectionView: UICollectionView
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let shoppingButton = UIButton()
    
    // The width of each cell with respect to the screen.
    // Can be a constant or a percentage.
    let cellPercentWidth: CGFloat = 0.7
    
    private let model: ProductsOffer
    
    init(model: ProductsOffer) {
        self.model = model
        collectionView = UICollectionView(centeredCollectionViewFlowLayout: centeredCollectionViewFlowLayout)
        super.init(frame: .zero)
        build()
        bind()
        setupStyles()
        collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        print(bounds.width)
//        centeredCollectionViewFlowLayout.itemSize = CGSize(
//          width: bounds.width * cellPercentWidth,
//            height: (bounds.width * cellPercentWidth) * 1.1
//        )
        
        centeredCollectionViewFlowLayout.itemSize = CGSize(
          width: bounds.width * cellPercentWidth,
            height: ProductOfferCellView.myHeight
        )
        
//        centeredCollectionViewFlowLayout.itemSize = CGSize(
//          width: bounds.width * cellPercentWidth,
//            height: bounds.height 
//        )
        
//        centeredCollectionViewFlowLayout.itemSize = CGSize(width: 250, height: 250)
        centeredCollectionViewFlowLayout.minimumLineSpacing = centeredCollectionViewFlowLayout.itemSize.width / 10
    }
    
    private func build() {
        let screenSize: CGRect = UIScreen.main.bounds
        let cellWidth = screenSize.width * cellPercentWidth
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let titlesStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        titlesStackView.axis = .vertical
        titlesStackView.spacing = 10
        titlesStackView.alignment = .center
        
        addView(titlesStackView) {
            $0.top.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0))
        }
        
        addView(collectionView) {
            $0.top.equalTo(titlesStackView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
//            $0.edges.equalToSuperview()
            $0.height.equalTo(320)
        }
        
        addView(shoppingButton) {
            $0.top.equalTo(collectionView.snp.bottom).offset(30)
            $0.bottom.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 30, right: 20))
        }
        
        let separatorView = UIView()
        UIColor.black.withAlphaComponent(0.5)
        
        separatorView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        separatorView.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        
        addView(separatorView) {
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        collectionView.register(ProductOfferCellView.self, forCellWithReuseIdentifier: ProductOfferCellView.reuseIdentifier)
        
        // Get rid of scrolling indicators
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.backgroundColor = .clear
//        collectionView.backgroundColor = .green
//        backgroundColor = .yellow
    }
    
    private func bind() {
        titleLabel.text = model.title
        
        guard let subTitle = model.subtitle else {
            subtitleLabel.isHidden = true
            return
        }
        subtitleLabel.text = subTitle
        
        shoppingButton.setTitle("Перейти к покупкам", for: .normal)
    }
    
    private func setupStyles() {
        shoppingButton.contentEdgeInsets = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
        shoppingButton.setTitleColor(.black, for: .normal)
        shoppingButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        shoppingButton.backgroundColor = .clear
        
        shoppingButton.layer.cornerRadius = 5
        shoppingButton.layer.borderWidth = 1
        shoppingButton.layer.borderColor = UIColor.black.cgColor
    }
    
}


extension ProductsOfferView: UICollectionViewDelegate {
    
}


extension ProductsOfferView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Grab our cell from dequeueReusableCell, wtih the same identifier we set in our storyboard.
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductOfferCellView.reuseIdentifier, for: indexPath)
        
        guard let productCell = cell as? ProductOfferCellView else {
            fatalError("What a cell!")
        }

        // Give the current cell the corresponding data it needs from our model
        
        let season: String? = Int.random(in: 0...10).isMultiple(of: 2) ? "Новый сезон" : nil
        
        let model = ProductOfferCell(image: UIImage(named: "saucony")!,
                                     name: "saucony",
                                     productDescription: "декорированные кеды saucony с длинной строкой описания",
                                     cost: "$310",
                                     season: season)
        productCell.bind(model: model)
        return productCell
    }
    
}
