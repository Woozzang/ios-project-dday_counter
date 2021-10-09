//
//  UIColor+getRandomColor.swift
//  DdayCounter
//
//  Created by Woochan Park on 2021/10/09.
//

import UIKit

extension UIColor {
  
  static var randomColor: UIColor {
    get {
      return getRandomColor()
    }
  }
  
  private static func getRandomColor() -> UIColor {
          
    let randomRed:CGFloat = CGFloat(drand48())
    
    let randomGreen:CGFloat = CGFloat(drand48())
    
    let randomBlue:CGFloat = CGFloat(drand48())
    
    return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
          
  }
}
