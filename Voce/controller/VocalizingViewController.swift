//
//  VocalizingViewController.swift
//  Voce
//
//  Created by charlie siagian on 04/05/21.
//

import UIKit

class VocalizingViewController: UIViewController {
    @IBOutlet weak var startSimulationBtn: UIButton!
    
    @IBOutlet weak var breathingMenu: UIImageView!
    @IBOutlet weak var warmUpMenu: UIImageView!
    @IBOutlet weak var recoveryMenu: UIImageView!
    @IBOutlet weak var coolDownMenu: UIImageView!
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startSimulationBtn.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        
        setupMenuAction()
        
        btnSimulationDisplay()

    }
    
    func btnSimulationDisplay()  {
        startSimulationBtn.layer.cornerRadius = 15
        startSimulationBtn.layer.borderWidth = 2
        startSimulationBtn.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    }
    
    func setupMenuAction() {
        let tapGestureRecognizerBreathing = UITapGestureRecognizer(target: self, action: #selector(breathingMenuTapped(tapGestureRecognizer:)))
        breathingMenu.isUserInteractionEnabled = true
        breathingMenu.addGestureRecognizer(tapGestureRecognizerBreathing)

        let tapGestureRecognizerWarmup = UITapGestureRecognizer(target: self, action: #selector(warmUpMenuTapped(tapGestureRecognizer:)))
        warmUpMenu.isUserInteractionEnabled = true
        warmUpMenu.addGestureRecognizer(tapGestureRecognizerWarmup)

        let tapGestureRecognizerRecovery = UITapGestureRecognizer(target: self, action: #selector(recoveryMenuTapped(tapGestureRecognizer:)))
        recoveryMenu.isUserInteractionEnabled = true
        recoveryMenu.addGestureRecognizer(tapGestureRecognizerRecovery)

        let tapGestureRecognizerCooldown = UITapGestureRecognizer(target: self, action: #selector(coolDownMenuTapped(tapGestureRecognizer:)))
        coolDownMenu.isUserInteractionEnabled = true
        coolDownMenu.addGestureRecognizer(tapGestureRecognizerCooldown)
    }

    @objc func breathingMenuTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toBreathing", sender: self)
    }
    
    @objc func warmUpMenuTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toWarmUp", sender: self)
    }
    
    @objc func recoveryMenuTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toRecovery", sender: self)
    }
    
    @objc func coolDownMenuTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toCoolDown", sender: self)
    }
    
    @objc func showAlert(sender: UIButton!) {
        // Create a UIAlertController object, you should provide title, alert message and dialog stype parameter.
        let alertController:UIAlertController = UIAlertController(title: "Info", message: "This feature is under constructions", preferredStyle: UIAlertController.Style.alert)
        
        // Create a UIAlertAction object, this object will add a button at alert dialog bottom, the button text is OK, when click it just close the alert dialog.
        let alertAction:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil)
        
        // Add alertAction object to alertController.
        alertController.addAction(alertAction)
        
        // Popup the alert dialog.
        present(alertController, animated: true, completion: nil)
        
        
    }
    
}
