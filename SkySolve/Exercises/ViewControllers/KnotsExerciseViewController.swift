//
//  KnotsExerciseViewController.swift
//  MentalMath
//
//  Created by Jonas Vetsch on 26.09.2024.
//

import UIKit

class KnotsExerciseViewController: UIViewController, KeyboardCollectionViewControllerDelegate {
    
    var currentQuestion: String? = nil
    var currentSolution: Int? = nil
    var score: Int = 0
    
    let mainTitle: UILabel = {
        let label = UILabel()
        label.text = "Knots"
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    let subtitle: UILabel = {
        let label = UILabel()
        label.text = "1 kt = 1.852 km/h but in this exercise 1 kt = 2 km/h"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    let question: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }()
    
    let answerField: UITextField = {
        let field = UITextField()
        field.keyboardType = .decimalPad
        field.textAlignment = .center
        field.tintColor = .clear // Hide cursor when editing.
        field.font = UIFont.preferredFont(forTextStyle: .title3)
        field.isUserInteractionEnabled = false // Disable user interaction
        return field
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(mainTitle)
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        mainTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        mainTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        
        view.addSubview(subtitle)
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        subtitle.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 10).isActive = true
        subtitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        
        view.addSubview(answerField)
        answerField.translatesAutoresizingMaskIntoConstraints = false
        answerField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        answerField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        answerField.becomeFirstResponder()
        
        view.addSubview(question)
        question.translatesAutoresizingMaskIntoConstraints = false
        question.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        question.bottomAnchor.constraint(equalTo: answerField.topAnchor, constant: -15).isActive = true
        
        view.addSubview(scoreLabel)
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        scoreLabel.bottomAnchor.constraint(equalTo: question.topAnchor, constant: -40).isActive = true
        
        let keyboard = KeyboardCollectionViewController()
        keyboard.delegate = self
        addChild(keyboard)
        view.addSubview(keyboard.view)
        keyboard.view.translatesAutoresizingMaskIntoConstraints = false
        keyboard.view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        keyboard.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70).isActive = true
        keyboard.view.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        keyboard.view.heightAnchor.constraint(equalToConstant: 230).isActive = true
        keyboard.didMove(toParent: self)
        
        setProblem()
        
        NotificationCenter.default.addObserver(self, selector: #selector(saveDataBeforeBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)

    }
    
    // Handle Key Tap from KeyboardCollectionViewController and evaluate answer
    func onKeyTapped(_ key: String) {
        switch key {
        case "⌫":
            if !answerField.text!.isEmpty {
                answerField.text?.removeLast()
            }
        case "–":
            // Handle "–" Tap
            if let text = answerField.text, !text.contains("-") {
                answerField.text = "-" + text
            }
            else if let text = answerField.text, text.contains("-") {
                answerField.text?.removeFirst()
            }
            
            // Check if the "-" made the answer correct
            if let text = answerField.text, let answer = Int(text), answer == currentSolution {
                setProblem()
                updateScore()
            }
        default:
            answerField.text?.append(key)
            
            // Check if answer is correct
            if let text = answerField.text, let answer = Int(text), answer == currentSolution {
                setProblem()
                updateScore()
            }
        }
    }
    
    // Create a new problem for the user to answer
    private func setProblem() {
        let knots = Int.random(in: 1...250)
        
        currentSolution = knots * 2
        question.text = "\(knots) kt in km/h"
        answerField.text = ""
    }
    
    // Update score in this exercise
    private func updateScore() {
        score += 1
        scoreLabel.text = "\(score)"
    }
    
    // Save score of the exercise to the total score (HomeView)
    private func saveScore() {
        let previousScore = UserDefaults.standard.integer(forKey: "userScore")
        UserDefaults.standard.set(previousScore + score, forKey: "userScore")
        score = 0
    }
    
    // Update Total User Score when ending the exercise
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveScore()
    }
    
    // When user goes to home screen, save score to prevent losing it.
    @objc private func saveDataBeforeBackground() {
        saveScore()
    }
}

#Preview {
    KnotsExerciseViewController()
}
