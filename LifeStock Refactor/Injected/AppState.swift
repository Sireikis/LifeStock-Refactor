//
//  AppState.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/12/21.
//

import Foundation


class AppState: ObservableObject {
    
    @Published var gameData = LifeStock(numberOfPlayers: 4, startingLifeTotals: 40)
    @Published var routing = ViewRouter()
}

#if DEBUG
extension AppState {
    static var preview: AppState {
        let state = AppState()
        return state
    }
}
#endif
