
//
//  PlayerCardViewModel.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/19/21.
//

import Combine
import SwiftUI

/*
 https://stackoverflow.com/questions/58406287/how-to-tell-swiftui-views-to-bind-to-nested-observableobjects
 Describes use of Combine to fix issues with nested ObservableObjects
 */
extension PlayerCard {
    
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
        
        func changePlayerIDSelected(to player: Int) {
            appState.gameData.changePlayerIDSelected(to: player)
        }
        
        // MARK: - LifeStock PlayersSettings Methods
        
        var commanderDamageEnabled: Bool {
            appState.gameData.commanderDamageEnabled
        }
        
        var namesEnabled: Bool {
            appState.gameData.namesEnabled
        }
        
        // MARK: - LifeStock GameSettings Methods
        
        var numberOfPlayers: Int {
            appState.gameData.numberOfPlayers
        }
        
        // MARK: - LifeStock Player Methods
        
        func playerName(for player: Int) -> String {
            appState.gameData.playerName(for: player)
        }
        
        // MARK: - LifeStock Player CommanderDamage Methods
        
        func decrementCommanderDamageOf(player hurtPlayer: Int, from attackingPlayer: Int) {
            appState.gameData.decrementCommanderDamageOf(player: hurtPlayer, from: attackingPlayer)
        }
        
        func incrementCommanderDamageOf(player hurtPlayer: Int, from attackingPlayer: Int) {
            appState.gameData.incrementCommanderDamageOf(player: hurtPlayer, from: attackingPlayer)
        }
        
        func showCommanderDamage(of player: Int, from attackingPlayer: Int) -> String {
            String(appState.gameData.getCommanderDamage(of: player, from: attackingPlayer))
        }
        
        func commanderDamageEnabled(for player: Int) -> Bool {
            appState.gameData.commanderDamageEnabled(for: player)
        }
        
        // MARK: - LifeStock Player Counters Methods
        
        func toggleCounterOnPlayerCard(for player: Int, counter: CounterType) {
            appState.gameData.toggleCounterOnPlayerCard(for: player, counter: counter)
        }
        
        func decrementCounterOf(player: Int, counter: CounterType) {
            appState.gameData.decrementCounterOf(player: player, counter: counter)
        }
        
        func incrementCounterOf(player: Int, counter: CounterType) {
            appState.gameData.incrementCounterOf(player: player, counter: counter)
        }
        
        func isCounterDisplayedOnPlayerCardOf(player: Int, counter: CounterType) -> Bool {
            appState.gameData.isCounterDisplayedOnPlayerCardOf(player: player, counter: counter)
        }
        
        func counterQuantityFor(player: Int, counter: CounterType) -> String {
            String(appState.gameData.counterQuantityFor(player: player, counter: counter))
        }
        
        func counterViewEnabled(for player: Int) -> Bool {
            appState.gameData.counterViewEnabled(for: player)
        }
        
        func toggleCountersViewOf(player: Int) {
            appState.gameData.toggleCountersViewOf(player: player)
        }
        
        func countersModifiable(player: Int) -> Bool {
            appState.gameData.countersModifiable(player: player)
        }
        
        func toggleCountersModifiable(for player: Int) {
            appState.gameData.toggleCountersModifiable(for: player)
        }
        
        // MARK: - LifeStock Player Life Methods
        
        func lifeTotal(for player: Int) -> String {
            String(appState.gameData.lifeTotal(for: player))
        }
        
        func increaseLifeTotalOf(player: Int) {
            appState.gameData.increaseLifeTotalOf(player: player)
        }
        
        func decreaseLifeTotalOf(player: Int) {
            appState.gameData.decreaseLifeTotalOf(player: player)
        }
        
        // MARK: - LifeStock Player Settings Methods
        
        func changeMonarchTo(player: Int) {
            appState.gameData.changeMonarchTo(player: player)
        }
        
        func isMonarch(player: Int) -> Bool {
            appState.gameData.isMonarch(player: player)
        }
        
        func isNameDisplayed(for player: Int) -> Bool {
            appState.gameData.isNameDisplayed(for: player)
        }
        
        func currentColor(of player: Int) -> Color {
            appState.gameData.currentColor(of: player)
        }
        
        // MARK: - LifeStock Calculator Methods
        
        func setCalculatorLifeDisplay() {
            let playerIDSelected = appState.gameData.playerIDSelected
            let playerLifeTotal = appState.gameData.lifeTotal(for: playerIDSelected)
            appState.gameData.calculator.setCalculatorLifeDisplay(to: playerLifeTotal)
        }
        
        // MARK: - Navigation Methods && Transition Logic
        
        func navigateToLifeChangerView() {
            viewRouter.setTransition(
                between: .playerCardView,
                and: .lifeChangerView,
                forSide: viewRouter.side)
            viewRouter.toggleView(.lifeChangerView)
            viewRouter.toggleView(.playerCardView)
        }
        
        func navigateToPlayerOptionsAndColorsView() {
            viewRouter.setTransition(
                between: .playerCardView,
                and: .playerNameAndColorChangerView,
                forSide: viewRouter.side)
            viewRouter.toggleView(.playerNameAndColorChangerView)
            viewRouter.toggleView(.playerCardView)
        }
        
        func setTransitionDirection() {
            let decidedBy: (AppState.ViewRouter.Side) -> () = viewRouter.changeSideTo(_:)
            
            if appState.gameData.playerIDSelected == 1 {
                decidedBy(.left)
            } else if appState.gameData.gameSettings.getNumberOfPlayers == 4 {
                if appState.gameData.playerIDSelected == 2 {
                    decidedBy(.left)
                } else {
                    decidedBy(.right)
                }
            } else {
                decidedBy(.right)
            }
        }
    }
}
