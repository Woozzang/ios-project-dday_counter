//
//  DdayCounterViewController.swift
//  DdayCounter
//
//  Created by Woochan Park on 2021/10/08.
//

import UIKit

class DdayCreatorViewController: UIViewController {
  
  @IBOutlet weak var datePicker: UIDatePicker! {
    didSet {
      datePicker.tintColor = .systemGreen
    }
  }
  
  @IBOutlet weak var registerButton: UIButton! {
    didSet {
      registerButton.layer.cornerRadius = 10
    }
  }
  
  @IBOutlet weak var dayNameTextField: UITextField!
  
  private let dateFormatter: DateFormatter = {
    
    let formatter = DateFormatter()
    formatter.dateFormat = .some("yyyy년 \nM월 dd일")
    return formatter
    
  }()
  
  required init?(coder: NSCoder) {
    
    super.init(coder: coder)
    
    tabBarItem.image = UIImage(systemName: "plus")
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
  }

  
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
    
    let anchorDate = datePicker.date
    
    let dday = Dday(dayName: dayName, anchorDate: anchorDate)
    
    DdayDataManger.shared.addDday(dday)
    
    let alertController = UIAlertController(title: "기념일 추가 완료!! 🥳", message: nil, preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
    
    alertController.addAction(okAction)
    
    present(alertController, animated: true, completion: nil)
  }
}
  

