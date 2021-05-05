//
//  CoolDownViewController.swift
//  Voce
//
//  Created by charlie siagian on 04/05/21.
//

import UIKit
import AVFoundation

class CoolDownViewController: UIViewController {
    
    @IBOutlet weak var tableCoolDown: UITableView!
    
    var player: AVAudioPlayer?
    
    var item : [ListAudioModel] = [
        ListAudioModel(item: "Whispering", detailInfo: "Whisper tone is the voice that sounds like it's “riding on a cushion of air.” It's produced when the vocal folds are not together all the way and air escapes along with the tone. ... But other artists use the technique sporadically for dramatic effect, even if it's not their signature sound",titleInfo: "Whispering Info", audio: "whispering")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableCoolDown.delegate = self
        tableCoolDown.dataSource = self
    }
    

}

extension CoolDownViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "listAudioBreathingCell", for: indexPath) as! AudioBreathingCell
        
        let items = item[indexPath.row]
        
        cell.itemAudio.text = items.item
        
        cell.onButtonClick = {
            self.playAudio(audio: items.audio, playBtn: cell.playBtn)
            
        }
        
        cell.onInfoButtonClick = {
            self.showInfoAudio(titleInfo: items.titleInfo, contentInfo: items.detailInfo, sender: cell.infoAudioBtn)
        }
        
//        cell.playBtn.addTarget(self, action: #selector(playAudio), for: .touchUpInside)
        
        return cell
    }
    
    
    func playAudio(audio: String, playBtn : UIButton) {

        
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

extension CoolDownViewController : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
