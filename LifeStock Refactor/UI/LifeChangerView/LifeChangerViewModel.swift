//
//  LifeChangerViewModel.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/20/21.
//

import Combine
import SwiftUI


extension LifeChangerView {
    
    class ViewModel: ObservableObject {
        
        @Published var appState: AppState
        @Published var viewRouter: AppState.ViewRouter
        
        let container: DIContainer
        var cancellable: AnyCancellable?
        
        init(container: DIContainer) {
            self.container = container
            self.viewRouter = container.appState.routing
            self.appState = container.appState
            
            self.cancellable = self.appState.$gameData.sink(
                receiveValue: { [weak self] _ in
                    self?.objectWillChange.send()
                }
            )
        }
        
        // MARK: - LifeStock Player Life Methods
        
        func lifeTotalForSelectedPlayer() -> String {
            let selectedPlayer = appState.gameData.playerIDSelected
            return String(appState.gameData.players[selectedPlayer - 1].life.lifeTotal)
        }
        
        func changeLifeTotalOfSelectedPlayer(to lifeTotal: Int?) {
            let selectedPlayer = appState.gameData.playerIDSelected

            // Handle invalid input
            guard let lifeTotal = lifeTotal else {
                appState.gameData.players[selectedPlayer - 1].life.lifeTotal = 0
                return
            }

            if lifeTotal != appState.gameData.players[selectedPlayer - 1].life.lifeTotal {
                appState.gameData.players[selectedPlayer - 1].life.lifeTotal = lifeTotal
                for player in appState.gameData.players {
                    if player.id + 1 != selectedPlayer {
                        appState.gameData.players[player.id].life.lifeTotalHistory.append(nil)
                    }
                }
            }
        }
        
        // MARK: - LifeStock Calculator Methods
        
        var displayField: String {
            appState.gameData.calculator.displayField
        }
        
        func receiveInput(from button: CalculatorButton) {
            appState.gameData.calculator.receiveInput(calculatorButton: button)
        }
        
        func resetCalculatorVariables() {
            appState.gameData.calculator.resetCalculatorVariables()
        }
        
        func updatePlayerLife() {
            changeLifeTotalOfSelectedPlayer(to: Int(displayField))
        }
        
        // MARK: - Navigation Methods
        
        func navigateToPlayerCardsView() {
            viewRouter.setTransition(
                between: .playerCardView,
                and: .lifeChangerView,
                forSide: viewRouter.side)
            viewRouter.toggleView(.playerCardView)
            viewRouter.toggleView(.lifeChangerView)
        }
        
        func navigateToCalculatorView() {
            viewRouter.setTransition(
                between: .lifeChangerView,
                and: .calculatorView,
                forSide: viewRouter.side)
            viewRouter.toggleView(.lifeChangerView)
            viewRouter.toggleView(.calculatorView)
        }
        
        func navigateToLifeChangerView() {
            viewRouter.toggleView(.lifeChangerView)
            viewRouter.toggleView(.calculatorView)
        }
        
        func navigateToPlayerCardsViewFromCalc() {
            viewRouter.setTransition(
                between: .calculatorView,
                and: .playerCardView,
                forSide: viewRouter.side)
            viewRouter.toggleView(.calculatorView)
            viewRouter.toggleView(.playerCardView)
        }
    }
}
