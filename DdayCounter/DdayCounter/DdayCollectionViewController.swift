//
//  DdayCollectionViewController.swift
//  DdayCounter
//
//  Created by Woochan Park on 2021/10/08.
//

import UIKit

class DdayCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
      super.viewDidLoad()
      
      guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
      
      layout.sectionInset.left = layout.minimumInteritemSpacing
      layout.sectionInset.right = layout.minimumInteritemSpacing
      
    }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    print(self.collectionView.safeAreaInsets)
  }
  

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return DdayDataManger.shared.ddayList.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DdayCollectionViewCell", for: indexPath) as? DdayCollectionViewCell else { fatalError(#function) }
      
//    cell.backgroundColor = .red
    
    let data = DdayDataManger.shared.fetchDday(at: indexPath.item)
    
//    cell.dayCountLabel.text = data?.title
    cell.anchorDateLabel.text = "\(data?.anchorDate)"
    
    
    return cell
    
  }
}

extension DdayCollectionViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    
    guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize.zero }

    var size = CGSize()

    var givenHeight = (collectionView.frame.height - (collectionView.safeAreaInsets.top + collectionView.safeAreaInsets.bottom) - (layout.minimumLineSpacing * 4)) / 4
    
    var givenWidth = (collectionView.bounds.width - (layout.sectionInset.left + layout.sectionInset.right)  - (layout.minimumInteritemSpacing)) / 2
    
    size.height = givenHeight.rounded(.down) + 0.25
    size.width = givenWidth.rounded(.down)

    return size
  }
}
