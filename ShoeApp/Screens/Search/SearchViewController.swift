//
//  SearchViewController.swift
//  ShoeApp
//
//  Created by Klimenkov, Kirill on 28.05.21.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    let itemsPerRow: CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.setTitle("Обувь", subtitle: "23236 Позиции")
        build()
    }
    
    private func build() {
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "SearchProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: SearchProductCollectionViewCell.ID)
//        collectionView.register(SearchProductCollectionViewCell.self, forCellWithReuseIdentifier: SearchProductCollectionViewCell.ID)
        collectionView.collectionViewLayout = createCompositionalLayout()
        collectionView.reloadData()
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                            heightDimension: .fractionalHeight(1))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)

      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                            heightDimension: .fractionalWidth(0.5))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

      let section = NSCollectionLayoutSection(group: group)

      let layout = UICollectionViewCompositionalLayout(section: section)
      return layout
    }

}


extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchProductCollectionViewCell.ID, for: indexPath)
        return cell
    }
}


extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        // 2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    // 3
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return sectionInsets.left
    }
}
