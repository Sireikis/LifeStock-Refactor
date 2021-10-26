//
//  ServicesContainer.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/12/21.
//

import Foundation


extension DIContainer {
    
    struct Services {
        
        let gameStateService: GameStateService
        let storeManagerService: StoreManagerService
        
        init(gameStateService: GameStateService, storeManagerService: StoreManagerService) {
            self.gameStateService = gameStateService
            self.storeManagerService = storeManagerService
        }
        
        static var stub: Self {
            .init(
                gameStateService: StubGameStateService(),
                storeManagerService: StubStoreManagerService())
        }
    }
}
