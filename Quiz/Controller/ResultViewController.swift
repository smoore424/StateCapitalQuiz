//
//  ResultViewController.swift
//  State Capitals Quiz
//
//  Created by Stacey Moore on 4/26/21.
//

import UIKit

class ResultViewController: UIViewController {

    let layer = CAEmitterLayer()
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
            confetti()
        case 50:
            messageLabel.text = "Congratulations! Perfect Score!"
            confetti()
        default:
            print("error")
        }
    }
    
    func restoreDefaultScore() {
        var score = defaults.integer(forKey: K.score)
        score = 0
        defaults.set(score, forKey: K.score)
    }

    //MARK: - Confetti Animation Effect
    func confetti() {
        createConfetti()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.stopConfetti()
        }
    }
    
    func createConfetti() {
        layer.emitterPosition = CGPoint(x: view.center.x, y: -150)
        //layer.preservesDepth = true
        
        let colors = [UIColor.systemRed, UIColor.systemBlue, UIColor.systemGreen, UIColor.systemPink, UIColor.systemTeal, UIColor.systemOrange, UIColor.systemYellow, UIColor.systemPurple, UIColor.systemIndigo]
        
        let cells: [CAEmitterCell] = colors.compactMap {
            let cell = CAEmitterCell()
            cell.scaleRange = 0.2
            cell.scale = 0.05 - cell.scaleRange
            cell.birthRate = 100
            cell.emissionRange = .pi * 2
            cell.spin = 2
            cell.setValue("plane", forKey: "particleType")
            cell.setValue(Double.pi, forKey: "orientationRange")
            cell.setValue(Double.pi / 2, forKey: "orientationLongitude")
            cell.setValue(Double.pi / 2, forKey: "orientationLatitude")
            cell.lifetime = 10
            cell.velocity = 200
            cell.color = $0.cgColor
            cell.contents = UIImage(named: "whiteSquare")!.cgImage
            return cell
        }
        layer.emitterCells = cells
        view.layer.addSublayer(layer)
    }
    
    func stopConfetti() {
        layer.lifetime = 0
    }
}




