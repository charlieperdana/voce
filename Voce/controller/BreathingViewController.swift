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
        ListAudioModel(item: "Diafragma", detailInfo: "Test", audio: "sample1"),
        ListAudioModel(item: "Throat Exercise", detailInfo: "Test", audio: "sample2")
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
        
        let items = item[indexPath.row]
        
        cell.itemAudio.text = items.item
        
        cell.playBtn.addTarget(self, action: #selector(playAudio), for: .touchUpInside)
        
        
        return cell
    }
    
    @objc func playAudio(sender: UIButton!) {
        print("play tapped")
        
        let urlString = Bundle.main.path(forResource: "sample1", ofType: "mp3")
        if let player = player, player.isPlaying{
            // stop playback
            sender.setImage(UIImage(named: "voce-play.png"), for: .normal)
            player.stop()
        }
        else {
            // set up player and play
            sender.setImage(UIImage(named: "voce-stop.png"), for: .normal)
            
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
