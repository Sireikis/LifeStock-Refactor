//
//  PlayerCardsViewModel.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/19/21.
//

import Combine
import SwiftUI


extension PlayerCardsView {
    
    class ViewModel: ObservableObject {
        
        @Published var appState: AppState
        @Published var viewRouter: AppState.ViewRouter
        
        let container: DIContainer
        var cancellable: AnyCancellable?
        
        init(container: DIContainer) {
            self.container = container
            self.appState = container.appState
            self.viewRouter = container.appState.routing
            
            self.cancellable = self.appState.$gameData.sink(
                receiveValue: { [weak self] _ in
                    self?.objectWillChange.send()
                }
            )
        }
        
        // MARK: - LifeStock GameSettings Methods
        
        var numberOfPlayers: Int {
            appState.gameData.gameSettings.getNumberOfPlayers
        }
        
        // MARK: - LifeStock Player Counters Methods
        
        func playerOneCounterViewEnabled() -> Bool {
            appState.gameData.playerOneCounterViewEnabled()
        }
        
        // MARK: - LifeStock Player Settings Methods
        
        func currentColorOf(player: Int) -> Color {
            appState.gameData.currentColor(of: player)
        }
        
        // MARK: - Navigation Methods
        
        func navigateToPlayerCardMenuView() {
            viewRouter.setTransition(between: .playerCardView, and: .playerCardMenu)
            viewRouter.toggleView(.playerCardMenu)
        }
    }
}
