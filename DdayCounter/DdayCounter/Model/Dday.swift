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
      
      let today = DateFormatter().timeToZero(Date())
      
      let distanceFromToday = (anchorDate.timeIntervalSince(today) / ( 60 * 60 * 24))

      return Int(distanceFromToday)
    }
  }
  
  var dayName: String
  
  var anchorDate: Date
}
