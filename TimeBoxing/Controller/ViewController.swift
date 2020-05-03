//
//  ViewController.swift
//  TimeBoxing
//
//  Created by Eric Fuentes on 4/5/20.
//  Copyright © 2020 eric. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout{
  
    

    
  
    
    
    @IBOutlet weak var backAlert: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //var task = TaskCell()
    var taskArray = [Task]()
    weak var delegate: CountdownTimerDelegate?
    var taskCell = TaskCell()
    let selectedSecs:Int = 0
    var countdownTimerDidStart = false
    let countdown = CountdownTimer()
    
    let alertService = AlertService()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTask()
      configureUI()
        
    }

    func configureUI()  {
            collectionView.delegate = self
            collectionView.dataSource = self
            let nib  = UINib(nibName: K.cellNibName, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: K.cellIdentifier)
    }
    
    //MARK: - Add Item
    @IBAction func plusButtonPressed(_ sender: UIButton) {
        
        let alertVC = alertService.alert {
            self.loadTask()
            self.collectionView.reloadData()
        }
        
        alertVC.isModalInPresentation = true
        present(alertVC, animated: true)
        
        
        }
    //MARK: - Model Manupulation Methods
    
    func saveItem() {
        do {
           try context.save()
        } catch {
            print("error saving item\(error)")
        }
        self.collectionView.reloadData()
    }
    

    func loadTask(with request: NSFetchRequest<Task> = Task.fetchRequest()) {
              do {
                    taskArray = try context.fetch(request)
                   }catch {
                       print("Error fetching data from context \(error)")
                   }
             self.collectionView.reloadData()
         }
    

    
}

//MARK: - TableView Delegate Methods

extension ViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 350, height: 120)
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //  performSegue(withIdentifier: K.segue, sender: self)
          
      }
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == K.segue {
              let destinationVC = segue.destination as! OptionsViewController
             
             if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                // destinationVC.selectedTask = taskArray[indexPath.row]
             }
          }
      }
    
}
//MARK: - collectionView Datasource Methods

extension ViewController : UICollectionViewDataSource {

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if taskArray.count == 0 {
            backAlert.isHidden = false
        } else {
            backAlert.isHidden = true
        }
      
     return self.taskArray.count
    }
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let task = taskArray[indexPath.row]
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.cellIdentifier, for: indexPath) as! TaskCell
      
        cell.label.text = task.title
        cell.hourLabel.text = task.hour
        cell.minuteLabel.text = task.minute
        cell.secondLabel.text = task.second
        //countdownTimer.setTimer(hours: 1, minutes: 1, seconds: 1)
        cell.a = task.hour
        cell.b = task.minute
        cell.c = task.second
        // TaskCellVC.updateUI(hour: task.hour!, minute: task.minute!, sec: task.second!)
      
      
       
           return cell
       }
 
}
