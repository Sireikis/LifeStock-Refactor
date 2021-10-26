//
//  PersistentData.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/12/21.
//

import SwiftUI


class PersistentData: ObservableObject {
    
    var userSettings = UserSettings()
    var defaultCounters = DefaultCounters()
    
}

extension PersistentData {
    
    struct UserSettings {
        
        private let defaults: UserDefaults = UserDefaults()
        
        /*
         PersistentData properties don't have values until the SettingsScreenView is visited.
         This value and other bool values default to false on first time startup.
         */
        var performedFirstTimeStartUp: Bool {
            defaults.bool(forKey: "performedFirstTimeStartUp")
        }
        
        // Controls global playerName and playerCommanderDamage settings
        // Checkboxes on choosePlayers and MenuScreen will be unchecked
        // Checkboxes on individual players will remain.
        var commanderDamageEnabled: Bool {
            defaults.bool(forKey: "commanderDamageEnabled")
        }
        
        var playerNamesEnabled: Bool {
            defaults.bool(forKey: "playerNamesEnabled")
        }
        
        // Default settings for starting players and life
        var customLife: String {
            defaults.string(forKey: "customLife")!
        }
        
        var customLifeEnabled: Bool {
            defaults.bool(forKey: "customLifeEnabled")
        }
        
        var playerLife: Int {
            defaults.integer(forKey: "playerLife")
        }
        
        var startingPlayersCount: Int {
            defaults.integer(forKey: "startingPlayersCount")
        }
        
        // Need to display content while user interaction is minimal
        // Decides whether isIdleTimerDisabled is set to true
        var screenStaysOn: Bool {
            defaults.bool(forKey: "screenStaysOn")
        }
    }
}

extension PersistentData {
    
    struct DefaultCounters {
        
        private let defaults: UserDefaults = UserDefaults()
        
        var commanderTax: Bool {
            defaults.bool(forKey: "commanderTax")
        }
        
        var energy: Bool {
            defaults.bool(forKey: "energy")
        }
        
        var experience: Bool {
            defaults.bool(forKey: "experience")
        }
        
        var storm: Bool {
            defaults.bool(forKey: "storm")
        }
    }
}
