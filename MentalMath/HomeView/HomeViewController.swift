//
//  HomeViewController.swift
//  MentalMath
//
//  Created by Jonas Vetsch on 26.09.2024.
//

import UIKit

class HomeViewController: UIViewController {

    var userScore: Int = 0
    
    let mainTitle: UILabel = {
        let label = UILabel()
        label.text = "Welcome"
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    let subtitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up views
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        /// This is in viewWillAppear instead of viewDidLoad so that it triggers after exercises too.
        /// After an exercise ends, the view doesn't load freshly, as it's still in the navigation stack.
        getScore()
    }
    
    private func setupUI() {
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(mainTitle)
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        mainTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        mainTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        
        
        view.addSubview(subtitle)
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        subtitle.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 5).isActive = true
        subtitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        setSubtitle()
        
        view.addSubview(scoreLabel)
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        scoreLabel.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 90).isActive = true
        
        let exercieses = ExercisesCollectionViewController()
        addChild(exercieses)
        view.addSubview(exercieses.view)
        exercieses.didMove(toParent: self)
        exercieses.view.translatesAutoresizingMaskIntoConstraints = false
        exercieses.view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        exercieses.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        exercieses.view.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        exercieses.view.heightAnchor.constraint(equalToConstant: (80 + 16) * 4 + 16).isActive = true
    }
    
    private func setSubtitle() {
        let currentDate = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: currentDate)
        
        if hour > 18 {
            subtitle.text = "Good Evening, Jonas"
        } else if hour > 12 {
            subtitle.text = "Good Afternoon, Jonas"
        } else {
            subtitle.text = "Good Morning, Jonas"
        }
    }
    
    private func getScore() {
        let fetchedScore = UserDefaults.standard.integer(forKey: "userScore")
        if fetchedScore != userScore {
            userScore = fetchedScore
            scoreLabel.text = "\(userScore)"
        }
    }
}


#Preview {
    HomeViewController()
}
