//
//  GameSettings.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/7/21.
//

import Foundation


struct GameSettings {

    private var numberOfPlayers: Int
    private var startingLifeTotals: Int
    
    init(numberOfPlayers: Int, startingLifeTotals: Int) {
        self.numberOfPlayers = numberOfPlayers
        self.startingLifeTotals = startingLifeTotals
    }
    
    // MARK: - Access to the Model
    
    var getNumberOfPlayers: Int {
        numberOfPlayers
    }
    
    var getStartingLifeTotals: Int {
        startingLifeTotals
    }
    
    // MARK: - Intents
    
    mutating func changeNumberOfPlayers(to players: Int) {
        numberOfPlayers = players
    }
    
    mutating func changeStartingLifeTotals(to lifetotal: Int) {
        startingLifeTotals = lifetotal
    }
}
