//
//  ExercisesCollectionViewController.swift
//  MentalMath
//
//  Created by Jonas Vetsch on 27.09.2024.
//

import UIKit

private let reuseIdentifier = "Cell"

class ExercisesCollectionViewController: UICollectionViewController {
    
    let labels: [String] = ["+", "−", "×", "÷", "ft to m", "FL to m", "kt to km/h", "NM to km", "Heading", "3 Times Table"]
    
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
        
        // Padding around the collection view
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        
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
        
        cell.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .darkGray : .earthGray
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        // Create and configure the label
        let label = UILabel()
        label.text = labels[indexPath.row]
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
        
        // Highlight tapped cell
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .gray : .earthSand
            
            // Reset color after a short delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                cell.backgroundColor = self.traitCollection.userInterfaceStyle == .dark ? .darkGray : .earthGray
            }
        }
        
        // Navigation Logic: Start the 4 Basic Operators Exercises
        if indexPath.row < ExerciseType.allCases.count {
            let selectedExercise = ExerciseType.allCases[indexPath.row]
            
            let viewController = ExerciseViewController(exerciseType: selectedExercise)
            
            navigationController?.pushViewController(viewController, animated: true)
        } else {
            switch indexPath.row {
            case 4:
                navigationController?.pushViewController(FeetExerciseViewController(), animated: true)
            case 5:
                navigationController?.pushViewController(FlightLevelExerciseViewController(), animated: true)
            case 6:
                navigationController?.pushViewController(KnotsExerciseViewController(), animated: true)
            case 7:
                navigationController?.pushViewController(NauticalMilesExerciseViewController(), animated: true)
            case 8:
                navigationController?.pushViewController(HeadingExerciseViewController(), animated: true)
            case 9:
                navigationController?.pushViewController(TimesTableExerciseViewController(timesTable: 3), animated: true)
            default:
                print("Exercise not yet implemented")
            }
        }
    }
}


extension ExercisesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    // Set the spacing between cells (horizontal)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0 // Spacing between cells
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row < 4 {
            return .init(width: (UIScreen.main.bounds.width - 80) / 4, height: 80)
        } else {
            return .init(width: (UIScreen.main.bounds.width - 48) / 2, height: 80)
        }
    }
}

#Preview {
    ExercisesCollectionViewController()
}
