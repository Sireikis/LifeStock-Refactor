//
//  PlayerCardsView.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/19/21.
//

import SwiftUI


struct PlayerCardsView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            PlayerGenerator(viewModel: viewModel)
            
            if viewModel.numberOfPlayers == 1 && !viewModel.playerOneCounterViewEnabled() {
                    MenuIcon(viewModel: viewModel)
                        .position(
                            x: ScreenSize.width - distanceFromEdge(),
                            y: ScreenSize.height - distanceFromEdge())
            } else {
                MenuIcon(viewModel: viewModel)
            }
        }
    }
    
    private func distanceFromEdge() -> CGFloat {
        return min(ScreenSize.width / 10, ScreenSize.height / 10)
    }
}

extension PlayerCardsView {
    
    struct PlayerGenerator: View {
        
        @ObservedObject var viewModel: ViewModel
        
        var body: some View {
            returnNumberOfPlayers()
        }
        
        func returnNumberOfPlayers() -> some View {
            let numberOfPlayers = viewModel.numberOfPlayers
            return Group {
                if numberOfPlayers <= 1 {
                    createPlayers(playerNumber: 1, numberOfPlayers: 1)
                } else if numberOfPlayers == 2 {
                    HStack {
                        createPlayers(playerNumber: 1, numberOfPlayers: 1)
                        createPlayers(playerNumber: 2, numberOfPlayers: 2).rotationEffect(.degrees(-180))
                    }
                } else if numberOfPlayers == 3 {
                    HStack {
                        createPlayers(playerNumber: 1, numberOfPlayers: 1)
                        VStack {
                            createPlayers(playerNumber: 2, numberOfPlayers: 3).rotationEffect(.degrees(-180))
                        }
                    }
                } else if numberOfPlayers >= 4 {
                    HStack {
                        VStack {
                            createPlayers(playerNumber: 1, numberOfPlayers: 2)
                        }
                        VStack {
                            createPlayers(playerNumber: 3, numberOfPlayers: 4).rotationEffect(.degrees(-180))
                        }
                    }
                }
            }
        }
        
        func createPlayers(playerNumber: Int, numberOfPlayers: Int) -> some View {
            ForEach((playerNumber...numberOfPlayers), id:\.self) { player in
                ZStack {
                    Rectangle()
                    PlayerCard(
                        viewModel: PlayerCard.ViewModel(container: viewModel.container),
                        player: player)
                    
                } // Top level color for all PlayerCard(s)
                .foregroundColor(viewModel.currentColorOf(player: player))
            }
        }
    }

}

extension PlayerCardsView {
    
    struct MenuIcon: View {
        
        @ObservedObject var viewModel: ViewModel
        
        var body: some View {
            Circle()
                .foregroundColor(LifeStockColor.darkBackground)
                .overlay(
                    Button(action: {
                        withAnimation {
                            viewModel.navigateToPlayerCardMenuView()
                        }
                    }) {
                        GeometryReader { gear in
                            ZStack {
                                Circle()
                                    .fill(.black)
                                Image(systemName: Constants.menuIcon)
                                    .font(Font.getFont(size: gear.size, scalingFactor: Constants.imageScalingFactor))
                                    .foregroundColor(.white)
                            }
                        }
                    }.padding(5)
                )
                .frame(width: ScreenSize.width / 8, height: ScreenSize.height / 8)
        }
    }
}

extension PlayerCardsView.MenuIcon {
    
    struct Constants {
        
        static let imageScalingFactor: CGFloat = 0.60
        static let menuIcon: String = "gearshape"
    }
}
