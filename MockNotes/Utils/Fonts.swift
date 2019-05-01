//
//  Fonts.swift
//  MockNotes
//
//  Created by Raphael Souza on 2019-04-26.
//  Copyright © 2019 Raphael Inc. All rights reserved.
//

import UIKit

struct Fonts {
    enum Nunito: String {
        case regular = "Regular"
        case semiBold = "SemiBold"
        case extraBold = "ExtraBold"
        
        /// Return the font with the given size
        func size(_ size: CGFloat) -> UIFont {
            return UIFont(name: "Nunito-\(self.rawValue)", size: size)!
        }
    }
}
