//
//  OverlayView.swift
//  Voce
//
//  Created by charlie siagian on 05/05/21.
//

import UIKit

class OverlayView: UIViewController {
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    var contentTitle = ""
    var contentMessage = ""
    
    @IBOutlet weak var titleHalf: UILabel!
    
    @IBOutlet weak var contentHalf: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        setContent(title: contentTitle, content: contentMessage)
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    
    //allow gesture to bottom not to above
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
    func setContent(title: String, content: String) {
        titleHalf?.text = title
        contentHalf?.text = content
    }
    
}
