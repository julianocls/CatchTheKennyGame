//
//  ViewController.swift
//  CatchTheKennyGame
//
//  Created by Juliano Santos on 23/10/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scodeLabel: UILabel!
    @IBOutlet weak var hithsScoreLabel: UILabel!
    
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var kennyImages = [UIImageView()]
    var hidenTimer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        kennyImages = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
        for kenny in kennyImages {
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            kenny.isUserInteractionEnabled = true
            kenny.addGestureRecognizer(recognizer)
        }
        
        counter = 10
        timeLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hidenTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
    }
    
    @objc func hideKenny(){
        for kenny in kennyImages {
            kenny.isHidden = true
        }
        kennyImages.randomElement()?.isHidden = false
    }
    
    @objc func increaseScore() {
        score += 1
        scodeLabel.text = "Score: \(score)"
    }
    
    @objc func countDown() {
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hidenTimer.invalidate()

            for kenny in kennyImages {
                kenny.isHidden = true
            }
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .cancel)
            let replayButton = UIAlertAction(title: "Replay", style: .default) { [self]
                (UIAlertAction) in
                
                score = 0
                scodeLabel.text = "Score: \(score)"
                counter = 10
                timeLabel.text = String(counter)
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
                hidenTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            
            self.present(alert, animated: true, completion: nil)
        }
    }

}

