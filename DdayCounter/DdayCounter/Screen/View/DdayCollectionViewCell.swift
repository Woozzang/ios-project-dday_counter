//
//  CollectionViewCell.swift
//  DdayCounter
//
//  Created by Woochan Park on 2021/10/08.
//

import UIKit

class DdayCollectionViewCell: UICollectionViewCell {
  
  // MARK: - IBOutlet
  
  @IBOutlet weak var imageView: UIImageView!
  
  @IBOutlet weak var dayCountLabel: UILabel!
  
  @IBOutlet weak var dayNameLabel: UILabel!
  
  @IBOutlet weak var anchorDateLabel: UILabel!
  
  // MARK: - Property
  
  private let dateFormatter: DateFormatter = {
    
    let formatter = DateFormatter()
    formatter.dateFormat = .some("yyyy년 MM월 dd일")
    return formatter
  }()
  
  // MARK: - Life Cycle
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    self.layer.cornerRadius = 10
    self.backgroundColor = UIColor.randomColor
  }
  
  // MARK: - Custom Method
  
  func setUpCell(with data: Dday) {
    
    let countLabelText = data.dayCount > 0 ? "D+\(data.dayCount)" : data.dayCount == 0 ? "D-Day" : "D\(data.dayCount)"
    
    self.dayCountLabel.text = countLabelText
    
    self.dayNameLabel.text = data.dayName
    
    let anchorDateText = dateFormatter.string(from: data.anchorDate)
    
    self.anchorDateLabel.text = anchorDateText
  }
}

