//
//  LifeDisplay.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/19/21.
//

import SwiftUI


extension PlayerCard {
    
    struct LifeDisplay: View {
        
        @ObservedObject var viewModel: ViewModel
        
        var player: Int
        var size: CGSize
        
        var body: some View {
            GeometryReader { geometry in
                body(for: geometry.size, playerCardSize: size)
            }
        }
        
        func body(for size: CGSize, playerCardSize: CGSize) -> some View {
            ZStack {
                Button(action: {
                    viewModel.changePlayerIDSelected(to: player)
                    viewModel.setTransitionDirection()
                    viewModel.setCalculatorLifeDisplay()
                    
                    withAnimation {
                        viewModel.navigateToLifeChangerView()
                    }
                }) {
                    ZStack {
                        Text(viewModel.lifeTotal(for: player))
                            .font(Font.getFont(size: size, scalingFactor: 0.75))
                            .foregroundColor(Color.white)
                            .lineLimit(1)
                            .frame(width: playerCardSize.height)
                            .offset(y: viewModel.numberOfPlayers == 1 ? playerCardSize.width / 22 : 0)
                            .animation(.none, value: 0)
                        
                    }
                    .frame(width: size.width, height: size.height)
                    .rotationEffect(.degrees(90))
                }
                .frame(width: size.width, height: size.height)
            }
        }
    }
}
