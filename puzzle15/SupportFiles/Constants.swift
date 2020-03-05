//
//  Constants.swift
//  puzzle15
//
//  Created by siret on 02.03.2020.
//  Copyright © 2020 siret. All rights reserved.
//

import Foundation
import UIKit

enum ColorPalette {
    static let Red = UIColor(red: 1.0, green: 0.1491, blue: 0.0, alpha: 1.0)
    static let Green = UIColor(red: 0.0, green: 0.5628, blue: 0.3188, alpha: 1.0)
    static let Blue = UIColor(red: 0.0, green: 0.3285, blue: 0.5749, alpha: 1.0)
    
    // Gray is now an enum with no cases!
    enum Gray {
        static let Light = UIColor(white: 0.8374, alpha: 1.0)
        static let Medium = UIColor(white: 0.4756, alpha: 1.0)
        static let Dark = UIColor(white: 0.2605, alpha: 1.0)
    }
}
