//
//  GameStateService.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/12/21.
//

import Foundation
import SwiftUI


protocol GameStateService {
    var performedFirstTimeStartUp: Bool { get }
    
    // UserSettings
    var commanderDamageEnabled: Bool { get }
    var playerNamesEnabled: Bool { get }
    
    var customLife: String { get }
    var customLifeEnabled: Bool { get }
    var playerLife: Int{ get }
    var startingPlayerCount: Int { get }
    
    var screenStaysOn: Bool { get }
    
    // DefaultCounters
    var commanderTax: Bool { get }
    var energy: Bool { get }
    var experience: Bool { get }
    var storm: Bool { get }
}

struct RealGameStateService: GameStateService {
    
    private let gameState: PersistentData
    
    init(gameState: PersistentData) {
        self.gameState = gameState
    }
    
    var performedFirstTimeStartUp: Bool {
        gameState.userSettings.performedFirstTimeStartUp
    }
    
    // MARK: - UserSettings
    
    var commanderDamageEnabled: Bool {
        gameState.userSettings.commanderDamageEnabled
    }
    
    var playerNamesEnabled: Bool {
        gameState.userSettings.playerNamesEnabled
    }
    
    var customLife: String {
        gameState.userSettings.customLife
    }
    
    var customLifeEnabled: Bool {
        gameState.userSettings.customLifeEnabled
    }
    
    var playerLife: Int {
        gameState.userSettings.playerLife
    }
    
    var startingPlayerCount: Int {
        gameState.userSettings.startingPlayersCount
    }
    
    
    var screenStaysOn: Bool {
        gameState.userSettings.screenStaysOn
    }
    
    // MARK: - DefaultCounters
    
    var commanderTax: Bool {
        gameState.defaultCounters.commanderTax
    }
    
    var energy: Bool {
        gameState.defaultCounters.energy
    }
    
    var experience: Bool {
        gameState.defaultCounters.experience
    }
    
    var storm: Bool {
        gameState.defaultCounters.storm
    }
}


struct StubGameStateService: GameStateService {
    
    var performedFirstTimeStartUp: Bool { return true }

    // UserSettings
    var commanderDamageEnabled: Bool { return true }
    var playerNamesEnabled: Bool { return true }
    
    var customLife: String { return "50" }
    var customLifeEnabled: Bool { return false }
    var playerLife: Int { return 40 }
    var startingPlayerCount: Int { return 4 }
    
    var screenStaysOn: Bool { return true }
    // DefaultCounters
    var commanderTax: Bool { return false }
    var energy: Bool { return false }
    var experience: Bool { return false }
    var storm: Bool { return false }
}
