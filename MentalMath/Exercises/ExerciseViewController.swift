//
//  ViewController.swift
//  MentalMath
//
//  Created by Jonas Vetsch on 26.09.2024.
//

import UIKit

class ExerciseViewController: UIViewController {
    
    var exerciseType: ExerciseType
    
    var currentQuestion: String? = nil
    var currentSolution: Int? = nil
    var score: Int = 0
    
    let mainTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textColor = .label
        return label
    }()
    
    let subtitle: UILabel = {
        let label = UILabel()
        label.text = "Do good and good will come your way."
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .label
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .label
        return label
    }()
    
    let question: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .label
        return label
    }()
    
    let answerField: UITextField = {
        let field = UITextField()
        field.keyboardType = .numberPad
        field.textAlignment = .center
        return field
    }()
    
    // Let caller pass in an exercise type
    init(exerciseType: ExerciseType) {
        self.exerciseType = exerciseType
        super.init(nibName: nil, bundle: nil)
    }
    
    // Required initializer for using UIViewControllers with Storyboards
    required init?(coder: NSCoder) {
        // Not using storyboards, so we say:
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(mainTitle)
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        mainTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        mainTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        mainTitle.text = exerciseType.rawValue.capitalized
        
        view.addSubview(subtitle)
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        subtitle.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 10).isActive = true
        subtitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        
        view.addSubview(answerField)
        answerField.translatesAutoresizingMaskIntoConstraints = false
        answerField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        answerField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        answerField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        answerField.becomeFirstResponder()
        
        view.addSubview(question)
        question.translatesAutoresizingMaskIntoConstraints = false
        question.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        question.bottomAnchor.constraint(equalTo: answerField.topAnchor, constant: -15).isActive = true
        
        
        view.addSubview(scoreLabel)
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        scoreLabel.bottomAnchor.constraint(equalTo: question.topAnchor, constant: -40).isActive = true
        
        setProblem()
    }
    
    func setProblem() {
        let int1 = Int.random(in: 1...99)
        let int2 = Int.random(in: 1...99)
        
        currentSolution = {
            switch exerciseType {
            case .addition:
                return int1 + int2
            case .subtraction:
                return int1 - int2
            case .multiplication:
                return int1 * int2
            case .division:
                return int1 / int2
            }
        }()
        
        question.text = "\(int1) \(exerciseType.symbol) \(int2)"
        answerField.text = ""
    }
    
    func updateScore() {
        score += 1
        scoreLabel.text = "\(score)"
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, let answer = Int(text), answer == currentSolution {
            setProblem()
            updateScore()
        }
    }
    
    // Update Total User Score when ending the exercise
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let previousScore = UserDefaults.standard.integer(forKey: "userScore")
        UserDefaults.standard.set(previousScore + score, forKey: "userScore")
    }
}

#Preview {
    ExerciseViewController(exerciseType: .addition)
}
