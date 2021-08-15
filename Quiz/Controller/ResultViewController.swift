//
//  ResultViewController.swift
//  State Capitals Quiz
//
//  Created by Stacey Moore on 4/26/21.
//

import UIKit

class ResultViewController: UIViewController {

    let defaults = UserDefaults.standard
    
    var score = Int()
    
    @IBOutlet weak var finalScoreLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setLabels()
        restoreDefaultScore()
    }
        
    @IBAction func newGamePressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setLabels() {
        finalScoreLabel.text = "Your Score is: \(score)/50"
        
        switch score {
        case 0...25:
            messageLabel.text = "Keep practicing!"
        case 26...40:
            messageLabel.text = "You're getting there!"
        case 41...49:
            messageLabel.text = "Well Done!"
        case 50:
            messageLabel.text = "Congratulations! Perfect Score!"
        default:
            print("error")
        }
    }
    
    func restoreDefaultScore() {
        var score = defaults.integer(forKey: K.score)
        score = 0
        defaults.set(score, forKey: K.score)
    }

}




