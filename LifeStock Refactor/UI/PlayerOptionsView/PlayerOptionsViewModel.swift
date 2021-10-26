//
//  PlayerOptionsViewModel.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/22/21.
//

import Combine
import SwiftUI


extension PlayerOptionsView {
    
    class ViewModel: ObservableObject {
        
        @Published var appState: AppState
        var viewRouter: AppState.ViewRouter
        
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
        
        // MARK: - LifeStock Methods
        
        var playerIDSelected: Int {
            appState.gameData.playerIDSelected
        }
        
        // MARK: - LifeStock Player CommanderDamage Methods
        
        func commanderDamageDisplayedFor(player: Int) -> Bool {
            appState.gameData.commanderDamageEnabled(for: player)
        }
        
        func toggleCommanderDamageDisplayFor(player: Int) {
            appState.gameData.toggleCommanderDamageDisplayfor(player: player)
        }
        
        // MARK: - LifeStock Player Settings Methods
        
        func togglePlayerNameFor(player: Int) {
            appState.gameData.togglePlayerNameOf(player: player)
        }
        
        func isPlayerNameDisplayedFor(player: Int) -> Bool {
            appState.gameData.isNameDisplayed(for: player)
        }
        
        func currentColor(of player: Int) -> Color {
            appState.gameData.currentColor(of: player)
        }
        
        func changeColor(of player: Int, to color: Color) {
            appState.gameData.changeColor(of: player, to: color)
        }
        
        // MARK: - Navigation Methods
        
        func navigateToPlayerCardsView() {
            viewRouter.toggleView(.playerCardView)
            viewRouter.toggleView(.playerNameAndColorChangerView)
        }
    }
}
