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
    
    var cell =  AudioBreathingCell()
    
    var player: AVAudioPlayer?
    
    var item : [ListAudioModel] = [
        ListAudioModel(item: "ma ma ma", detailInfo: "Test", audio: "sample1"),
        ListAudioModel(item: "la la la", detailInfo: "Test", audio: "sample2"),
        ListAudioModel(item: "ma mi mo la", detailInfo: "Test", audio: "sample1")
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
        
        cell = tableView.dequeueReusableCell(withIdentifier: "listAudioBreathingCell", for: indexPath) as! AudioBreathingCell
        
        let items = item[indexPath.row]
        
        cell.itemAudio.text = items.item
        
//        cell.playBtn.addTarget(self, action: #selector(playAudio), for: .touchUpInside)
        
        return cell

    }
    
    
}
