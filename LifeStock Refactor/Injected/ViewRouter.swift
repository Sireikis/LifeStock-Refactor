//
//  ViewRouter.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/12/21.
//

import SwiftUI

extension AppState {
    
    class ViewRouter: ObservableObject {
        
        @Published var currentViews = CurrentView()
        
        var viewPairOne: ViewChoice = .startScreenView
        var viewPairTwo: ViewChoice = .startScreenView
        var side: Side = .none
        
        // Only called when changing the pair of views that will transition
        func setTransition(between viewPairOne: ViewChoice, and viewPairTwo: ViewChoice, forSide side: Side = .none) {
            self.viewPairOne = viewPairOne
            self.viewPairTwo = viewPairTwo
            self.side = side
        }
        
        // For designating transition directions for LifeChanger, Calculator, and PlayerOptions Screens.
        func changeSideTo(_ side: Side) {
            self.side = side
        }
        
        func toggleView(_ view: ViewChoice) {
            switch view {
            case .startScreenView:
                currentViews.startScreenView.toggle()
            case .choosePlayersView:
                currentViews.choosePlayersView.toggle()
            case .playerCardView:
                currentViews.playerCardsView.toggle()
            case .playerNameAndColorChangerView:
                currentViews.playerNameAndColorChangerView.toggle()
            case .playerCardMenu:
                currentViews.playerCardMenu.toggle()
            case .historyView:
                currentViews.historyView.toggle()
            case .areYouSure:
                currentViews.areYouSure.toggle()
            case .playerNamesView:
                currentViews.playerNamesView.toggle()
            case .calculatorView:
                currentViews.calculatorView.toggle()
            case .lifeChangerView:
                currentViews.lifeChangerView.toggle()
            }
        }
        
        func resetViewRouter() {
            currentViews = CurrentView()
            viewPairOne = .startScreenView
            viewPairTwo = .startScreenView
            side = .none
        }
    }
}

 extension AppState.ViewRouter {
     
     struct CurrentView {
         
         var startScreenView: Bool = true
         var choosePlayersView: Bool = false
         var playerCardsView: Bool = false
         var playerNameAndColorChangerView: Bool = false
         var playerCardMenu: Bool = false
         var historyView: Bool = false
         var areYouSure: Bool = false
         var playerNamesView: Bool = false
         var lifeChangerView: Bool = false
         var calculatorView: Bool = false
     }
 }

 extension AppState.ViewRouter {
     
     enum ViewChoice {
         
         case startScreenView
         case choosePlayersView
         case playerCardView
         case playerNameAndColorChangerView
         case playerCardMenu
         case historyView
         case areYouSure
         case playerNamesView
         case lifeChangerView
         case calculatorView
     }
 }

 extension AppState.ViewRouter {
     
     enum Side {
         
         case left
         case right
         case none
     }
 }
