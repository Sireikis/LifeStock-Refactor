//
//  PlayerName.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/19/21.
//

import SwiftUI


extension PlayerCard {
    
    struct PlayerName: View {
        
        var viewModel: ViewModel
        
        var player: Int
        
        var body: some View {
            GeometryReader { geometry in
                body(for: geometry.size)
            }
        }
        
        func body(for size: CGSize) -> some View {
            Button(action: {
                viewModel.changePlayerIDSelected(to: player)
                viewModel.setTransitionDirection()
                withAnimation {
                    viewModel.navigateToPlayerOptionsAndColorsView()
                }
            }) {
                ZStack {
                    Rectangle()
                        .frame(width: size.height, height: size.width)
                    if viewModel.namesEnabled && viewModel.isNameDisplayed(for: player) {
                        Text(viewModel.playerName(for: player))
                            .font(Font.getFont(size: size, scalingFactor: 0.80))
                            .foregroundColor(.white)
                            .frame(width: size.height, height: size.width)
                    }
                }
                .frame(width: size.width, height: size.height)
                .rotationEffect(.degrees(90))
                //.padding(.vertical)
            }
            //.frame(width: size.width, height: size.height)
        }
    }
}
