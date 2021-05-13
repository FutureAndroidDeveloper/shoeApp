import UIKit
import FSPagerView


class ActualPagerView: UIView {
    
    private struct Constants {
        struct Title {
            static let edgeInsets = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        }
    }
    
    private let titleLabel = UILabel()
    private let pagerView = FSPagerView()
    private let pageControl = FSPageControl()
    
    private let brandLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    
    init() {
        super.init(frame: .zero)
        build()
        bind()
        setupStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let newScale:  CGFloat = 0.85
        self.pagerView.itemSize = self.pagerView.frame.size.applying(CGAffineTransform(scaleX: newScale, y: 1))
        print(newScale)
    }
    
    private func build() {
        addView(titleLabel) {
            $0.top.leading.trailing.equalToSuperview().inset(Constants.Title.edgeInsets)
        }
        // Create a pager view
        pagerView.interitemSpacing = 20
        pagerView.automaticSlidingInterval = 5.0
        pagerView.transformer = FSPagerViewTransformer(type: .linear)
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        
        addView(pagerView) {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(400)
        }

        
        let brandContentContainer = UIView()
        brandContentContainer.buildVerticalStackOf([brandLabel, descriptionLabel],
                                                   betweenOffset: 8,
                                                   insets: .zero)
        
        addView(brandContentContainer) {
            $0.top.equalTo(pagerView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(30)
        }

        pageControl.setFillColor(.lightGray, for: .normal)
        pageControl.setFillColor(.black, for: .selected)
        pageControl.interitemSpacing = 20
        pageControl.setPath(UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)), for: .normal)
        pageControl.setPath(UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)), for: .selected)

        
        addView(pageControl) {
            $0.top.equalTo(brandContentContainer.snp.bottom).offset(30)
            $0.height.equalTo(25)
            $0.bottom.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0))
        }
    }
    
    private func bind() {
        titleLabel.text = "Главное за неделю"
        brandLabel.text = "BALENCIAGA"
        descriptionLabel.text = "Кроссовки Speed 3.0"
    }
    
    private func setupStyles() {
        titleLabel.textAlignment = .center
        
        brandLabel.textAlignment = .center
        brandLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        descriptionLabel.textAlignment = .center
        
        pageControl.numberOfPages = 3
    }
    
    private func animateChangingBrandInfo(for index: Int) {
        UIView.transition(with: brandLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.brandLabel.text = "Kirill"
        }, completion: nil)
        UIView.transition(with: descriptionLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.descriptionLabel.text = "KHfdjdfhsjdg Speed 3.0"
        }, completion: nil)
    }
    
}

extension ActualPagerView: FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 3
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: "testImage")
        return cell
    }
    
}

extension ActualPagerView: FSPagerViewDelegate {
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
        animateChangingBrandInfo(for: targetIndex)
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControl.currentPage = pagerView.currentIndex
        animateChangingBrandInfo(for: pagerView.currentIndex)
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: false)
    }
    
}
