//
//  ParentView.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/12/21.
//

import SwiftUI
import StoreKit


struct ParentView: View {
    
    @ObservedObject var viewRouter: AppState.ViewRouter
    
    let container: DIContainer
    let storeManager: RealStoreManagerService
    
    var body: some View {
        ZStack {
            content()
                .onAppear(perform: {
                    SKPaymentQueue.default().add(storeManager)
                    storeManager.getProducts()
                })
        }
    }
    
    func content() -> some View {
        ZStack {
            Group {
                if viewRouter.currentViews.startScreenView {
                    StartScreenView(viewModel: StartScreenView.ViewModel(container: container))
                        
                }
            }
            .transitionFrom(
                viewRouter.viewPairOne,
                to: viewRouter.viewPairTwo,
                alteringView: .startScreenView)
            
            Group {
                if viewRouter.currentViews.choosePlayersView {
                    ChoosePlayerView(viewModel: ChoosePlayerView.ViewModel(container: container))
                }
            }
            .transitionFrom(
                viewRouter.viewPairOne,
                to: viewRouter.viewPairTwo,
                alteringView: .choosePlayersView)
            
            Group {
                if viewRouter.currentViews.playerCardsView {
                    PlayerCardsView(viewModel: PlayerCardsView.ViewModel(container: container))
                }
            }
            .transitionFrom(
                viewRouter.viewPairOne,
                to: viewRouter.viewPairTwo,
                from: viewRouter.side,
                alteringView: .playerCardView)
            
            Group {
                if viewRouter.currentViews.lifeChangerView {
                    LifeChangerView(viewModel: LifeChangerView.ViewModel(container: container))
                }
            }
            .transitionFrom(
                viewRouter.viewPairOne,
                to: viewRouter.viewPairTwo,
                from: viewRouter.side,
                alteringView: .lifeChangerView)
            
            Group {
                if viewRouter.currentViews.calculatorView {
                    CalculatorView(viewModel: LifeChangerView.ViewModel(container: container))
                }
            }
            .transitionFrom(
                viewRouter.viewPairOne,
                to: viewRouter.viewPairTwo,
                from: viewRouter.side,
                alteringView: .calculatorView)
            
            Group {
                if viewRouter.currentViews.playerCardMenu {
                    PlayerCardMenuView(viewModel: PlayerCardMenuView.ViewModel(container: container))
                }
            }
            .transitionFrom(
                viewRouter.viewPairOne,
                to: viewRouter.viewPairTwo,
                from: viewRouter.side,
                alteringView: .playerCardMenu)
            .blur(radius: viewRouter.currentViews.areYouSure ? 10 : 0)
            
            Group {
                if viewRouter.currentViews.historyView {
                    PlayerCardMenuView.HistoryView(
                        viewModel: PlayerCardMenuView.ViewModel(container: container))
                }
            }
            .transitionFrom(
                viewRouter.viewPairOne,
                to: viewRouter.viewPairTwo,
                from: viewRouter.side,
                alteringView: .historyView)
            
            Group {
                if viewRouter.currentViews.areYouSure {
                    PlayerCardMenuView.AreYouSureView(
                        viewModel: PlayerCardMenuView.ViewModel(container: container))
                }
            }
            .transitionFrom(
                viewRouter.viewPairOne,
                to: viewRouter.viewPairTwo,
                from: viewRouter.side,
                alteringView: .areYouSure)
            
            Group {
                if viewRouter.currentViews.playerNamesView {
                    PlayerCardMenuView.NamesView(
                        viewModel: PlayerCardMenuView.ViewModel(container: container))
                }
            }
            .transitionFrom(
                viewRouter.viewPairOne,
                to: viewRouter.viewPairTwo,
                from: viewRouter.side,
                alteringView: .playerNamesView)
            
            Group {
                if viewRouter.currentViews.playerNameAndColorChangerView {
                    PlayerOptionsView(viewModel: PlayerOptionsView.ViewModel(container: container))
                }
            }
            .transitionFrom(
                viewRouter.viewPairOne,
                to: viewRouter.viewPairTwo,
                from: viewRouter.side,
                alteringView: .playerNameAndColorChangerView)
        }
        .animation(.easeInOut, value: 0)
    }
}
