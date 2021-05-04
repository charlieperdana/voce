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
        ListAudioModel(item: "ma ma ma", detailInfo: "Test", audio: "mamama"),
        ListAudioModel(item: "la la la", detailInfo: "Test", audio: "lalala"),
        ListAudioModel(item: "ma mi mo la", detailInfo: "Test", audio: "mamimola")
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
    
    
}
