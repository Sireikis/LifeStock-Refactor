//
//  PlayerCard.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/19/21.
//

import SwiftUI


struct PlayerCard: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var player: Int
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            HStack(spacing: 0) {
                PlayerName(viewModel: viewModel, player: player)
                    .frame(width: size.width / 6)
                
                ZStack {
                    VStack(spacing: 0) {
                        LifeAdjuster(viewModel: viewModel, player: player, orientation: .left)
                        Rectangle().hidden()
                        LifeAdjuster(viewModel: viewModel, player: player, orientation: .right)
                    }
                    VStack(spacing: 0) {
                        Rectangle().hidden()
                        HStack(spacing: 0) {
                            if viewModel.commanderDamageEnabled && viewModel.commanderDamageEnabled(for: player) {
                                CommanderDamageDisplay(viewModel: viewModel, player: player)
                                    .frame(width: size.width / 4)
                            } else {
                                Rectangle()
                                    .hidden()
                                    .frame(width: size.width / 4)
                            }
                            LifeDisplay(viewModel: viewModel, player: player, size: size)
                        }
                        .padding(.leading, 10)
                        Rectangle().hidden()
                    }
                }
            }
            
            Group {
                if viewModel.counterViewEnabled(for: player) {
                    CountersView(viewModel: viewModel, player: player)
                }
            }
            .transition(.identity)
        }
    }
}
