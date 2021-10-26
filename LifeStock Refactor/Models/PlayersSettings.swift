//
//  PlayersSettings.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/7/21.
//

import Foundation

// Global settings for Name and Commander Damage
// Toggled through MenuScreen on PlayerCardsView
struct PlayersSettings {
    
    var commanderDamageEnabled: Bool = true
    var namesEnabled: Bool = true
    
    mutating func toggle(setting: PlayerSetting) {
        switch setting {
        case .commanderDamageEnabled:
            commanderDamageEnabled.toggle()
        case .namesEnabled:
            namesEnabled.toggle()
        }
    }
    
    mutating func set(_ setting: PlayerSetting, to value: Bool) {
        switch setting {
        case .commanderDamageEnabled:
            commanderDamageEnabled = value
        case .namesEnabled:
            namesEnabled = value
        }
    }
}

extension PlayersSettings {
    
    enum PlayerSetting {
        
        case commanderDamageEnabled
        case namesEnabled
    }
}
