//
//  AlertViewController.swift
//  TimeBoxing
//
//  Created by Eric Fuentes on 4/5/20.
//  Copyright © 2020 eric. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate {
    
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var taskTitle: UITextField!
    
    var hour: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
    var taskArray = [Task]()
    var buttonAction: (() -> Void)?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.taskTitle.layer.borderWidth = 1.0
    

        taskTitle.becomeFirstResponder()

    }
    

    @IBAction func createButtonPressed(_ sender: UIButton) {
         let newItem = Task(context: self.context)
        newItem.title = taskTitle.text!
        
        newItem.hour = hourLabel.text!
        newItem.minute = minuteLabel.text!
        newItem.second = secondsLabel.text!
        self.taskArray.append(newItem)
        
        self.saveItem()
        
        dismiss(animated: true)
        buttonAction?()
    }
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    func saveItem() {
        do {
           try context.save()
        } catch {
             print("error saving item\(error)")
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {

        taskTitle.layer.borderColor = UIColor.black.cgColor
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        taskTitle.resignFirstResponder()
    }
    
    
    
    
    //MARK: - pickerview
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            switch component {
                 case 0:
                     return 25
                 case 1, 2:
                     return 60
                 default:
                     return 0
                 }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
          switch component {
                    case 0:
                        return "\(row) Hour"
                    case 1:
                        return "\(row) Minute"
                    case 2:
                        return "\(row) Second"
                    default:
                        return ""
                    }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           switch component {
                  case 0:
                      hour = row
                      hourLabel.text = String(format: "%02d", row)
                  case 1:
                      minutes = row
                      minuteLabel.text = String(format: "%02d", row)
                  case 2:
                      seconds = row
                      secondsLabel.text = String(format: "%02d", row)
                  default:
                      break;
                  }
        
    }
    
    

}
