//
//  View+transitions.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/12/21.
//

import SwiftUI


extension View {
    
    func transitionFromLeft() -> some View {
        self.transition(.move(edge: .leading))
    }
    
    func transitionFromRight() -> some View {
        self.transition(.move(edge: .trailing))
    }
    
    func transitionFromRightAndFlip() -> some View {
        self.rotationEffect(.degrees(-180))
            .transition(.move(edge: .trailing))
    }
    
    func transitionFromBottom() -> some View {
        self.transition(.move(edge: .bottom))
    }
    
    func transitionFromBottomAndFlip() -> some View {
        self.rotationEffect(.degrees(-180))
            .transition(.move(edge: .bottom))
    }
    
    func transitionFromTop() -> some View {
        self.transition(.move(edge: .top))
    }
    
    func transitionFromTopAndFlip() -> some View {
        self.rotationEffect(.degrees(-180))
            .transition(.move(edge: .top))
    }
    
    func transitionFade() -> some View {
        self.transition(.opacity)
    }
    
    func transitionIdentity() -> some View {
        self.transition(.identity)
    }
}
