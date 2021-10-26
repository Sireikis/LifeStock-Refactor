//
//  PlayerCardMenuViewModel.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/22/21.
//

import Combine
import SwiftUI


extension PlayerCardMenuView {
    
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
        
        func resetGame() {
            let persitentData = container.services.gameStateService
            let startingLifeTotals = appState.gameData.startingLifeTotals
            
            let commanderDamageEnabled = persitentData.commanderDamageEnabled
            let namesEnabled = persitentData.playerNamesEnabled
            let playersSettings = PlayersSettings(
                commanderDamageEnabled: commanderDamageEnabled,
                namesEnabled: namesEnabled)
            
            appState.gameData = LifeStock(
                numberOfPlayers: numberOfPlayers,
                startingLifeTotals: startingLifeTotals,
                playersSettings: playersSettings)
            
            for playerIndex in 0..<numberOfPlayers {
                appState.gameData.players[playerIndex].counters.commanderTax.isPresented = persitentData.commanderTax
                appState.gameData.players[playerIndex].counters.storm.isPresented = persitentData.storm
                appState.gameData.players[playerIndex].counters.experience.isPresented = persitentData.experience
                appState.gameData.players[playerIndex].counters.energy.isPresented = persitentData.energy
            }
        }
        
        // MARK: - GameState UserSettings Methods
        
        
        
        // MARK: - LifeStock Player Methods
        
        func playerName(for player: Int) -> String {
            appState.gameData.playerName(for: player)
        }
        
        func changePlayerName(of player: Int, to name: String) {
            appState.gameData.changePlayerName(of: player, to: name)
        }
        
        // MARK: - LifeStock Player Life Methods
        
        func lifeTotalHistoryArrayCount(of player: Int) -> Int {
            appState.gameData.lifeTotalHistoryArrayCount(of: player)
        }
        
        func lifeTotalHistory(of player: Int, at index: Int) -> Int? {
            appState.gameData.lifeTotalHistory(of: player, at: index)
        }
        
        // MARK: - LifeStock Player Settings Methods
        
        func toggleCommanderDamage() {
            appState.gameData.playersSettings.toggle(setting: .commanderDamageEnabled)
        }
        
        func commanderDamageEnabled() -> Bool {
            appState.gameData.commanderDamageEnabled
        }
        
        func togglePlayerNames() {
            appState.gameData.playersSettings.toggle(setting: .namesEnabled)
        }
        
        func playerNamesEnabled() -> Bool {
            appState.gameData.namesEnabled
        }
        
        // MARK: - LifeStock PlayersSettings Methods
        
        var playerSettings: PlayersSettings {
            appState.gameData.playersSettings
        }
        
        // MARK: - LifeStock GameSettings Methods
        
        var numberOfPlayers: Int {
            appState.gameData.numberOfPlayers
        }
        var startingLifeTotals: String {
            String(appState.gameData.startingLifeTotals)
        }
        
        // MARK: - Navigation Methods
        
        func navigateToPlayerCardsViewFromMenu() {
            viewRouter.toggleView(.playerCardMenu)
        }
        
        func navigateToHistoryView() {
            viewRouter.setTransition(between: .playerCardMenu, and: .historyView)
            viewRouter.toggleView(.historyView)
            viewRouter.toggleView(.playerCardMenu)
            viewRouter.toggleView(.playerCardView)
        }
        
        func navigateToNamesView() {
            viewRouter.setTransition(between: .playerCardMenu, and: .playerNamesView)
            viewRouter.toggleView(.playerNamesView)
            viewRouter.toggleView(.playerCardMenu)
            viewRouter.toggleView(.playerCardView)
        }
        
        func navigateToAreYouSureView() {
            viewRouter.setTransition(between: .playerCardMenu, and: .areYouSure)
            viewRouter.toggleView(.areYouSure)
        }
        
        func navigateToStartScreenView() {
            viewRouter.setTransition(between: .areYouSure, and: .startScreenView)
            viewRouter.toggleView(.playerCardView)
            viewRouter.toggleView(.playerCardMenu)
            viewRouter.toggleView(.areYouSure)
            viewRouter.toggleView(.startScreenView)
        }
        
        func navigateToPlayerCardMenuFromHistoryView() {
            viewRouter.toggleView(.playerCardMenu)
            viewRouter.toggleView(.playerCardView)
            viewRouter.toggleView(.historyView)
        }
        
        func navigateToPlayerCardsViewFromHistoryView() {
            viewRouter.setTransition(between: .historyView, and: .playerCardView)
            viewRouter.toggleView(.playerCardView)
            viewRouter.toggleView(.historyView)
        }
        
        func navigateToPlayerCardMenuFromNamesView() {
            viewRouter.toggleView(.playerCardMenu)
            viewRouter.toggleView(.playerCardView)
            viewRouter.toggleView(.playerNamesView)
        }
        
        func navigateToPlayerCardsFromNamesView() {
            viewRouter.setTransition(between: .playerNamesView, and: .playerCardView)
            viewRouter.toggleView(.playerCardView)
            viewRouter.toggleView(.playerNamesView)
        }
        
        func toggleView(_ view : AppState.ViewRouter.ViewChoice) {
            viewRouter.toggleView(view)
        }
        
        func resetViewRouter() {
            viewRouter.resetViewRouter()
        }
    }
}
