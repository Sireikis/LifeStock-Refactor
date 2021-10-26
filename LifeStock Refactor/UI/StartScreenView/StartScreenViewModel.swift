//
//  StartScreenViewModel.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/4/21.
//

import SwiftUI


extension StartScreenView {
    
    class ViewModel: ObservableObject {
        
        @Published var appState: AppState
        private var gameState: GameStateService
        @Published var viewRouter: AppState.ViewRouter
        
        let container: DIContainer
        
        init(container: DIContainer) {
            self.container = container
            self.appState = container.appState
            self.gameState = container.services.gameStateService
            self.viewRouter = container.appState.routing
        }
        
        // MARK: - Game Setup
        
        var performedFirstTimeStartUp: Bool {
            gameState.performedFirstTimeStartUp
        }
        
        // Only run the first time the app is opened
        func performFirstTimeStartUp() {
            let defaults = UserDefaults()
            // UserSettings
            defaults.set(true, forKey: "performedFirstTimeStartUp")
            
            defaults.set(true, forKey: "commanderDamageEnabled")
            defaults.set(true, forKey: "playerNamesEnabled")
            
            defaults.set("50", forKey: "customLife")
            defaults.set(false, forKey: "customLifeEnabled")
            defaults.set(40, forKey: "playerLife")
            defaults.set(4, forKey: "startingPlayersCount")
            
            defaults.set(true, forKey: "screenStaysOn")
            // DefaultCounters
            defaults.set(false, forKey: "commanderTax")
            defaults.set(false, forKey: "energy")
            defaults.set(false, forKey: "experience")
            defaults.set(false, forKey: "storm")
            
            updateCommanderDamageEnabled()
            updatePlayerNamesEnabled()
        }
        
        private func updateCommanderDamageEnabled() {
            appState.gameData.playersSettings.set(.commanderDamageEnabled, to: gameState.commanderDamageEnabled)
        }
        
        private func updatePlayerNamesEnabled() {
            appState.gameData.playersSettings.set(.namesEnabled, to: gameState.playerNamesEnabled)
        }
        
        // MARK: - Navigation Methods
        
        func navigateToChoosePlayersView() {
            viewRouter.setTransition(between: .startScreenView, and: .choosePlayersView)
            viewRouter.toggleView(.choosePlayersView)
            viewRouter.toggleView(.startScreenView)
        }
    }
}
