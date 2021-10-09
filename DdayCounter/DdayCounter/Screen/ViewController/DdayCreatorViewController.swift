//
//  DdayCounterViewController.swift
//  DdayCounter
//
//  Created by Woochan Park on 2021/10/08.
//

import UIKit

class DdayCreatorViewController: UIViewController {
  
  // MARK: - IBOutlet
  
  @IBOutlet private weak var datePicker: UIDatePicker! {
    didSet {
      datePicker.tintColor = .systemGreen
      
      if #available(iOS 14.0, *) {
        datePicker.preferredDatePickerStyle = .inline
      } else {
        datePicker.preferredDatePickerStyle = .wheels
      }
    }
  }
  
  @IBOutlet private weak var registerButton: UIButton! {
    didSet {
      registerButton.layer.cornerRadius = 10
    }
  }
  
  @IBOutlet private weak var dayNameTextField: UITextField!
  
  // MARK: - Property
  
  private let dateFormatter: DateFormatter = {
    
    let formatter = DateFormatter()
    formatter.dateFormat = .some("yyyy년 \nM월 dd일")
    return formatter
    
  }()
  
  // MARK: - Life Cycle
  required init?(coder: NSCoder) {
    
    super.init(coder: coder)
    
    tabBarItem = UITabBarItem(title: "New", image: UIImage(systemName: "plus"), tag: 1)
  }
  
  // MARK: - IBAction
  
  @IBAction func didTapRegisterButton(_ sender: Any) {
    
    guard let dayName = dayNameTextField.text, !dayName.isEmpty else {
      
      let alertController = UIAlertController(title: "기념일 이름을 입력해주세용😅", message: nil, preferredStyle: .alert)
      
      let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
      
      alertController.addAction(okAction)
      
      present(alertController, animated: true, completion: {
        self.dayNameTextField.becomeFirstResponder()
      })
      
      return
    }
    
    let anchorDate = dateFormatter.timeToZero(datePicker.date)
    
    let dday = Dday(dayName: dayName, anchorDate: anchorDate)
    
    DdayDataManger.shared.addDday(dday)
    
    
    let alertController = UIAlertController(title: "기념일 추가 완료!! 🥳", message: nil, preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
    
    alertController.addAction(okAction)
    
    present(alertController, animated: true, completion: nil)
    
    NotificationCenter.default.post(name: type(of: self).didAddNewDday, object: nil)
  }
}

// MARK: - Notification

extension DdayCreatorViewController {
  
  static let didAddNewDday = Notification.Name.init("didAddNewDday")
}

