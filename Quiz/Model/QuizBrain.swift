//
//  QuizBrain.swift
//  State Capitals Quiz
//
//  Created by Stacey Moore on 3/30/21.
//

import UIKit

struct QuizBrain {
    
    var questions: [DataModel] = [
        DataModel(question: "Alabama", answer: "Montgomery"),
        DataModel(question: "Alaska", answer: "Juneau"),
        DataModel(question: "Arizona", answer: "Phoenix"),
        DataModel(question: "Arkansas", answer: "Little Rock"),
        DataModel(question: "California", answer: "Sacramento"),
        DataModel(question: "Colorado", answer: "Denver"),
        DataModel(question: "Connecticut", answer: "Hartford"),
        DataModel(question: "Delaware", answer: "Dover"),
        DataModel(question: "Florida", answer: "Tallahassee"),
        DataModel(question: "Georgia", answer: "Atlanta"),
        DataModel(question: "Hawaii", answer: "Honolulu"),
        DataModel(question: "Idaho", answer: "Boise"),
        DataModel(question: "Illinois", answer: "Springfield"),
        DataModel(question: "Indiana", answer: "Indianapolis"),
        DataModel(question: "Iowa", answer: "Des Moines"),
        DataModel(question: "Kansas", answer: "Topeka"),
        DataModel(question: "Kentucky", answer: "Frankfort"),
        DataModel(question: "Louisiana", answer: "Baton Rouge"),
        DataModel(question: "Maine", answer: "Augusta"),
        DataModel(question: "Maryland", answer: "Annapolis"),
        DataModel(question: "Massachusetts", answer: "Boston"),
        DataModel(question: "Michigan", answer: "Lansing"),
        DataModel(question: "Minnesota", answer: "Saint Paul"),
        DataModel(question: "Mississippi", answer: "Jackson"),
        DataModel(question: "Missouri", answer: "Jefferson City"),
        DataModel(question: "Montana", answer: "Helena"),
        DataModel(question: "Nebraska", answer: "Lincoln"),
        DataModel(question: "Nevada", answer: "Carson City"),
        DataModel(question: "New Hampshire", answer: "Concord"),
        DataModel(question: "New Jersey", answer: "Trenton"),
        DataModel(question: "New Mexico", answer: "Santa Fe"),
        DataModel(question: "New York", answer: "Albany"),
        DataModel(question: "North Carolina", answer: "Raleigh"),
        DataModel(question: "North Dakota", answer: "Bismark"),
        DataModel(question: "Ohio", answer: "Columbus"),
        DataModel(question: "Oklahoma", answer: "Oklahoma City"),
        DataModel(question: "Oregon", answer: "Salem"),
        DataModel(question: "Pennsylvania", answer: "Harrisburg"),
        DataModel(question: "Rhode Island", answer: "Providence"),
        DataModel(question: "South Carolina", answer: "Columbia"),
        DataModel(question: "South Dakota", answer: "Pierre"),
        DataModel(question: "Tennessee", answer: "Nashville"),
        DataModel(question: "Texas", answer: "Austin"),
        DataModel(question: "Utah", answer: "Salt Lake City"),
        DataModel(question: "Vermont", answer: "Montpelier"),
        DataModel(question: "Virginia", answer: "Richmond"),
        DataModel(question: "Washington", answer: "Olympia"),
        DataModel(question: "West Virginia", answer: "Charleston"),
        DataModel(question: "Wisconsin", answer: "Madison"),
        DataModel(question: "Wyoming", answer: "Cheyenne")
    ]

    let defaults = UserDefaults.standard
    
    var currentQuestionIndex = 0
    var score = 0
    
    func getQuestionText() -> String {
        let currentQuestionIndex = defaults.integer(forKey: K.currentQuestionIndex)
        return questions[currentQuestionIndex].question
    }
    
    mutating func checkAnswer(_ userAnswer: String) -> String {
        var currentQuestionIndex = defaults.integer(forKey: K.currentQuestionIndex)
        currentQuestionIndex += 1
        defaults.set(currentQuestionIndex, forKey: K.currentQuestionIndex)
        let answer = questions[currentQuestionIndex - 1].answer
        if userAnswer == answer.lowercased() {
            var score = defaults.integer(forKey: K.score)
            score += 1
            defaults.set(score, forKey: K.score)
            return "Correct"
        } else {
            return "Wrong, the Capital of \(questions[currentQuestionIndex - 1].question) is \(answer)"
        }
    }
    
    mutating func nextQuestion() -> Bool {
        var currentQuestionIndex = defaults.integer(forKey: K.currentQuestionIndex)
        if currentQuestionIndex < questions.count {
            return true
        } else {
            currentQuestionIndex = 0
            defaults.set(currentQuestionIndex, forKey: K.currentQuestionIndex)
            return false
        }
    }
    
    func getScore() -> String {
        let score = defaults.integer(forKey: K.score)
        return "Score: \(score)"
    }
    
    func getRandomColor() -> UIColor {
        let colors = [UIColor.systemRed, UIColor.systemBlue, UIColor.systemGreen, UIColor.systemPink, UIColor.systemTeal, UIColor.systemOrange, UIColor.systemYellow, UIColor.systemPurple, UIColor.systemIndigo]
        let randomNumber = Int.random(in: 0...colors.count-1)
        return colors[randomNumber]
    }

}
