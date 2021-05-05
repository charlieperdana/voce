//
//  WarmUpViewController.swift
//  Voce
//
//  Created by charlie siagian on 04/05/21.
//

import UIKit
import AVFoundation

class WarmUpViewController: UIViewController {
    
    @IBOutlet weak var tableWarmUp: UITableView!
    
    var player: AVAudioPlayer?
    
    var item : [ListAudioModel] = [
        ListAudioModel(item: "ma ma ma", detailInfo: "Vocal warm ups and exercises are key when you’re learning how to sing. Just like athletes stretch out their bodies and muscles before a big game, vocalists must warm up their singing voice before a performance or rehearsal. This fisrt warm uo, we are gonna sing note for ma ma ma, represent 1 2 3 4 5 4 3 2 1",titleInfo: "Warm Up 1 Info", audio: "mamama"),
        ListAudioModel(item: "la la la", detailInfo: "The second warm up, we are gonna sing some variaty notes that exersise our mouth to the low and high note. We sing using la la la, and note stands for 12 13 14 15 16 27 1i. Repeat those notes for 3 times in a row",titleInfo: "Warm Up 2 Info", audio: "lalala"),
        ListAudioModel(item: "ma mi mo la", detailInfo: "The third warm up , we are gonna sing some medium level notes, which stands for 111111111. We pronounce the notes with ma mi mo la ma. We repeat all the notes with higher notes from 1 to i in C key.",titleInfo: "Warm Up 3 Info", audio: "mamimola")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableWarmUp.delegate = self
        tableWarmUp.dataSource = self
    }
    


}

extension WarmUpViewController: UITableViewDelegate, UITableViewDataSource {
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
        
//        cell.playBtn.addTarget(self, action: #selector(playAudio), for: .touchUpInside)
        
        cell.onInfoButtonClick = {
            self.showInfoAudio(titleInfo: items.titleInfo, contentInfo: items.detailInfo, sender: cell.infoAudioBtn)
        }
        
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

extension WarmUpViewController : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
