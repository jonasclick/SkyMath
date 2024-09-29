//
//  KeyboardCollectionViewController.swift
//  MentalMath
//
//  Created by Jonas Vetsch on 28.09.2024.
//

import UIKit

private let reuseIdentifier = "Cell"

class KeyboardCollectionViewController: UICollectionViewController {
    
    weak var delegate: KeyboardCollectionViewControllerDelegate?
    
    let keys: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "–", "0", "⌫"]
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        self.collectionView!.register(KeyboardCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Padding around the collection view
        collectionView.contentInset = .init(top: 0, left: 8, bottom: 0, right: 8)
        
        // Vertical spacing between rows
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 10
        }
        
        /// Custom highlighting on tap, as built in highlighting reacts too slow
        collectionView.allowsSelection = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        collectionView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1 // Sections
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keys.count // Items in Section
    }
    
    // Configure each cell with it's own label
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! KeyboardCell
        
        cell.configure(with: keys[indexPath.row])
        return cell
    }
    
    /// Custom highlighting when cell is tapped (default highlighting was too slow)
    @objc private func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: location),
           let cell = collectionView.cellForItem(at: indexPath) as? KeyboardCell {
            
            // Handle instant highlight, dynamic
            cell.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .gray : .earthSand
            
            // Perform the tap action
            let selectedKey = keys[indexPath.row]
            delegate?.onKeyTapped(selectedKey)
            
            // Reset color after a short delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
                cell.backgroundColor = self.traitCollection.userInterfaceStyle == .dark ? .darkGray : .earthGray
            }
        }
    }
}

// Configure cell dimensions (width and height)
extension KeyboardCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (UIScreen.main.bounds.width - 38) / 3, height: 50)
    }
}

// Delegate protocol
protocol KeyboardCollectionViewControllerDelegate: AnyObject {
    func onKeyTapped(_ key: String)
}

#Preview {
    KeyboardCollectionViewController()
}
