//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    
    var counter = 60
    
    var timer = Timer()
    
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var hardnessNonOptional = ""
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        progressBar.progress = 1

        guard let hardness = sender.currentTitle else { return }
        
        hardnessNonOptional = hardness
    
        counter = eggTimes[hardness] ?? 0
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
        titleLabel.text = hardness
    }
    

    @objc func update() {

        if counter > 0 {
            print("\(counter) seconds")
            progressBar.progress -= 1.0/Float(eggTimes[hardnessNonOptional] ?? 1)
            counter -= 1
            
        } else {
            timer.invalidate() // !
            titleLabel.text = "Done"
            progressBar.progress = 0
            playSound()
        }
        

    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
}
