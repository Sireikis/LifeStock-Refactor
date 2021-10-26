//
//  View+hideKeyboard.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/5/21.
//

import SwiftUI


extension View {
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
