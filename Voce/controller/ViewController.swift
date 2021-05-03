//
//  ViewController.swift
//  Voce
//
//  Created by charlie siagian on 30/04/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var notifBtn: UIBarButtonItem!
    @IBOutlet weak var menuVocalizing: UIImageView!
    
    @IBOutlet weak var menuReminder: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMenuAction()
    }
    
    func setMenuAction() {
        let tapGestureRecognizerMenu1 = UITapGestureRecognizer(target: self, action: #selector(menu1Tapped(tapGestureRecognizer:)))
        menuVocalizing.isUserInteractionEnabled = true
        menuVocalizing.addGestureRecognizer(tapGestureRecognizerMenu1)
        
        let tapGestureRecognizerMenu2 = UITapGestureRecognizer(target: self, action: #selector(menu2Tapped(tapGestureRecognizer:)))
        menuReminder.isUserInteractionEnabled = true
        menuReminder.addGestureRecognizer(tapGestureRecognizerMenu2)
    }
    
    @objc func menu1Tapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        performSegue(withIdentifier: "toVocalizing", sender: self)
    }
    
    @objc func menu2Tapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        performSegue(withIdentifier: "toReminder", sender: self)
    }
    
    


}

