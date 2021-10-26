//
//  CountersView.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/20/21.
//

import SwiftUI

extension PlayerCard {
    
    struct CountersView: View {

        @ObservedObject var viewModel: ViewModel
        
        var player: Int
        
        var body: some View {
            GeometryReader { geometry in
                body(for: geometry.size)
            }
        }
        
        func body(for size: CGSize) -> some View {
            ZStack {
                LifeStockColor.darkBackground
                
                HStack(spacing: 0) {
                    VStack {
                        // First counters box (leftmost)
                        topModifiableCounters(viewModel: viewModel, player: player)
                            .padding(.top, 5)
                        
                        // Second counters box (center, commander damage)
                        CommanderDamageAdjuster(viewModel: viewModel, player: player)
                        
                        // Third counters box (rightmost)
                        bottomModifiableCounters(viewModel: viewModel, player: player)
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal, 10)
                    
                    // Enable/disable button and checkmark
                    CountersViewMenuBar(viewModel: viewModel, player: player)
                        .frame(width: size.width / 5)
                }
                .foregroundColor(Color.white)
            }
        }
    }
}

extension PlayerCard.CountersView {
    
    struct topModifiableCounters: View {
        
        @ObservedObject var viewModel: PlayerCard.ViewModel
        
        var player: Int
        
        var body: some View {
            VStack {
                CountersButton(
                    viewModel: viewModel,
                    player: player,
                    imageName: SFSymbols.commanderTax,
                    type: .commanderTax)
                CountersButton(
                    viewModel: viewModel,
                    player: player,
                    imageName: SFSymbols.storm,
                    type: .storm)
            }
        }
    }

    struct bottomModifiableCounters: View {
        
        @ObservedObject var viewModel: PlayerCard.ViewModel
        
        var player: Int
        
        var body: some View {
            VStack {
                CountersButton(
                    viewModel: viewModel,
                    player: player,
                    imageName: SFSymbols.experience,
                    type: .experience)
                CountersButton(
                    viewModel: viewModel,
                    player: player,
                    imageName: SFSymbols.energy,
                    type: .energy)
            }
        }
    }
}

extension PlayerCard.CountersView {
    
    struct CountersButton: View {
        
        @ObservedObject var viewModel: PlayerCard.ViewModel
        
        var player: Int
        var imageName: String
        var type: CounterType
    
        var body: some View {
            GeometryReader { geometry in
                body(for: geometry.size)
            }
        }
        
        func body(for size: CGSize) -> some View {
            ZStack {
                HStack(spacing: 0) {
                    if viewModel.countersModifiable(player: player) {
                        Button(action: {
                            withAnimation {
                                viewModel.toggleCounterOnPlayerCard(for: player, counter: type)
                            }
                        }) {
                            Rectangle()
                        }
                    } else {
                        Button(action: {
                            viewModel.decrementCounterOf(player: player, counter: type)
                        }) {
                            Rectangle()
                        }
                        Button(action: {
                            viewModel.incrementCounterOf(player: player, counter: type)
                        }) {
                            Rectangle()
                        }
                    }
                }
                .foregroundColor(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                
                
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(lineWidth: 2)
                    .foregroundColor(
                        viewModel.isCounterDisplayedOnPlayerCardOf(player: player, counter: type)
                            ? Color.green : viewModel.countersModifiable(player: player)
                            ? Color.red : Color.white)
                
                HStack {
                    ZStack {
                        Rectangle()
                            .opacity(0)
                            .frame(width: size.width / 4, height: size.height / 4)
                        Image(systemName: imageName)
                            .font(Font.system(size: imageSize(for: size)))
                            .rotationEffect(.degrees(90))
                            .offset(x: type == .storm ?  -3 : 0)
                    }
                    ZStack {
                        Rectangle()
                            .opacity(0)
                            .frame(width: size.width / 4, height: size.height / 4)
                        Text(viewModel.counterQuantityFor(player: player, counter: type))
                            .font(Font.system(size: fontSize(for: size)))
                            // Stops the numbers from easing in and out or sliding
                            // However, messes up any transitions, thus .identity
                            .id(UUID())
                            .transition(.identity)
                            .rotationEffect(.degrees(90))
                    }
                }
            }
        }
        
        private func imageSize(for size: CGSize) -> CGFloat {
            if player == 1 {
                if viewModel.numberOfPlayers != 4 {
                    // Half screen case
                    return min(size.width, size.height) * 0.30
                } else {
                    return min(size.width, size.height) * 0.40
                }
            } else if player == 2 {
                if viewModel.numberOfPlayers == 1 || viewModel.numberOfPlayers == 2 {
                    // Half screen case
                    return min(size.width, size.height) * 0.30
                } else {
                    return min(size.width, size.height) * 0.40
                }
            } else {
                return min(size.width, size.height) * 0.40
            }
        }
        
        private func fontSize(for size: CGSize) -> CGFloat {
            if player == 1 {
                if viewModel.numberOfPlayers != 4 {
                    // Half screen case
                    return min(size.width, size.height) * 0.30
                } else {
                    return min(size.width, size.height) * 0.40
                }
            } else if player == 2 {
                if viewModel.numberOfPlayers == 1 || viewModel.numberOfPlayers == 2 {
                    // Half screen case
                    return min(size.width, size.height) * 0.30
                } else {
                    return min(size.width, size.height) * 0.40
                }
            } else {
                return min(size.width, size.height) * 0.40
            }
        }
    }
}

extension PlayerCard.CountersView {
    
    struct CommanderDamageAdjuster: View {
        
        @ObservedObject var viewModel: PlayerCard.ViewModel
        
        var player: Int
        
        var body: some View {
            Group {
                if viewModel.numberOfPlayers == 4 {
                    fourPlayerConfigFor(player: player)
                } else if viewModel.numberOfPlayers == 3 {
                    threePlayerConfigFor(player: player)
                } else if viewModel.numberOfPlayers == 2 {
                    twoPlayerConfigFor(player: player)
                } else {
                    onePlayerConfigFor(player: player)
                }
            }
        }
        
        func fourPlayerConfigFor(player: Int) -> some View {
            VStack {
                HStack {
                    if player == 1 {
                        topSideCommanderDamage(
                            for: player,
                               botleftPlayer: player,
                               topleftPlayer: 3)
                    } else if player == 2 {
                        topSideCommanderDamage(
                            for: player,
                               botleftPlayer: 1,
                               topleftPlayer: 3)
                    } else if player == 3 {
                        topSideCommanderDamage(
                            for: player,
                               botleftPlayer: 4,
                               topleftPlayer: 2)
                    } else {
                        topSideCommanderDamage(
                            for: player,
                               botleftPlayer: player,
                               topleftPlayer: 2)
                    }
                }
                HStack {
                    if player == 1 {
                        bottomSideCommanderDamage(
                            for: player,
                               botrightPlayer: 2,
                               toprightPlayer: 4)
                    } else if player == 2 {
                        bottomSideCommanderDamage(
                            for: player,
                               botrightPlayer: player,
                               toprightPlayer: 4)
                    } else if player == 3 {
                        bottomSideCommanderDamage(
                            for: player,
                               botrightPlayer: player,
                               toprightPlayer: 1)
                    } else {
                        bottomSideCommanderDamage(
                            for: player,
                               botrightPlayer: 3,
                               toprightPlayer: 1)
                    }
                }
            }
        }
        
        func threePlayerConfigFor(player: Int) -> some View {
            Group {
                if player == 1 {
                    VStack {
                        CommanderDamageButton(
                            viewModel: viewModel,
                            player: player,
                            fromPlayer: 2)
                        CommanderDamageButton(
                            viewModel: viewModel,
                            player: player,
                            fromPlayer: player)
                        CommanderDamageButton(
                            viewModel: viewModel,
                            player: player,
                            fromPlayer: 3)
                    }
                } else if player == 2 {
                    VStack {
                        CommanderDamageButton(
                            viewModel: viewModel,
                            player: player,
                            fromPlayer: 3)
                        HStack {
                            CommanderDamageButton(
                                viewModel: viewModel,
                                player: player,
                                fromPlayer: player)
                            CommanderDamageButton(
                                viewModel: viewModel,
                                player: player,
                                fromPlayer: 1)
                        }
                    }
                } else {
                    VStack {
                        HStack {
                            CommanderDamageButton(
                                viewModel: viewModel,
                                player: player,
                                fromPlayer: player)
                            CommanderDamageButton(
                                viewModel: viewModel,
                                player: player,
                                fromPlayer: 1)
                        }
                        CommanderDamageButton(
                            viewModel: viewModel,
                            player: player,
                            fromPlayer: 2)
                    }
                }
            }
        }
        
        func twoPlayerConfigFor(player: Int) -> some View {
            Group {
                VStack {
                    if player == 1 {
                        CommanderDamageButton(
                            viewModel: viewModel,
                            player: player,
                            fromPlayer: player)
                        CommanderDamageButton(
                            viewModel: viewModel,
                            player: player,
                            fromPlayer: 2)
                    } else {
                        CommanderDamageButton(
                            viewModel: viewModel,
                            player: player,
                            fromPlayer: player)
                        CommanderDamageButton(
                            viewModel: viewModel,
                            player: player,
                            fromPlayer: 1)
                    }
                }
            }
        }
        
        func onePlayerConfigFor(player: Int) -> some View {
            Group {
                VStack {
                    CommanderDamageButton(
                        viewModel: viewModel,
                        player: player,
                        fromPlayer: player)
                    CommanderDamageButton(
                        viewModel: viewModel,
                        player: player,
                        fromPlayer: 2)
                }
            }
        }
        
        func topSideCommanderDamage(for player: Int, botleftPlayer: Int, topleftPlayer: Int) -> some View {
            Group {
                CommanderDamageButton(
                    viewModel: viewModel,
                    player: player,
                    fromPlayer: botleftPlayer)
                CommanderDamageButton(
                    viewModel: viewModel,
                    player: player,
                    fromPlayer: topleftPlayer)
            }
        }
        
        func bottomSideCommanderDamage(for player: Int, botrightPlayer: Int, toprightPlayer: Int) -> some View {
            Group {
                CommanderDamageButton(
                    viewModel: viewModel,
                    player: player,
                    fromPlayer: botrightPlayer)
                CommanderDamageButton(
                    viewModel: viewModel,
                    player: player,
                    fromPlayer: toprightPlayer)
            }
        }
    }
}

extension PlayerCard.CountersView {
    
    struct CommanderDamageButton: View {
        
        @ObservedObject var viewModel: PlayerCard.ViewModel
        
        var player: Int
        // Commander damage dealt by player
        var fromPlayer: Int
        
        var body: some View {
            GeometryReader { geometry in
                body(for: geometry.size)
            }
        }
        
        func body(for size: CGSize) -> some View {
            ZStack {
                if player != fromPlayer {
                    HStack(spacing: 0) {
                        Button(action: {
                            viewModel.decrementCommanderDamageOf(player: player, from: fromPlayer)
                        }) {
                            Rectangle().foregroundColor(Color.black)
                        }
                        Button(action: {
                            viewModel.incrementCommanderDamageOf(player: player, from: fromPlayer)
                        }) {
                            Rectangle().foregroundColor(Color.black)
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(lineWidth: 2)
                    
                    Text(viewModel.showCommanderDamage(of: player, from: fromPlayer))
                        .font(Font.getFont(size: size, scalingFactor: 0.40))
                        // Stops the numbers from easing in and out or sliding
                        // However, messes up any transitions, thus .identity
                        .id(UUID())
                        .transition(.identity)
                        .rotationEffect(.degrees(90))
                } else {
                    MonarchButton(viewModel: viewModel, player: player)
                }
            }
        }
    }
}

extension PlayerCard.CountersView {
    
    struct MonarchButton: View {
        
        @ObservedObject var viewModel: PlayerCard.ViewModel
        
        var player: Int
        
        var body: some View {
            GeometryReader { geometry in
                body(for: geometry.size)
            }
        }
        
        func body(for size: CGSize) -> some View {
            ZStack {
                Button(action: {
                    withAnimation {
                        viewModel.changeMonarchTo(player: player)
                    }
                }) {
                    ZStack {
                        Rectangle().foregroundColor(Color.black)
                        
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(lineWidth: 4)
                            .foregroundColor(viewModel.isMonarch(player: player) ? Color.green : Color.white)
                        
                        Image(systemName: SFSymbols.crown)
                            .font(Font.getFont(size: size, scalingFactor: 0.40))
                            .rotationEffect(.degrees(90))
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }
        }
    }
}

extension PlayerCard.CountersView {
    
    struct CountersViewMenuBar: View {
        
        @ObservedObject var viewModel: PlayerCard.ViewModel
        
        var player: Int
        
        var body: some View {
            VStack {
                Rectangle().hidden()
                MenuBarPowerSymbol(viewModel: viewModel, player: player)
                
                Rectangle().hidden()
                
                MenuBarCheckMarkSymbol(viewModel: viewModel, player: player)
                Rectangle().hidden()
            }
        }
    }
}

extension PlayerCard.CountersView {
    
    struct MenuBarPowerSymbol: View {
        
        @ObservedObject var viewModel: PlayerCard.ViewModel
        
        var player: Int
        
        var body: some View {
            GeometryReader { geometry in
                body(for: geometry.size)
            }
        }
        
        func body(for size: CGSize) -> some View {
            ZStack {
                Rectangle().hidden()
                Button(action: {
                    withAnimation {
                        viewModel.toggleCountersModifiable(for: player)
                    }
                }) {
                    ZStack {
                        Rectangle()
                            .frame(width: size.width / 1.5, height: size.height / 2)
                            .hidden()
                        Image(systemName: "power")
                            .font(Font.getFont(size: size, scalingFactor: 0.40))
                            .foregroundColor(
                                viewModel.countersModifiable(player: player) ? Color.green : Color.white)
                            .rotationEffect(.degrees(90))
                    }
                }
            }
        }
    }
}

extension PlayerCard.CountersView {
    
    struct MenuBarCheckMarkSymbol: View {
        
        @ObservedObject var viewModel: PlayerCard.ViewModel
        
        var player: Int
        
        var body: some View {
            GeometryReader { geometry in
                body(for: geometry.size)
            }
        }
        
        func body(for size: CGSize) -> some View {
            ZStack {
                Rectangle().hidden()
                Button(action: {
                    withAnimation {
                        viewModel.toggleCountersViewOf(player: player)
                    }
                }) {
                    ZStack {
                        Rectangle()
                            .frame(width: size.width / 1.5, height: size.height / 2)
                            .hidden()
                        Image(systemName: SFSymbols.checkMark)
                            .font(Font.getFont(size: size, scalingFactor: 0.40))
                            .rotationEffect(.degrees(90))
                    }
                }
            }
        }
    }
}
