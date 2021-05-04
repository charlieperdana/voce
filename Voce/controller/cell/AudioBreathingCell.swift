//
//  AudioBreathingCell.swift
//  Voce
//
//  Created by charlie siagian on 04/05/21.
//

import Foundation
import UIKit

class AudioBreathingCell: UITableViewCell{
    
    @IBOutlet weak var itemAudio: UILabel!
    
    @IBOutlet weak var playBtn: UIButton!
    
    @IBOutlet weak var infoAudioBtn: UIButton!
    
    var audio: String?
    
    var onButtonClick: (() -> ())?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func btnPressed(_ sender: UIButton){
        if let unwrapeedButtonClick = onButtonClick{
            unwrapeedButtonClick()
        }
    }
    
    @IBAction func playPressWarmup(_ sender: UIButton){
        if let unwrapeedButtonClick = onButtonClick{
            unwrapeedButtonClick()
        }
    }
    
    @IBAction func playPressRecovery(_ sender: UIButton){
        if let unwrapeedButtonClick = onButtonClick{
            unwrapeedButtonClick()
        }
    }
    
    @IBAction func playPressCoolDown(_ sender: UIButton){
        if let unwrapeedButtonClick = onButtonClick{
            unwrapeedButtonClick()
        }
    }
}
