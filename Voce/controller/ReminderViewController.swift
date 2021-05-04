//
//  ReminderViewController.swift
//  Voce
//
//  Created by charlie siagian on 04/05/21.
//

import UIKit
import UserNotifications

class ReminderViewController: UIViewController {

    @IBOutlet weak var dayDateLbl: UILabel!
    @IBOutlet weak var timeSetLbl: UILabel!
    
    @IBOutlet weak var infoBtn: UIButton!
    
    @IBOutlet weak var reminderBtn: UIButton!
    
    @IBOutlet weak var inputDate: UITextField!
    
    
    var datePicker =  UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPicker()
    
        UNUserNotificationCenter.current().delegate = self
        //ask for permission
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            
        }
    }
    
    func setPicker()  {
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePickerPressed))
        toolbar.setItems([doneBtn], animated: true)
        
        //assign toolbar
        inputDate.inputAccessoryView = toolbar
        
        //assign datepicker to the textfield
        inputDate.inputView = datePicker
        
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels
        
    }
    
    @objc func donePickerPressed() {
        //formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
//        inputDate.text = "\(datePicker.date)"
        inputDate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }


  
    @IBAction func setReminder(_ sender: UIButton) {
       
        //notif content
        let content = UNMutableNotificationContent()
        content.title = "Hey, do your vocalizing, be ready !"
        content.body = "Take your time and focus"
     
        //notification trigger
//        let date = Date()
        let dates = Date().addingTimeInterval(5)
        
        let dateComponent = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: datePicker.date)
        
//        var dateComponent = DateComponents()
//        dateComponent.second = 5
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        
//        let trigger2 = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
        
        //create request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        //register the request
        UNUserNotificationCenter.current().add(request) { (error) in
            // check the error parameter and handle
//            print(error)
        }
        
        //for badge, sound
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            
        }
        
    }
    
}


extension ReminderViewController: UNUserNotificationCenterDelegate{
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
  
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        self.dismiss(animated: false, completion: nil)
//        let navVC = parent as? UINavigationController
//        let homeVC = navVC?.viewControllers[0] as? HomeViewController
//        homeVC?.performSegue(withIdentifier: "toVocalizing", sender: self)
        
        //for action click the notif to the parent of storyboard
       
        guard let scene = UIApplication.shared.connectedScenes.first,
              let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
              let window = windowSceneDelegate.window else {
            return
        }
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let startController = storyboard?.instantiateInitialViewController() as? UITabBarController
        
        
        let navVC = startController?.viewControllers?[0] as? UINavigationController
        let vocalVC = storyBoard.instantiateViewController(identifier: "vocalizingPage")
        navVC?.pushViewController(vocalVC, animated: false)
        
                
        window?.rootViewController = startController
    }
}


