//
//  SettingsScreenViewModel.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/5/21.
//

import Foundation
import SwiftUI
import StoreKit


extension SettingsScreenView {
    
    class ViewModel: ObservableObject {
        
        @Published var appState: AppState
        private var gameState: GameStateService
        private var storeManager: StoreManagerService
        
        let container: DIContainer
        
        init(container: DIContainer) {
            self.container = container
            self.appState = container.appState
            self.gameState = container.services.gameStateService
            self.storeManager = container.services.storeManagerService
        }
        
        // MARK: - GameState UserSettings Methods
        
        var commanderDamageEnabled: Bool {
            gameState.commanderDamageEnabled
        }
        
        var playerNamesEnabled: Bool {
            gameState.playerNamesEnabled
        }
        
        // MARK: - PlayersSettings Methods
        
        func set(_ setting: PlayersSettings.PlayerSetting, to value: Bool) {
            appState.gameData.playersSettings.set(setting, to: value)
        }
        
        // MARK: - StoreManagerService Methods
        
        var myProducts: [SKProduct] {
            storeManager.myProducts
        }
        
        func canMakePayments() -> Bool {
            storeManager.canMakePayments()
        }

        func purchaseProduct(product: SKProduct) {
            storeManager.purchaseProduct(product: product)
        }
    }
}
