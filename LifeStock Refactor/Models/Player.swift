//
//  Player.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/7/21.
//

import SwiftUI


struct Player {
    
    var commanderDamage: CommanderDamage
    var counters: Counters
    var life: Life
    var name: String
    var settings: Settings
    
    var id: Int
}

extension Player {
    
    struct CommanderDamage {
        
        // From player 1,2,3,4
        var damageTaken: [Int] = [0,0,0,0]
        var isDisplayed: Bool = true
    }
}

extension Player {
    
    struct Counters {
        
        var commanderTax = (quantity: 0, isPresented: false)
        var storm = (quantity: 0, isPresented: false)
        var experience = (quantity: 0, isPresented: false)
        var energy = (quantity: 0, isPresented: false)
        
        var counterViewEnabled: Bool = false
        var areModifiable: Bool = false
    }
}

extension Player {
    
    struct Life {
        
        var lifeTotal: Int {
            didSet {
                lifeTotalHistory.append(lifeTotal)
            }
        }
        var lifeTotalHistory: [Int?] = []
    }
}

extension Player {
    
    struct Settings {
        
        var isMonarch: Bool = false
        var isNameDisplayed: Bool = true
        var playerColor: Color = LifeStockColor.darkBackground
    }
}
