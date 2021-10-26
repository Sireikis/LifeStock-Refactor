//
//  ChoosePlayerViewModel.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/4/21.
//

import Combine
import SwiftUI


extension ChoosePlayerView {
    
    class ViewModel: ObservableObject {
        
        @Published var appState: AppState
        private var gameState: GameStateService
        @Published var viewRouter: AppState.ViewRouter
        
        let container: DIContainer
        var cancellable: AnyCancellable?
        
        init(container: DIContainer) {
            self.container = container
            self.appState = container.appState
            self.gameState = container.services.gameStateService
            self.viewRouter = container.appState.routing
            
            self.cancellable = self.appState.$gameData.sink(
                receiveValue: { [weak self] _ in
                    self?.objectWillChange.send()
                }
            )
        }
        
        // MARK: - Game Setup
        
        private static func setGame(
            numberOfPlayers: Int,
            startingLifeTotals: Int,
            playersSettings: PlayersSettings
        ) -> LifeStock {
            let lifeStock = LifeStock(
                numberOfPlayers: numberOfPlayers,
                startingLifeTotals: startingLifeTotals,
                playersSettings: playersSettings)

            return lifeStock
        }
        
        func setGame(numberOfPlayers: Int, startingLifeTotals: Int) {
            appState.gameData = ViewModel.setGame(
                numberOfPlayers: numberOfPlayers,
                startingLifeTotals: startingLifeTotals,
                playersSettings: appState.gameData.playersSettings)
        }
        
        func displayCustomLife() -> Int {
            if gameState.customLifeEnabled {
                return Int(gameState.customLife) ?? 50
            } else {
                return 50
            }
        }
        
        func selectedPlayerLife() -> Int {
            if gameState.customLifeEnabled {
                return Int(gameState.customLife)!
            } else {
                return gameState.playerLife
            }
        }
        
        var customLife: Int {
            if let customLife = Int(gameState.customLife) {
                return customLife
            } else {
                fatalError("Failed to convert customLife to an Integer.")
            }
        }
        
        var customLifeEnabled: Bool {
            gameState.customLifeEnabled
        }
        
        var playerLife: Int {
            gameState.playerLife
        }
        
        var startingPlayerCount:Int {
            gameState.startingPlayerCount
        }
        
        // MARK: - LifeStock Methods
        
        func changeNumberOfPlayers(to players: Int) {
            appState.gameData.gameSettings.changeNumberOfPlayers(to: players)
        }
        
        func changeStartingLifeTotals(to lifetotal: Int) {
            appState.gameData.gameSettings.changeStartingLifeTotals(to: lifetotal)
        }
        
        func setSelectedLifeButton() -> Int {
            let lifeTotal = startingLifeTotals
            switch lifeTotal {
            case 20: return 1
            case 30: return 2
            case 40: return 3
            default: return 0
            }
        }
        
        // MARK: - LifeStock PlayersSettings Methods
        
        var commanderDamageEnabled: Bool {
            appState.gameData.commanderDamageEnabled
        }
        
        var playerNamesEnabled: Bool {
            appState.gameData.namesEnabled
        }
        
        func togglePlayersSetting(_ setting: PlayersSettings.PlayerSetting) {
            appState.gameData.playersSettings.toggle(setting: setting)
        }
        
        func set(_ setting: PlayersSettings.PlayerSetting, to value: Bool) {
            appState.gameData.playersSettings.set(setting, to: value)
        }
        
        // MARK: - LifeStock GameSettings Methods
        
        var numberOfPlayers: Int {
            appState.gameData.gameSettings.getNumberOfPlayers
        }
        
        var startingLifeTotals: Int {
            appState.gameData.gameSettings.getStartingLifeTotals
        }
        
        
        // MARK: - Navigation Methods
        
        func navigateToStartScreenView() {
            viewRouter.toggleView(.choosePlayersView)
            viewRouter.toggleView(.startScreenView)
        }
        
        func navigateToPlayerCardsView() {
            viewRouter.setTransition(between: .choosePlayersView, and: .playerCardView)
            viewRouter.toggleView(.playerCardView)
            viewRouter.toggleView(.choosePlayersView)
        }
    }
}
