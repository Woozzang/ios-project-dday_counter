//
//  Dday.swift
//  DdayCounter
//
//  Created by Woochan Park on 2021/10/09.
//

import Foundation

struct Dday {
  
  var dayCount: Int {
    
    get {
      
      let now = Date()
      
      let distance = (anchorDate.timeIntervalSince(now) / ( 60 * 60 * 24)).rounded(.down)
      
      return Int(distance)
    }
  }
  
  var dayName: String
  
  var anchorDate: Date
}
