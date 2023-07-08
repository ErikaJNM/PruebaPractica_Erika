//
//  Settings.swift
//  PruebaPractica_Erika
//
//  Created by MacBookMBA1 on 07/07/23.
//

import Foundation
import UIKit

class Settings{
    
    static func vibrate(mode: VibrationMode) {
        let generator: UIImpactFeedbackGenerator
        
        switch mode {
            case .light:
                generator = UIImpactFeedbackGenerator(style: .light)
            case .medium:
                generator = UIImpactFeedbackGenerator(style: .medium)
            case .heavy:
                generator = UIImpactFeedbackGenerator(style: .heavy)
        }
        
        generator.prepare()
        generator.impactOccurred()
    }
}
