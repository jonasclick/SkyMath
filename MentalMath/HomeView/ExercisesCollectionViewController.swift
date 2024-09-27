//
//  ExercisesCollectionViewController.swift
//  MentalMath
//
//  Created by Jonas Vetsch on 27.09.2024.
//

import UIKit

private let reuseIdentifier = "Cell"

class ExercisesCollectionViewController: UICollectionViewController {
    
    let labels: [String] = ["+", "−", "×", "÷", "All Operators", "All Operators Advanced", "ft to m", "kt to km/h", "Course", ""]
    let colors: [UIColor] = [.earthLime, .earthBrown, .earthGreen, .earthSand, .earthGray]
    
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView.contentInset = .init(top: 16, left: 16, bottom: 16, right: 16)
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            // Vertical Spacing between rows
            layout.minimumLineSpacing = 16
        }
    }
    
    
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return labels.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        cell.backgroundColor = colors[indexPath.row % colors.count]
        
        
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        // Create and configure the label
        let label = UILabel()
        label.text = labels[indexPath.row]
        label.textColor = .label
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        cell.contentView.addSubview(label)
        label.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor).isActive = true

        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    // Handle Tap on cells
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("DEBUG: Did select item at index path \(indexPath)")

        // Start the 4 Basic Operators Exercises
        if indexPath.row < ExerciseType.allCases.count {
            print("Selected \(ExerciseType.allCases[indexPath.row])")
            
            let selectedExercise = ExerciseType.allCases[indexPath.row]
            
            let viewController = ExerciseViewController(exerciseType: selectedExercise)
            
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}


extension ExercisesCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (UIScreen.main.bounds.width - 48) / 2, height: 80)
    }
}

#Preview {
    ExercisesCollectionViewController()
}
