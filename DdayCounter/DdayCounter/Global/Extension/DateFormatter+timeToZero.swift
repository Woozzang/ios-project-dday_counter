//
//  DateFormatter+timeToZero.swift
//  DdayCounter
//
//  Created by Woochan Park on 2021/10/09.
//

import Foundation

extension DateFormatter {
  
  /**
    시분초가 섞인 Date 일 경우 처리할 수 있는 메서드
   */
  func timeToZero(_ date: Date) -> Date {
    
    let originalFomat = dateFormat
    
    dateFormat = "yyyy-MM-dd"
    
    // 시 분 초 날려버리기
    let origin = self.string(from: date)
    
    // UTC+9:00 적용
    let result = self.date(from: origin)!.advanced(by: 60 * 60 * 9)
    
    dateFormat = originalFomat
    
    return result
  }
}
