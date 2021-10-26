//
//  Font+getFont.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/4/21.
//

import SwiftUI


extension Font {
    
    static func getFont(size: CGSize, scalingFactor: CGFloat) -> Font {
        self.system(size: min(size.width, size.height) * scalingFactor)
    }
}
