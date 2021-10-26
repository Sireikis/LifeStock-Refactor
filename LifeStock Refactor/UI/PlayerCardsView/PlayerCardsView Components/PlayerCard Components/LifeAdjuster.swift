//
//  LifeAdjuster.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/19/21.
//

import SwiftUI


extension PlayerCard {
    
    struct LifeAdjuster: View {
        
        @ObservedObject var viewModel: ViewModel
        
        var player: Int
        var functionality: (Int) -> ()
        var leftCounterName: String
        var leftCounterType: CounterType
        var rightCounterName: String
        var rightCounterType: CounterType
        
        var body: some View {
            ZStack {
                Button(action: {
                    functionality(player)
                }) {
                    // Gives a softer press color when button pressed
                    Rectangle()
                        .background(LifeStockColor.lightBackground)
                        // IPhone 8 and 11 Pro Max have 1 pixel of background (rounding error of frame()?)
                        // show through, .border covers it.
                        .border(viewModel.currentColor(of: player))
                }
                
                HStack {
                    VStack {
                        if viewModel.isCounterDisplayedOnPlayerCardOf(player: player, counter: leftCounterType) {
                            CounterDisplayer(
                                viewModel: viewModel,
                                player: player,
                                imageName: leftCounterName,
                                type: leftCounterType)
                        }
                        if viewModel.isCounterDisplayedOnPlayerCardOf(player: player, counter: rightCounterType) {
                            CounterDisplayer(
                                viewModel: viewModel,
                                player: player,
                                imageName: rightCounterName,
                                type: rightCounterType)
                        }
                    }
                    Rectangle().hidden()
                }
                .foregroundColor(Color.white)
            }
        }
    }
}

extension PlayerCard.LifeAdjuster {
    
    enum LifeAdjusterType {
        case left
        case right
    }
    
    init(viewModel: PlayerCard.ViewModel, player: Int, orientation: LifeAdjusterType) {
        self.viewModel = viewModel
        
        switch orientation {
        case .left:
            self.player = player
            
            self.functionality = viewModel.decreaseLifeTotalOf(player:)
            self.leftCounterName = SFSymbols.commanderTax
            self.leftCounterType = .commanderTax
            self.rightCounterName = SFSymbols.storm
            self.rightCounterType = .storm
            
        case .right:
            self.player = player
            
            self.functionality = viewModel.increaseLifeTotalOf(player:)
            self.leftCounterName = SFSymbols.experience
            self.leftCounterType = .experience
            self.rightCounterName = SFSymbols.energy
            self.rightCounterType = .energy
        }
    }
}

extension PlayerCard.LifeAdjuster {
    
    struct CounterDisplayer: View {
        
        enum Constants {
            static let quarterScaleFactor: CGFloat = 0.40
            static let halfScaleFactor: CGFloat = 0.35
        }
        
        @ObservedObject var viewModel: PlayerCard.ViewModel
        
        var player: Int
        var imageName: String
        var type: CounterType
        
        var body: some View {
            GeometryReader { geometry in
                body(for: geometry.size)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
        }
        
        func body(for size: CGSize) -> some View {
            HStack {
                ZStack {
                    Rectangle()
                        .hidden()
                        .frame(width: size.width / 2.5, height: size.height / 4)
                    Image(systemName: imageName)
                        .font(Font.system(size: imageSize(for: size)))
                        .rotationEffect(.degrees(90))
                        .offset(x: type == .storm ?  -3 : 0)
                }
                
                ZStack {
                    Rectangle()
                        .hidden()
                        .frame(width: size.width / 2.5, height: size.height / 4)
                    Text(viewModel.counterQuantityFor(player: player, counter: type))
                        .font(Font.system(size: fontSize(for: size)))
                        .rotationEffect(.degrees(90))
                }
            }
        }
        
        private func imageSize(for size: CGSize) -> CGFloat {
            if player == 1 {
                if viewModel.numberOfPlayers != 4 {
                    // Half screen case
                    return min(size.width, size.height) * Constants.halfScaleFactor
                } else {
                    return min(size.width, size.height) * Constants.quarterScaleFactor
                }
            } else if player == 2 {
                if viewModel.numberOfPlayers == 1 || viewModel.numberOfPlayers == 2 {
                    // Half screen case
                    return min(size.width, size.height) * Constants.halfScaleFactor
                } else {
                    return min(size.width, size.height) * Constants.quarterScaleFactor
                }
            } else {
                return min(size.width, size.height) * Constants.quarterScaleFactor
            }
        }
        
        private func fontSize(for size: CGSize) -> CGFloat {
            if player == 1 {
                if viewModel.numberOfPlayers != 4 {
                    // Half screen case
                    return min(size.width, size.height) * Constants.halfScaleFactor
                } else {
                    return min(size.width, size.height) * Constants.quarterScaleFactor
                }
            } else if player == 2 {
                if viewModel.numberOfPlayers == 1 || viewModel.numberOfPlayers == 2 {
                    // Half screen case
                    return min(size.width, size.height) * Constants.halfScaleFactor
                } else {
                    return min(size.width, size.height) * Constants.quarterScaleFactor
                }
            } else {
                return min(size.width, size.height) * Constants.quarterScaleFactor
            }
        }
    }
}
