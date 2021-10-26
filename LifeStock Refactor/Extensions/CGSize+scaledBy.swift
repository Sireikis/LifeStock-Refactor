//
//  CGSize+scaledBy.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/4/21.
//

import SwiftUI


extension CGSize {
    
    /// Used to scale the screen space available to a component up or down.
    func scaledBy(widthFactor: CGFloat = 1, heightFactor: CGFloat = 1) -> CGSize {
        CGSize(width: self.width / widthFactor, height: self.height / heightFactor)
    }
}
