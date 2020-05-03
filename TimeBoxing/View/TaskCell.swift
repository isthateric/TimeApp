//
//  TaskCell.swift
//  TimeBoxing
//
//  Created by Eric Fuentes on 4/5/20.
//  Copyright © 2020 eric. All rights reserved.
//

import UIKit
import CoreData
class TaskCell: UICollectionViewCell, CountdownTimerDelegate {

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var taskBubble: UIView!
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    //MARK - Vars
    var a: String?
    var b: String?
    var c: String?

    var seconds = 0.0
    var duration = 0.0
    var task = [Task]()
    
    var countdownTimerDidStart = false
   

    lazy var countdownTimer: CountdownTimer = {
        let countdownTimer = CountdownTimer()
        return countdownTimer
    }()
    
    
    // Test, for dev
    let selectedSecs:Int = 0
    
    weak var delegate: CountdownTimerDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        
      //  print("hello::::::::::: \(task[0].hour!)")
        
        
        // Initialization code
        taskBubble.layer.cornerRadius = taskBubble.frame.size.height / 5
        timerButton.layer.cornerRadius = taskBubble.frame.size.height / 5
        timerButton.titleLabel?.text = "Start"
        timerButton.titleLabel?.textColor = .white
        deleteButton.layer.cornerRadius = 16
        countdownTimer.delegate = self
        countdownTimer.setTimer(hours: 1, minutes: 1, seconds: 1)
        print(a?.count)
    }
    
    //MARK: - Countdown Timer Delegate
    
    public func countdownTime(time: (hours: String, minutes: String, seconds: String)) {
  
        hourLabel.text! = time.hours
        minuteLabel.text! = time.minutes
        secondLabel.text! = time.seconds
    }

    func countdownTimerDone() {
        secondLabel.text = String(selectedSecs)
        countdownTimerDidStart = false
        timerButton.setTitle("START",for: .normal)
        print("countdownTimerDone")
    }
    
 


    @IBAction func timerButtonPressed(_ sender: UIButton) {
        
        if !countdownTimerDidStart{
                 countdownTimer.start()
                 countdownTimerDidStart = true
                 timerButton.setTitle("PAUSE",for: .normal)
                 
             }else{
                 countdownTimer.pause()
                 
                 countdownTimerDidStart = false
                 timerButton.setTitle("RESUME",for: .normal)
             }

    }
    

    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        
    }
    
}
