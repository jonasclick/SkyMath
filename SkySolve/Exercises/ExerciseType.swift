//
//  ExerciseType.swift
//  MentalMath
//
//  Created by Jonas Vetsch on 27.09.2024.
//

import Foundation

enum ExerciseType: String, CaseIterable {
    case addition
    case subtraction
    case multiplication
    case division
    
    var symbol: String {
        switch self {
        case .addition: return "+"
        case .subtraction: return "-"
        case .multiplication: return "×"
        case .division: return "÷"
        }
    }
}
