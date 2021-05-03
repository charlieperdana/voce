//
//  RecoveryViewController.swift
//  Voce
//
//  Created by charlie siagian on 04/05/21.
//

import UIKit
import AVFoundation

class RecoveryViewController: UIViewController {
    
    @IBOutlet weak var tableRecovery: UITableView!
    
    var cell =  AudioBreathingCell()
    
    var player: AVAudioPlayer?
    
    var item : [ListAudioModel] = [
        ListAudioModel(item: "Humming", detailInfo: "Test", audio: "sample1")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableRecovery.delegate = self
        tableRecovery.dataSource = self
    }
    



}

extension RecoveryViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        cell = tableView.dequeueReusableCell(withIdentifier: "listAudioBreathingCell", for: indexPath) as! AudioBreathingCell
        
        let items = item[indexPath.row]
        
        cell.itemAudio.text = items.item
        
//        cell.playBtn.addTarget(self, action: #selector(playAudio), for: .touchUpInside)
        
        return cell
    }
    
    
}


