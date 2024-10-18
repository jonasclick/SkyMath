//
//  SettingsViewController.swift
//  MentalMath
//
//  Created by Jonas Vetsch on 18.10.2024.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {
  
  let mainTitle: UILabel = {
    let label = UILabel()
    label.text = "Settings"
    label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
    return label
  }()
  
  let adjustName: UILabel = {
    let label = UILabel()
    label.text = "How would you like to be called?"
    label.font = UIFont.preferredFont(forTextStyle: .body)
    return label
  }()
  
  let nameField: UITextField = {
    let field = UITextField()
    field.placeholder = "Enter your name"
    field.borderStyle = .roundedRect
    field.returnKeyType = .done
    return field
  }()
  
  let nameButton: UIButton = {
    let button = UIButton()
    var config = UIButton.Configuration.filled()
    
    config.title = "Save"
    config.cornerStyle = .large
    
    button.configuration = config
    return button
  }()
  
  let versionLabel: UILabel = {
    let label = UILabel()
    
    if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
      label.text = "Version: \(version)"
    } else {
      label.text = "Version: Unknown"
    }
    
    label.font = UIFont.preferredFont(forTextStyle: .caption1)
    label.layer.opacity = 0.7
    return label
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemBackground
    nameField.delegate = self
    
    view.addSubview(mainTitle)
    mainTitle.translatesAutoresizingMaskIntoConstraints = false
    mainTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
    mainTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 84).isActive = true
    
    view.addSubview(adjustName)
    adjustName.translatesAutoresizingMaskIntoConstraints = false
    adjustName.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 40).isActive = true
    adjustName.leadingAnchor.constraint(equalTo: mainTitle.leadingAnchor, constant: 0).isActive = true
    
    view.addSubview(nameField)
    nameField.translatesAutoresizingMaskIntoConstraints = false
    nameField.topAnchor.constraint(equalTo: adjustName.bottomAnchor, constant: 10).isActive = true
    nameField.leadingAnchor.constraint(equalTo: mainTitle.leadingAnchor, constant: 0).isActive = true
    nameField.widthAnchor.constraint(equalToConstant: 250).isActive = true
    
    view.addSubview(nameButton)
    nameButton.translatesAutoresizingMaskIntoConstraints = false
    nameButton.centerYAnchor.constraint(equalTo: nameField.centerYAnchor).isActive = true
    nameButton.leadingAnchor.constraint(equalTo: nameField.trailingAnchor, constant: 10).isActive = true
    nameButton.widthAnchor.constraint(equalToConstant: 67).isActive = true
    nameButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
    nameButton.addTarget(self, action: #selector(setUsername), for: .touchUpInside)
    
    view.addSubview(versionLabel)
    versionLabel.translatesAutoresizingMaskIntoConstraints = false
    versionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
    versionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
  }
  
  @objc private func setUsername() {
    UserDefaults.standard.set(nameField.text, forKey: "userName")
    navigationController?.popViewController(animated: true)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    setUsername()
    textField.resignFirstResponder()
    return true
  }
}

#Preview {
  SettingsViewController()
}
