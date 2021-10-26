//
//  AppEnvironment.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/12/21.
//

import Foundation


struct AppEnvironment {
    
    let container: DIContainer
}

extension AppEnvironment {
    
    static func bootstrap() -> AppEnvironment {
        let appState = AppState()
        
        let services = configureServices()
        let diContainer = DIContainer(appState: appState, services: services)
        
        let persistentData = diContainer.services.gameStateService
        
        appState.gameData.playersSettings.commanderDamageEnabled = persistentData.commanderDamageEnabled
        appState.gameData.playersSettings.namesEnabled = persistentData.playerNamesEnabled
        
        return AppEnvironment(container: diContainer)
    }
    
    private static func configureServices() -> DIContainer.Services {
        let gameStateService = RealGameStateService(gameState: PersistentData())
        let storeManagerService = RealStoreManagerService()
        return .init(gameStateService: gameStateService, storeManagerService: storeManagerService)
    }
}
