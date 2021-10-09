//
//  CollectionViewCell.swift
//  DdayCounter
//
//  Created by Woochan Park on 2021/10/08.
//

import UIKit

class DdayCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var imageView: UIImageView!
  
  @IBOutlet weak var dayCountLabel: UILabel!
  
  @IBOutlet weak var dayNameLabel: UILabel!
  
  @IBOutlet weak var anchorDateLabel: UILabel!
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    self.layer.cornerRadius = 10
    self.backgroundColor = .systemGray
  }
}

