//
//  BreathingViewController.swift
//  Voce
//
//  Created by charlie siagian on 04/05/21.
//

import UIKit
import AVFoundation

class BreathingViewController: UIViewController {

    @IBOutlet weak var tableAudioBreathing: UITableView!
    
    var cell =  AudioBreathingCell()
    
    var player: AVAudioPlayer?
    
    var item : [ListAudioModel] = [
        ListAudioModel(item: "Diafragma", detailInfo: "When try to train your breathing, you have to be focus on your diafragma. To breathe through your diaphragm, inhale as deep as possible while pushing your stomach out as far as possible in a stable posture. Then exhale and pull back in your stomach. Make sure your shoulders don't move.The muscles used when breathing must remain strong but not stiff when singing. The muscles in the chest, shoulders and face must remain limp.",titleInfo: "Diafragma Info", audio: "diafragma"),
        ListAudioModel(item: "Throat Exercise", detailInfo: "This technic is for reducing vocal strain. Vocal strain occurs when muscles outside the intrinsic vocal folds or “true vocal cords” get involved in your singing.",titleInfo: "Throat Exercise Info", audio: "Throatexercise")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableAudioBreathing.delegate = self
        tableAudioBreathing.dataSource = self

        
    }
    
    


}

extension BreathingViewController : UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: "listAudioBreathingCell", for: indexPath) as! AudioBreathingCell
        
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "listAudioBreathingCell", for: indexPath) as! AudioBreathingCell
        
        let items = item[indexPath.row]
        
    
        cell2.itemAudio.text = items.item
        cell2.onButtonClick = {
            var index = indexPath
            self.playAudio(audio: items.audio, playBtn: cell2.playBtn)
            
        }
//        cell2.infoAudioBtn.addTarget(self, action: #selector(showInfoAudio), for: .touchUpInside)
        
        cell2.onInfoButtonClick = {
            self.showInfoAudio(titleInfo: items.titleInfo, contentInfo: items.detailInfo, sender: cell2.infoAudioBtn)
        }
        
        
//        cell.playBtn.addTarget(self, action: #selector(playAudio), for: .touchUpInside)
        
        
        return cell2
    }
    
    func playAudio(audio: String, playBtn : UIButton) {
//        print("play tapped")
        
        let urlString = Bundle.main.path(forResource: "\(audio)", ofType: "mp3")
        if let player = player, player.isPlaying{
            // stop playback
            playBtn.setImage(UIImage(named: "voce-play.png"), for: .normal)
            player.stop()
        }
        else {
            // set up player and play
            playBtn.setImage(UIImage(named: "voce-stop.png"), for: .normal)
            
            do{
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let urlString = urlString else {
                    return
                }
                
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                
                guard let player = player else {
                    return
                }
                
                player.play()
            }
            catch {
                print("something went wrong")
            }
        }

    }
    
    func showInfoAudio(titleInfo: String, contentInfo: String, sender: UIButton!) {
        let slideInfo = OverlayView()
        slideInfo.contentTitle = titleInfo
        slideInfo.contentMessage = contentInfo
        
        slideInfo.modalPresentationStyle = .custom
        slideInfo.transitioningDelegate = self
        self.present(slideInfo, animated: true, completion: nil)

    }
    
    
}

extension BreathingViewController : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
