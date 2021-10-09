//
//  DdayDataManger.swift
//  DdayCounter
//
//  Created by Woochan Park on 2021/10/09.
//

import Foundation

final class DdayDataManger {
  
  static let shared: DdayDataManger = DdayDataManger()
  
  private(set) var ddayList: [Dday] = [ ]
  
  private init() { }
  
  func fetchDday(at index: Int) -> Dday?{
    
    guard index <= ddayList.count else { return nil }
    
    return ddayList[index]
  }
  
  func addDday(_ dday: Dday) {
    
    ddayList.append(dday)
  }
}
