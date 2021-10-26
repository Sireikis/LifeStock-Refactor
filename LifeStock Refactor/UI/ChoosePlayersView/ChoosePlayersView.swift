//
//  ChoosePlayersView.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/4/21.
//

import SwiftUI


struct ChoosePlayerView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    @State var commanderDamageEnabled = true
    
    var body: some View {
        ZStack {
            LifeStockColor.darkBackground.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 5) {
                BackButton(viewModel: viewModel)
                TextBanner(text: "Players")
                
                HStack {
                    ChoosePlayerCount(
                        viewModel: viewModel,
                        startingPlayerCount: viewModel.startingPlayerCount)
                }
                
                TextBanner(text: "Starting Life")
                
                HStack {
                    if viewModel.customLifeEnabled {
                        ChoosePlayerStartingLife(
                            viewModel: viewModel,
                            selectedLifeButton: 4)
                    } else {
                        ChoosePlayerStartingLife(
                            viewModel: viewModel,
                            selectedLifeButton: viewModel.setSelectedLifeButton())
                    }
                }
                
                HStack {
                    VStack {
                        CheckBox(
                            viewModel: viewModel,
                            title: "Commander Damage",
                            enabledSetting: viewModel.commanderDamageEnabled,
                            playersSetting: .commanderDamageEnabled)
                            .frame(width: ScreenSize.width / 1.5)
                        CheckBox(
                            viewModel: viewModel,
                            title: "Player Names",
                            enabledSetting: viewModel.playerNamesEnabled,
                            playersSetting: .namesEnabled)
                            .frame(width: ScreenSize.width / 1.5)
                    }
                }
                .padding(.top)
                
                Button(action: {
                    viewModel.setGame(
                        numberOfPlayers: viewModel.numberOfPlayers,
                        startingLifeTotals: viewModel.startingLifeTotals)
                    withAnimation {
                        viewModel.navigateToPlayerCardsView()
                    }
                }) {
                    StandardButton(text: "Start Game", scalingFactor: 0.40)
                        .frame(width: ScreenSize.width / 2, height: ScreenSize.height / 8)
                }
                .frame(width: ScreenSize.width / 2, height: ScreenSize.height / 4)
            }
        }
        .onAppear {
            let lifeTotal: Int
            if viewModel.customLifeEnabled {
                lifeTotal = viewModel.customLife
            } else {
                lifeTotal = viewModel.playerLife
            }
            viewModel.changeStartingLifeTotals(to: lifeTotal)
            viewModel.changeNumberOfPlayers(to: viewModel.startingPlayerCount)
        }
    }
}

extension ChoosePlayerView {
    
    private struct BackButton: View {
        
        @ObservedObject var viewModel: ViewModel
        
        let size: CGSize = ScreenSize.size
        
        var body: some View {
            HStack(alignment: .top) {
                Button(action: {
                    withAnimation {
                        viewModel.navigateToStartScreenView()
                    }
                }) {
                    Image(systemName: SFSymbols.leftChevron)
                        .font(Font.getFont(size: size.scaledBy(heightFactor: 10), scalingFactor: 0.40))
                        .foregroundColor(Color.white)
                        .padding()
                }
                Spacer()
            }
        }
    }
    
    private struct TextBanner: View {
        
        let size: CGSize = ScreenSize.size
        let text: String
        
        var body: some View {
            ZStack {
                Rectangle().hidden()
                Text(text)
                    .font(Font.getFont(size: size.scaledBy(heightFactor: 12), scalingFactor: 0.60))
                    .foregroundColor(Color.white)
            }
        }
    }
    
    private struct ChoosePlayerCount: View {
        
        @ObservedObject var viewModel: ViewModel
        @State var startingPlayerCount: Int
        
        let size: CGSize = ScreenSize.size
        
        var body: some View {
            ForEach((1...4), id: \.self) { player in
                Button(action: {
                    withAnimation {
                        viewModel.changeNumberOfPlayers(to: player)
                        startingPlayerCount = player
                    }
                }) {
                    GeometryReader { geometry in
                        ZStack {
                            if startingPlayerCount == player {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(LifeStockColor.lightBackground)
                            } else {
                                RoundedRectangle(cornerRadius: 10)
                            }
                            Text("\(player)")
                                .font(Font.getFont(size: geometry.size, scalingFactor: 0.40))
                                .foregroundColor(Color.white)
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .frame(width: size.width / 5, height: size.width / 5)
            }
        }
    }
    
    private struct ChoosePlayerStartingLife: View {
        
        struct LifeButton: Hashable {
        
            var lifeTotal: Int
            var id: Int
        }
        
        @ObservedObject var viewModel: ViewModel
        @State var selectedLifeButton: Int
    
        let size: CGSize = ScreenSize.size
        
        var body: some View {
            ForEach(getLifeButtons(), id: \.self) { lifeButton in
                Button(action: {
                    withAnimation {
                        viewModel.changeStartingLifeTotals(to: lifeButton.lifeTotal)
                        selectedLifeButton = lifeButton.id
                    }
                }) {
                    GeometryReader { geometry in
                        ZStack {
                            
                            if selectedLifeButton == lifeButton.id {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(LifeStockColor.lightBackground)
                            } else {
                                RoundedRectangle(cornerRadius: 10)
                            }
                            
                            Text("\(lifeButton.lifeTotal)")
                                .font(Font.getFont(size: geometry.size, scalingFactor: 0.40))
                                .foregroundColor(Color.white)
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .frame(width: size.width / 5, height: size.width / 5)
                .tag(lifeButton.id)
            }
        }
        
        func getLifeButtons() -> [LifeButton] {
            var buttons = [LifeButton]()
            for lifeTotal in [20,30,40] {
                let button = LifeButton(lifeTotal: lifeTotal, id: (lifeTotal / 10) - 1)
                buttons.append(button)
            }
            
            buttons.append(LifeButton(lifeTotal: viewModel.displayCustomLife(), id: 4))
            
            return buttons
        }
    }
    
    private struct CheckBox: View {
        
        @ObservedObject var viewModel: ViewModel
        
        let size: CGSize = ScreenSize.size
        
        var title: String
        var enabledSetting: Bool
        var playersSetting: PlayersSettings.PlayerSetting
        
        var body: some View {
            HStack {
                Button(action: {
                    viewModel.togglePlayersSetting(playersSetting)
                }) {
                    GeometryReader { checkbox in
                        ZStack {
                            Rectangle()
                                .stroke(lineWidth: 2)
                                .foregroundColor(Color.white)
                            
                            if enabledSetting {
                                Image(systemName: SFSymbols.checkMark)
                                    .font(Font.getFont(size: checkbox.size, scalingFactor: 0.60))
                                    .foregroundColor(Color.white)
                            }
                        }
                    }
                }
                .frame(width: size.width / 14, height: size.width / 14)
                
                Text(title)
                    .font(Font.getFont(size: size.scaledBy(widthFactor: 1.2, heightFactor: 10), scalingFactor: 0.30))
                    .foregroundColor(Color.white)
                    .lineLimit(1)
                
                Spacer()
            }
        }
    }
}

// MARK: - Preview

struct ChoosePlayerView_Previews: PreviewProvider {
    
    static var previews: some View {
        ChoosePlayerView(viewModel: .init(container: .preview))
    }
}
