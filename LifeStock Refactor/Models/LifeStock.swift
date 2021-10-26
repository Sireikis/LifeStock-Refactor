//
//  LifeStock.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/7/21.
//

import Foundation
import SwiftUI


struct LifeStock {
    
    var players: [Player]
    var playerIDSelected: Int // Currently selected player
    
    var playersSettings: PlayersSettings
    var gameSettings: GameSettings
    
    var calculator: Calculator
}

// MARK: - Intents
extension LifeStock {
    
    // MARK: - Player Intents
    
    // MARK: Commander Damage
    
    
    mutating func decrementCommanderDamageOf(player hurtPlayer: Int, from attackingPlayer: Int) {
        players[hurtPlayer - 1].commanderDamage.damageTaken[attackingPlayer - 1] -= 1
    }
    
    mutating func incrementCommanderDamageOf(player hurtPlayer: Int, from attackingPlayer: Int) {
        players[hurtPlayer - 1].commanderDamage.damageTaken[attackingPlayer - 1] += 1
    }
    
    func getCommanderDamage(of player: Int, from attackingPlayer: Int) -> Int {
        players[player - 1].commanderDamage.damageTaken[attackingPlayer - 1]
    }
    
    func commanderDamageEnabled(for player: Int) -> Bool {
        players[player - 1].commanderDamage.isDisplayed
    }
    
    mutating func toggleCommanderDamageDisplayfor(player: Int) {
        players[player - 1].commanderDamage.isDisplayed.toggle()
    }
    
    // MARK: Counters
    
    mutating func toggleCounterOnPlayerCard(for player: Int, counter: CounterType) {
        switch counter {
        case .commanderTax:
            players[player - 1].counters.commanderTax.isPresented.toggle()
        case .storm:
            players[player - 1].counters.storm.isPresented.toggle()
        case .experience:
            players[player - 1].counters.experience.isPresented.toggle()
        case .energy:
            players[player - 1].counters.energy.isPresented.toggle()
        }
    }
    
    mutating func decrementCounterOf(player: Int, counter: CounterType) {
        switch counter {
        case .commanderTax:
            players[player - 1].counters.commanderTax.quantity -= 1
        case .storm:
            players[player - 1].counters.storm.quantity -= 1
        case .experience:
            players[player - 1].counters.experience.quantity -= 1
        case .energy:
            players[player - 1].counters.energy.quantity -= 1
        }
    }
    
    mutating func incrementCounterOf(player: Int, counter: CounterType) {
        switch counter {
        case .commanderTax:
            players[player - 1].counters.commanderTax.quantity += 1
        case .storm:
            players[player - 1].counters.storm.quantity += 1
        case .experience:
            players[player - 1].counters.experience.quantity += 1
        case .energy:
            players[player - 1].counters.energy.quantity += 1
        }
    }
    
    func isCounterDisplayedOnPlayerCardOf(player: Int, counter: CounterType) -> Bool {
        switch counter {
        case .commanderTax:
            return players[player - 1].counters.commanderTax.isPresented
        case .storm:
            return players[player - 1].counters.storm.isPresented
        case .experience:
            return players[player - 1].counters.experience.isPresented
        case .energy:
            return players[player - 1].counters.energy.isPresented
        }
    }
    
    func counterQuantityFor(player: Int, counter: CounterType) -> Int {
        switch counter {
        case .commanderTax:
            return players[player - 1].counters.commanderTax.quantity
        case .storm:
            return players[player - 1].counters.storm.quantity
        case .experience:
            return players[player - 1].counters.experience.quantity
        case .energy:
            return players[player - 1].counters.energy.quantity
        }
    }
    
    func counterViewEnabled(for player: Int) -> Bool {
        players[player - 1].counters.counterViewEnabled
    }
    
    // Just call above with player = 1
    func playerOneCounterViewEnabled() -> Bool {
        players[0].counters.counterViewEnabled
    }
    
    mutating func toggleCountersViewOf(player: Int) {
        players[player - 1].counters.counterViewEnabled.toggle()
    }
    
    func countersModifiable(player: Int) -> Bool {
        players[player - 1].counters.areModifiable
    }
    
    mutating func toggleCountersModifiable(for player: Int) {
        players[player - 1].counters.areModifiable.toggle()
    }
    
    // MARK: Life
    
    func lifeTotal(for player: Int) -> Int {
        players[player - 1].life.lifeTotal
    }
    
    mutating func increaseLifeTotalOf(player id: Int) {
        players[id - 1].life.lifeTotal += 1
        for player in players {
            if player.id + 1 != id {
                players[player.id].life.lifeTotalHistory.append(nil)
            }
        }
    }
    
    mutating func decreaseLifeTotalOf(player id: Int) {
        players[id - 1].life.lifeTotal -= 1
        for player in players {
            if player.id + 1 != id {
                players[player.id].life.lifeTotalHistory.append(nil)
            }
        }
    }
    
    func lifeTotalHistoryArrayCount(of player: Int) -> Int {
        players[player - 1].life.lifeTotalHistory.count
    }
    
    func lifeTotalHistory(of player: Int, at index: Int) -> Int? {
        players[player - 1].life.lifeTotalHistory[index]
    }
    
    // MARK: Name
    
    func playerName(for player: Int) -> String {
        players[player - 1].name
    }
    
    mutating func changePlayerName(of player: Int, to name: String) {
        players[player - 1].name = name
    }
    
    // MARK: Settings
    
    mutating func changeMonarchTo(player monarch: Int) {
        for player in 0..<numberOfPlayers {
            if player + 1 == monarch {
                players[player].settings.isMonarch.toggle()
            } else {
                players[player].settings.isMonarch = false
            }
        }
    }
    
    func isMonarch(player: Int) -> Bool {
        players[player - 1].settings.isMonarch
    }
    
    func isNameDisplayed(for player: Int) -> Bool {
        players[player - 1].settings.isNameDisplayed
    }
    
    mutating func togglePlayerNameOf(player: Int) {
        players[player - 1].settings.isNameDisplayed.toggle()
    }
    
    func currentColor(of player: Int) -> Color {
        players[player - 1].settings.playerColor
    }
    
    mutating func changeColor(of player: Int, to color: Color) {
        players[player - 1].settings.playerColor = color
    }
    
    // MARK: - PlayerIDSelected Intents
    
    mutating func changePlayerIDSelected(to player: Int) {
        playerIDSelected = player
    }
    
    // MARK: - PlayersSettings Intents
    
    var commanderDamageEnabled: Bool {
        playersSettings.commanderDamageEnabled
    }
    
    var namesEnabled: Bool {
        playersSettings.namesEnabled
    }
    
    // MARK: - LifeStock GameSettings Methods
    
    var numberOfPlayers: Int {
        gameSettings.getNumberOfPlayers
    }
    var startingLifeTotals: Int {
        gameSettings.getStartingLifeTotals
    }
}

// MARK: - Initializers

extension LifeStock {
    
    // Standard EDH Settings
    init(
        numberOfPlayers: Int = 4,
        startingLifeTotals: Int = 40,
        playersSettings: PlayersSettings = PlayersSettings()
    ) {
        self.playerIDSelected = 1
        
        self.playersSettings = playersSettings
        let gameSettings = GameSettings(numberOfPlayers: numberOfPlayers, startingLifeTotals: startingLifeTotals)
        self.gameSettings = gameSettings
        
        self.calculator = Calculator(displayField: " ")
        
        var players = [Player]()
        for player in 0..<numberOfPlayers {
            let commanderDamage = Player.CommanderDamage()
            let counters = Player.Counters()
            let life = Player.Life(lifeTotal: startingLifeTotals)
            let settings = Player.Settings()
            
            let newPlayer = Player(
                commanderDamage: commanderDamage,
                counters: counters,
                life: life,
                name: "Player \(player + 1)",
                settings: settings,
                id: player)

            players.append(newPlayer)
        }
        
        self.players = players
    }
}
