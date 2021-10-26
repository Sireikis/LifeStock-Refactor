//
//  View+transitionChoice.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/12/21.
//

import SwiftUI


extension View {
    // Chooses a type erased view with some transitions.
    func transitionChoice(_ transitionChoice: TransitionChoice) -> some View {
        transitionChoice.chooseTransitionFor(view: self)
    }
    
    // Chooses a transition for each view based on viewParings in ViewRouter,
    // Which are set by setTransition in ViewRouter.
    func transitionFrom(_ firstView: AppState.ViewRouter.ViewChoice, to secondView: AppState.ViewRouter.ViewChoice, from side: AppState.ViewRouter.Side = .none, alteringView: AppState.ViewRouter.ViewChoice) -> some View {
//    func transitionFrom(_ firstView: ViewRouter.ViewChoice, to secondView: ViewRouter.ViewChoice, from side: ViewRouter.Side = .none, alteringView: ViewRouter.ViewChoice) -> some View {
        switch (firstView, secondView, side, alteringView) {
        // Transition between startScreenView and choosePlayersView
        case (.startScreenView, .choosePlayersView, _, .startScreenView):
            return transitionChoice(.transitionFromLeft)
        case (.startScreenView, .choosePlayersView, _, .choosePlayersView):
            return transitionChoice(.transitionFromRight)
        // Transition between choosePlayersView and playerCardsView
        // Cannot navigate back to choosePlayersView
        case (.choosePlayersView, .playerCardView, _, .choosePlayersView):
            return transitionChoice(.transitionFromLeft)
        case (.choosePlayersView, .playerCardView, _, .playerCardView):
            return transitionChoice(.transitionFromRight)
        // Transition between playerCardsView and playerNameAndColorChangerView
        case (.playerCardView, .playerNameAndColorChangerView, .left, .playerCardView):
            return transitionChoice(.transitionFromRight)
        case (.playerCardView, .playerNameAndColorChangerView, .right, .playerCardView):
            return transitionChoice(.transitionFromLeft)
        case (.playerCardView, .playerNameAndColorChangerView, .left, .playerNameAndColorChangerView):
            return transitionChoice(.transitionFromLeft)
        case (.playerCardView, .playerNameAndColorChangerView, .right, .playerNameAndColorChangerView):
            return transitionChoice(.transitionFromRightAndFlip)
        // Transition between playerCardsView and lifeChangerView
        case (.playerCardView, .lifeChangerView, .left, .playerCardView):
            return transitionChoice(.transitionFromRight)
        case (.playerCardView, .lifeChangerView, .right, .playerCardView):
            return transitionChoice(.transitionFromLeft)
        case (.playerCardView, .lifeChangerView, .left, .lifeChangerView):
            return transitionChoice(.transitionFromLeft)
        case (.playerCardView, .lifeChangerView, .right, .lifeChangerView):
            return transitionChoice(.transitionFromRightAndFlip)
        // Transition between lifeChangerView and calculatorView
        case (.lifeChangerView, .calculatorView, .left, .lifeChangerView):
            return transitionChoice(.transitionFromTop)
        case (.lifeChangerView, .calculatorView, .right, .lifeChangerView):
            return transitionChoice(.transitionFromBottomAndFlip)
        case (.lifeChangerView, .calculatorView, .left, .calculatorView):
            return transitionChoice(.transitionFromBottom)
        case (.lifeChangerView, .calculatorView, .right, .calculatorView):
            return transitionChoice(.transitionFromTopAndFlip)
        // Transition between calculatorView and playerCardsView
        case (.calculatorView, .playerCardView, .left, .calculatorView):
            return transitionChoice(.transitionFromLeft)
        case (.calculatorView, .playerCardView, .right, .calculatorView):
            return transitionChoice(.transitionFromRightAndFlip)
        case (.calculatorView, .playerCardView, .left, .playerCardView):
            return transitionChoice(.transitionFromRight)
        case (.calculatorView, .playerCardView, .right, .playerCardView):
            return transitionChoice(.transitionFromLeft)
        // Transition between playerCardsView and playerCardMenu
        case (.playerCardView, .playerCardMenu, _, .playerCardView):
            return transitionChoice(.transitionIdentity)
        case (.playerCardView, .playerCardMenu, _, .playerCardMenu):
            return transitionChoice(.transitionFade)
        // Transition between playerCardMenu+playerCardsView and playerNamesView
        case (.playerCardMenu, .playerNamesView, _, .playerCardMenu):
            return transitionChoice(.transitionFromLeft)
        case (.playerCardMenu, .playerNamesView, _, .playerCardView):
            return transitionChoice(.transitionFromLeft)
        case (.playerCardMenu, .playerNamesView, _, .playerNamesView):
            return transitionChoice(.transitionFromRight)
        // Transition between playerNamesView and playerCardsView
        case (.playerNamesView, .playerCardView, _, .playerNamesView):
            return transitionChoice(.transitionFromRight)
        case (.playerNamesView, .playerCardView, _, .playerCardView):
            return transitionChoice(.transitionFromLeft)
        // Transition between playerCardMenu and areYouSure
        case (.playerCardMenu, .areYouSure, _, .playerCardMenu):
            return transitionChoice(.transitionIdentity)
        case (.playerCardMenu, .areYouSure, _, .areYouSure):
            return transitionChoice(.transitionFade)
        // Transition between areYouSure+playerCardMenu+playerCardsView and startScreenView
        case (.areYouSure, .startScreenView, _, .areYouSure):
            return transitionChoice(.transitionFromLeft)
        case (.areYouSure, .startScreenView, _, .playerCardMenu):
            return transitionChoice(.transitionFromLeft)
        case (.areYouSure, .startScreenView, _, .playerCardView):
            return transitionChoice(.transitionFromLeft)
        case (.areYouSure, .startScreenView, _, .startScreenView):
            return transitionChoice(.transitionFromRight)
        // Transition between playerCardMenu+playerCardsView and historyView
        case (.playerCardMenu, .historyView, _, .playerCardMenu):
            return transitionChoice(.transitionFromLeft)
        case (.playerCardMenu, .historyView, _, .playerCardView):
            return transitionChoice(.transitionFromLeft)
        case (.playerCardMenu, .historyView, _, .historyView):
            return transitionChoice(.transitionFromRight)
        // Transition between historyView and playerCardsView
        case (.historyView, .playerCardView, _, .historyView):
            return transitionChoice(.transitionFromRight)
        case (.historyView, .playerCardView, _, .playerCardView):
            return transitionChoice(.transitionFromLeft)
        // This case should never run
        default:
            return transitionChoice(.transitionFromBottom)
        }
    }
}

enum TransitionChoice {
    
    case transitionFromLeft
    case transitionFromRight
    case transitionFromRightAndFlip
    case transitionFromBottom
    case transitionFromBottomAndFlip
    case transitionFromTop
    case transitionFromTopAndFlip
    case transitionFade
    case transitionIdentity
    
    func chooseTransitionFor<V: View>(view: V) -> some View {
        switch self {
        case .transitionFromLeft:
            return AnyView(view.transitionFromLeft())
        case .transitionFromRight:
            return AnyView(view.transitionFromRight())
        case .transitionFromRightAndFlip:
            return AnyView(view.transitionFromRightAndFlip())
        case .transitionFromBottom:
            return AnyView(view.transitionFromBottom())
        case .transitionFromBottomAndFlip:
            return AnyView(view.transitionFromBottomAndFlip())
        case .transitionFromTop:
            return AnyView(view.transitionFromTop())
        case .transitionFromTopAndFlip:
            return AnyView(view.transitionFromTopAndFlip())
        case .transitionFade:
            return AnyView(view.transitionFade())
        case .transitionIdentity:
            return AnyView(view.transitionIdentity())
        }
    }
}
