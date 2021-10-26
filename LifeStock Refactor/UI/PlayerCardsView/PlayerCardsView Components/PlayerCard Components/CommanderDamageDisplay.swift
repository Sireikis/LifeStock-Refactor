//
//  CommanderDamageDisplay.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/19/21.
//

import SwiftUI


extension PlayerCard {
    
    struct CommanderDamageDisplay: View {
        
        @ObservedObject var viewModel: ViewModel
        
        var player: Int
        
        var body: some View {
            GeometryReader { geometry in
                body(for: geometry.size)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
        }
        
        func body(for size: CGSize) -> some View {
            Button(action: {
                viewModel.toggleCountersViewOf(player: player)
            }) {
                Group {
                    if viewModel.numberOfPlayers == 4 {
                        fourPlayerConfigFor(player: player, size: size)
                    } else if viewModel.numberOfPlayers == 3 {
                        threePlayerConfigFor(player: player, size: size)
                    } else if viewModel.numberOfPlayers == 2 {
                        twoPlayerConfigFor(player: player, size: size)
                    } else {
                        onePlayerConfigFor(player: player, size: size)
                    }
                }
                .foregroundColor(.white)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        
        func fourPlayerConfigFor(player: Int, size: CGSize) -> some View {
            VStack(spacing: 5) {
                HStack(spacing: 5) {
                    if player == 1 {
                        topSideCommanderDamage(for: player, botleftPlayer: player, topleftPlayer: 3)
                    } else if player == 2 {
                        topSideCommanderDamage(for: player, botleftPlayer: 1, topleftPlayer: 3)
                    } else if player == 3 {
                        topSideCommanderDamage(for: player, botleftPlayer: 4, topleftPlayer: 2)
                    } else {
                        topSideCommanderDamage(for: player, botleftPlayer: player, topleftPlayer: 2)
                    }
                }
                .frame(height: size.height / 3)
                
                HStack(spacing: 5) {
                    if player == 1 {
                        bottomSideCommanderDamage(for: player, botrightPlayer: 2, toprightPlayer: 4)
                    } else if player == 2 {
                        bottomSideCommanderDamage(for: player, botrightPlayer: player, toprightPlayer: 4)
                    } else if player == 3 {
                        bottomSideCommanderDamage(for: player, botrightPlayer: player, toprightPlayer: 1)
                    } else {
                        bottomSideCommanderDamage(for: player, botrightPlayer: 3, toprightPlayer: 1)
                    }
                }
                .frame(height: size.height / 3)
            }
        }
        
        func threePlayerConfigFor(player: Int, size: CGSize) -> some View {
            Group {
                if player == 1 {
                    HStack(spacing: 5) {
                        VStack(spacing: 5) {
                            Rectangle().hidden()
                            displayCommanderDamageOf(player: player, from: player)
                            Rectangle().hidden()
                        }
                        VStack(spacing: 5) {
                            displayCommanderDamageOf(player: player, from: 2)
                            displayCommanderDamageOf(player: player, from: 3)
                        }
                    }
                    .frame(height: size.height / 2)
                } else if player == 2 {
                    VStack(spacing: 5) {
                        displayCommanderDamageOf(player: player, from: 3)
                        HStack(spacing: 5) {
                            displayCommanderDamageOf(player: player, from: player)
                            displayCommanderDamageOf(player: player, from: 1)
                        }
                    }
                } else {
                    VStack(spacing: 5) {
                        HStack(spacing: 5) {
                            displayCommanderDamageOf(player: player, from: player)
                            displayCommanderDamageOf(player: player, from: 1)
                        }
                        displayCommanderDamageOf(player: player, from: 2)
                    }
                }
            }
        }
        
        func twoPlayerConfigFor(player: Int, size: CGSize) -> some View {
            Group {
                if player == 1 {
                    VStack(spacing: 5) {
                        displayCommanderDamageOf(player: player, from: player)
                        displayCommanderDamageOf(player: player, from: 2)
                    }
                } else {
                    VStack(spacing: 5) {
                        displayCommanderDamageOf(player: player, from: player)
                        displayCommanderDamageOf(player: player, from: 1)
                    }
                }
            }
            .frame(height: size.height / 2)
        }
        
        func onePlayerConfigFor(player: Int, size: CGSize) -> some View {
            Group {
                VStack(spacing: 5) {
                    displayCommanderDamageOf(player: player, from: player)
                    displayCommanderDamageOf(player: player, from: 2)
                }
            }
            .frame(width: size.width / 1.5, height: size.height / 2)
        }
        
        func topSideCommanderDamage(
            for player: Int,
            botleftPlayer: Int,
            topleftPlayer: Int
        ) -> some View {
            Group {
                displayCommanderDamageOf(player: player, from: botleftPlayer)
                displayCommanderDamageOf(player: player, from: topleftPlayer)
            }
        }
        
        
        func bottomSideCommanderDamage(
            for player: Int,
            botrightPlayer: Int,
            toprightPlayer: Int
        ) -> some View {
            Group {
                displayCommanderDamageOf(player: player, from: botrightPlayer)
                displayCommanderDamageOf(player: player, from: toprightPlayer)
            }
        }
        
        func displayCommanderDamageOf(player: Int, from attackingPlayer: Int) -> some View {
            GeometryReader { geometry in
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                    if player != attackingPlayer {
                        Text(viewModel.showCommanderDamage(of: player, from: attackingPlayer))
                            .font(Font.getFont(size: geometry.size, scalingFactor: 0.80))
                            .foregroundColor(Color.black)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .rotationEffect(.degrees(90))
                    } else if viewModel.isMonarch(player: player) {
                        Image(systemName: SFSymbols.crown)
                            .font(
                                Font.system(
                                    size: viewModel.numberOfPlayers == 1 ?
                                    imageSize(for: geometry.size, smaller: false) :
                                        imageSize(for: geometry.size, smaller: true)
                                )
                            )
                            .foregroundColor(Color.black)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .rotationEffect(.degrees(90))
                    }
                }
            }
        }
        
        private func imageSize(for size: CGSize, smaller: Bool) -> CGFloat {
            if smaller {
                return min(size.width, size.height) * 0.80
            } else {
                return min(size.width, size.height) * 0.70
            }
        }
    }
}
