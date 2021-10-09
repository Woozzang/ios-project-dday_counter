//
//  DdayDataManger.swift
//  DdayCounter
//
//  Created by Woochan Park on 2021/10/09.
//

import Foundation

final class DdayDataManger {
  
  static let shared: DdayDataManger = DdayDataManger()
  
  private(set) var ddayList: [Dday] = []
  
  private init() {
//    ddayList = [ Dday(title: "생일", anchorDate: Date()),
//                 Dday(title: "100일", anchorDate: Date()),
//                 Dday(title: "개강", anchorDate: Date()),
//                 Dday(title: "종강", anchorDate: Date())
//  ]
  }
  
  func fetchDday(at index: Int) -> Dday?{
    
    guard index <= ddayList.count else { return nil }
    
    return ddayList[index]
  }
  
  func addDday(_ dday: Dday) {
    
    ddayList.append(dday)
  }
}
