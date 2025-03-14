//
//  HomeViewController.swift
//  MentalMath
//
//  Created by Jonas Vetsch on 26.09.2024.
//

import UIKit
import SwiftUI

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
  
  let settingsButton: UIButton = {
    let button = UIButton()
    var config = UIButton.Configuration.plain()
    let image = UIImage(systemName: "gearshape")
    config.image = image
    config.imagePadding = 8
    
    // Customize the content insets to increase the tappable area
    config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

    button.configuration = config
    button.tintColor = .label
    button.layer.opacity = 0.7
    return button
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
    setSubtitle()
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
    
    view.addSubview(settingsButton)
    settingsButton.translatesAutoresizingMaskIntoConstraints = false
    settingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    settingsButton.topAnchor.constraint(equalTo: mainTitle.topAnchor, constant: 30).isActive = true
    settingsButton.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
    
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
    let name = UserDefaults.standard.string(forKey: "userName") ?? ""
    
    if hour > 18 {
      subtitle.text = "Good Evening, \(name)"
    } else if hour > 12 {
      subtitle.text = "Good Afternoon, \(name)"
    } else {
      subtitle.text = "Good Morning, \(name)"
    }
  }
  
  private func getScore() {
    let fetchedScore = UserDefaults.standard.integer(forKey: "userScore")
    if fetchedScore != userScore {
      userScore = fetchedScore
      scoreLabel.text = "\(userScore)"
    }
  }
  
  @objc private func openSettings() {
    navigationController?.pushViewController(SettingsViewController(), animated: true)
  }
}


#Preview {
  HomeViewController()
}
