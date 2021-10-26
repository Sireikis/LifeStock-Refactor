//
//  HistoryView.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/25/21.
//

import SwiftUI


extension PlayerCardMenuView {
    
    struct HistoryView: View {
        
        @ObservedObject var viewModel: ViewModel
        
        var body: some View {
            GeometryReader { geometry in
                body(for: geometry.size)
            }
        }
        
        func body(for size: CGSize) -> some View {
            ZStack {
                LifeStockColor.darkBackground.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    MenuBar(viewModel: viewModel)
                        .frame(height: size.height / 10)
                    // White divider
                    Rectangle()
                        .frame(height: 3)
                    
                    ScrollView {
                        VStack(spacing: 0) {
                            // White divider
                            Rectangle()
                                .frame(height: 3)
                            
                            // Player liftotal history columns
                            HStack(alignment: .top) {
                                ForEach((1...viewModel.numberOfPlayers), id:\.self) { player in
                                    HStack(alignment: .top) {
                                        LifeTotalColumn(
                                            viewModel: viewModel,
                                            player: player,
                                            size: size)
                                        
                                        if player != viewModel.numberOfPlayers {
                                            // Creates white dividers between columns
                                            HistoryViewColumnDivider(
                                                viewModel: viewModel,
                                                player: player,
                                                size: size)
                                        } else {
                                            // Adjusts size of last column by creating a hidden divider
                                            HistoryViewColumnDivider(
                                                viewModel: viewModel,
                                                player: player,
                                                size: size, hidden: true)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .foregroundColor(.white)
            }
        }
    }
}

extension PlayerCardMenuView.HistoryView {
    
    struct MenuBar: View {
        
        @ObservedObject var viewModel: PlayerCardMenuView.ViewModel
        
        var body: some View {
            GeometryReader { geometry in
                body(for: geometry.size)
            }
        }
        
        func body(for size: CGSize) -> some View {
            HStack {
                ZStack(alignment: .leading) {
                    Rectangle().hidden()
                    
                    Button(action: {
                        withAnimation {
                            viewModel.navigateToPlayerCardMenuFromHistoryView()
                        }
                    }) {
                        Image(systemName: SFSymbols.leftChevron)
                            .font(Font.getFont(size: size, scalingFactor: 0.40))
                            .foregroundColor(Color.white)
                    }
                }
                .padding(.leading)
                
                ZStack(alignment: .trailing) {
                    Rectangle().hidden()
                    
                    Button(action: {
                        withAnimation {
                            viewModel.navigateToPlayerCardsViewFromHistoryView()
                        }
                    }) {
                        Image(systemName: SFSymbols.checkMark)
                            .font(Font.getFont(size: size, scalingFactor: 0.40))
                            .foregroundColor(Color.white)
                    }
                }
                .padding(.trailing)
            }
            .padding(.horizontal)
        }
    }
}

extension PlayerCardMenuView.HistoryView {
    
    struct LifeTotalColumn: View {
    
        @ObservedObject var viewModel: PlayerCardMenuView.ViewModel
        
        var player: Int
        var size: CGSize
        
        var body: some View {
            GeometryReader { geometry in
                body(for: geometry.size)
            }
        }
        
        func body(for size: CGSize) -> some View {
            ZStack(alignment: .top) {
                Rectangle().hidden()
                
                VStack(spacing: 0) {
                    VStack(spacing: 0) {
                        GeometryReader { header in
                            Text(viewModel.playerName(for: player))
                                .font(Font.system(size: playerNameSize(
                                    for: header.size,
                                       columnNumber: viewModel.numberOfPlayers)))
                                .minimumScaleFactor(0.8)
                                .lineLimit(1)
                                .position(x: header.size.width / 2, y: header.size.height / 2)
                        }
                        GeometryReader { header in
                            Text(String(viewModel.startingLifeTotals))
                                .font(Font.system(size: startingLifeTotalSize(
                                    for: header.size,
                                       columnNumber: viewModel.numberOfPlayers)))
                                .lineLimit(1)
                                .position(x: header.size.width / 2, y: header.size.height / 2)
                        }
                    }
                    .frame(width: size.width, height: self.size.height / 10)
                    
                    ForEach((0..<viewModel.lifeTotalHistoryArrayCount(of: player)), id:\.self) { index in
                        if let lifeTotal = viewModel.lifeTotalHistory(of: player, at: index) {
                            GeometryReader { geometry in
                                Text(String(lifeTotal))
                                    .font(Font.system(size: fontSize(
                                        for: geometry.size,
                                           columnNumber: viewModel.numberOfPlayers)))
                                    .minimumScaleFactor(0.6)
                                    .lineLimit(1)
                                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                            }
                            .frame(width: size.width / 2, height: self.size.height / 20)

                        } else {
                            Text("")
                                .lineLimit(1)
                                .frame(width: size.width / 2, height: self.size.height / 20)
                        }
                    }
                }
            }
        }
        
        private func playerNameSize(for size: CGSize, columnNumber: Int) -> CGFloat {
            switch columnNumber {
            case 4:
                return min(size.width, size.height) * 0.60
            case 3:
                return min(size.width, size.height) * 0.70
            case 2:
                return min(size.width, size.height) * 0.80
            case 1:
                return min(size.width, size.height) * 0.90
            default: // Should never run
                return min(size.width, size.height)
            }
        }
        
        private func startingLifeTotalSize(for size: CGSize, columnNumber: Int) -> CGFloat {
            switch columnNumber {
            case 4:
                return min(size.width, size.height) * 0.80
            case 3:
                return min(size.width, size.height) * 0.85
            case 2:
                return min(size.width, size.height) * 0.90
            case 1:
                return min(size.width, size.height) * 0.95
            default: // Should never run
                return min(size.width, size.height)
            }
        }
        
        private func fontSize(for size: CGSize, columnNumber: Int) -> CGFloat {
            switch columnNumber {
            case 4:
                return min(size.width, size.height) * 0.70
            case 3:
                return min(size.width, size.height) * 0.75
            case 2:
                return min(size.width, size.height) * 0.80
            case 1:
                return min(size.width, size.height) * 0.85
            default: // Should never run
                return min(size.width, size.height)
            }
        }
    }
}

extension PlayerCardMenuView.HistoryView {
    
    struct HistoryViewColumnDivider: View {
        
        @ObservedObject var viewModel: PlayerCardMenuView.ViewModel
        
        var player: Int
        var size: CGSize
        
        var hidden: Bool = false
        
        var body: some View {
            if hidden {
                Rectangle()
                    // Causes the hidden divider to grow as the history screen grows
                    .frame(width: 3, height: calculateDividerSize())
                    .hidden()
            } else {
                Rectangle()
                    // Causes the divider to grow as the history screen grows
                    .frame(width: 3, height: calculateDividerSize())
            }
            
        }
        
        func calculateDividerSize() -> CGFloat {
            let screenSize = size.height - size.height / 10
            let adjustedScreenSize = (size.height / 10) + ((size.height / 20) * CGFloat(viewModel.lifeTotalHistoryArrayCount(of: player)))
            if adjustedScreenSize > screenSize {
                return adjustedScreenSize
            } else {
                return screenSize
            }
        }
    }
}
