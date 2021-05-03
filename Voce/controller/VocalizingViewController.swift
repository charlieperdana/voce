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
        
        setupMenuAction()

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
    
}
