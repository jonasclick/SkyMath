//
//  KeyboardCell.swift
//  MentalMath
//
//  Created by Jonas Vetsch on 29.09.2024.
//

import UIKit

class KeyboardCell: UICollectionViewCell {
    
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Set up the cell
        layer.cornerRadius = 8
        layer.masksToBounds = true
        backgroundColor = traitCollection.userInterfaceStyle == .dark ? .darkGray : .earthGray
        
        // Set up the label
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Set up text for label
    func configure(with key: String) {
        label.text = key
    }
}
