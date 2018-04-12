//
//  ColorMode.swift
//  TMDB Test
//
//  Created by Micah Lanier on 3/23/18.
//  Copyright © 2018 Micah Lanier. All rights reserved.
//

import Foundation
import UIKit


enum ColorMode {
    case light
    case dark
    
    var statusBarStyle: UIStatusBarStyle {
        switch self {
        case .light:
            return .default
        case .dark:
            return .lightContent
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .light:
            return UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        case .dark:
            return UIColor(red: 27/255, green: 29/255, blue: 33/255, alpha: 1)
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .light:
            return UIColor(red: 27/255, green: 29/255, blue: 33/255, alpha: 1)
        case .dark:
            return UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1)
        }
    }
    
    func changeColorMode() -> ColorMode {
        switch self {
        case .light:
            return .dark
        case .dark:
            return .light
        }
    }
    
    
}
