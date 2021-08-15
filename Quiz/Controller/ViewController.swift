//
//  ViewController.swift
//  Quiz
//
//  Created by Stacey Moore on 1/11/21.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    var avPlayer: AVAudioPlayer?
    var quizBrain = QuizBrain()
    

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerField: UITextField!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var checkAnswerButton: UIButton!
    @IBOutlet weak var nextQuestionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUI()
    }

    @IBAction func showNextQuestion(_ sender: UIButton!) {
        if quizBrain.nextQuestion() {
            setUI()
        } else {
            showResultVC()
        }
    }

    @IBAction func checkAnswerButtonTapped(_ sender: UIButton!) {
        answerField.endEditing(true)
        checkAnswer()
    }
    
    func checkAnswer() {
        if answerField.text != "" {
            answerField.isUserInteractionEnabled = false
            checkAnswerButton.isHidden = true
            nextQuestionButton.isHidden = false
            let userAnswer = (answerField.text?.lowercased())!
            let result = quizBrain.checkAnswer(userAnswer)
            feedbackLabel.text = result
            if result == "Correct" {
                playSound(for: "correct.wav")
            } else {
                playSound(for: "wrong.mp3")
            }
        } else {
            answerField.placeholder = "Please enter your answer"
            animate()
        }
    }
    
    func setUI() {
        nextQuestionButton.isHidden = true
        checkAnswerButton.isHidden = false
        
        answerField.isUserInteractionEnabled = true
        answerField.placeholder = "Answer"
        answerField.text = ""
        
        let currentQuestion = quizBrain.getQuestionText()
        
        questionLabel.text = "What is the Capital of \(currentQuestion)"
        
        imageView.image = UIImage(named: currentQuestion)?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = quizBrain.getRandomColor()
        
        feedbackLabel.text = ""
        title = quizBrain.getScore()
    }

    func showResultVC() {
        let vc = storyboard?.instantiateViewController(identifier: "ResultViewController") as! ResultViewController
        vc.modalPresentationStyle = .fullScreen
        vc.score = defaults.integer(forKey: K.score)
        show(vc, sender: self)
    }
    
    func animate() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.duration = 0.5
        
        animation.isAdditive = true
        answerField.layer.add(animation, forKey: "shake")
    }
    
    func playSound(for sound: String) {
        
        
        let path = Bundle.main.path(forResource: sound, ofType: nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            avPlayer = try AVAudioPlayer(contentsOf: url)
            avPlayer?.play()
        } catch {
            print("error playing sound \(error)")
        }
    }
}

//MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        answerField.endEditing(true)
        checkAnswer()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if answerField.text != "" {
            return true
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        answerField.endEditing(true)
    }
}
