//
//  DdayCollectionViewController.swift
//  DdayCounter
//
//  Created by Woochan Park on 2021/10/08.
//

import UIKit

class DdayCollectionViewController: UICollectionViewController {
  
  // MARK: - Life Cycle
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    tabBarItem = UITabBarItem(title: "D-day", image: UIImage.init(systemName: "calendar"), tag: 0)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
    
    layout.sectionInset.left = layout.minimumInteritemSpacing
    layout.sectionInset.right = layout.minimumInteritemSpacing
    
    NotificationCenter.default.addObserver(self, selector: #selector(creatorDidAddNewDday), name: DdayCreatorViewController.didAddNewDday, object: nil)
    
  }
  
  deinit {
    
    NotificationCenter.default.removeObserver(self)
  }

  // MARK: - CollectionView DataSource
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return DdayDataManger.shared.ddayList.count
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DdayCollectionViewCell", for: indexPath) as? DdayCollectionViewCell else { fatalError(#function ) }
    
    guard let data = DdayDataManger.shared.fetchDday(at: indexPath.item) else { fatalError(#function + " - No Data in DdayList")}
    
    cell.setUpCell(with: data)
    
    return cell
  }
  
  
// MARK: - IBAction
  
  @objc private func creatorDidAddNewDday() {
    
    collectionView.reloadData()
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension DdayCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    
    guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize.zero }

    var size = CGSize()

    let givenHeight = (collectionView.frame.height - (collectionView.safeAreaInsets.top + collectionView.safeAreaInsets.bottom) - (layout.minimumLineSpacing * 4)) / 4
    
    let  givenWidth = (collectionView.bounds.width - (layout.sectionInset.left + layout.sectionInset.right)  - (layout.minimumInteritemSpacing)) / 2
    
    size.height = givenHeight.rounded(.down) + 0.25
    size.width = givenWidth.rounded(.down)

    return size
  }
}


