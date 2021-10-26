//
//  PlayerOptionsView.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/22/21.
//

import SwiftUI


struct PlayerOptionsView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            LifeStockColor.darkBackground.edgesIgnoringSafeArea(.all)
            
            HStack {
                HStack(spacing: -20) {
                    CheckBoxFor(
                        viewModel: viewModel,
                        title: "Player Name",
                        functionality: viewModel.togglePlayerNameFor(player:),
                        enabled: viewModel.isPlayerNameDisplayedFor(player:))
                        .frame(width: size.width / 6)
                    
                    CheckBoxFor(
                        viewModel: viewModel,
                        title: "Commander Damage",
                        functionality: viewModel.toggleCommanderDamageDisplayFor(player:),
                        enabled: viewModel.commanderDamageDisplayedFor(player:))
                        .frame(width: size.width / 6)
                }
                .padding(.leading)
                
                BackgroundColorButtonGenerator(viewModel: viewModel)
                
                BackButton(viewModel: viewModel)
                    .frame(width: size.width / 6)
            }
        }
    }
}

extension PlayerOptionsView {
    
    struct CheckBoxFor: View {
        
        @ObservedObject var viewModel: ViewModel
        
        var title: String
        var functionality: (Int) -> ()
        var enabled: (Int) -> Bool
        
        var body: some View {
            GeometryReader { geometry in
                body(for: geometry.size)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    .foregroundColor(Color.white)
            }
        }
        
        func body(for size: CGSize) -> some View {
            HStack(spacing: 20) {
                Button(action: {
                    withAnimation {
                        functionality(viewModel.playerIDSelected)
                    }
                }) {
                    GeometryReader { checkbox in
                        ZStack {
                            Rectangle()
                                .stroke(lineWidth: 2)

                            if enabled(viewModel.playerIDSelected) {
                                Image(systemName: SFSymbols.checkMark)
                                    .font(Font.getFont(size: checkbox.size, scalingFactor: 0.60))
                            }
                        }
                    }
                }
                .frame(width: size.width / 3, height: size.width / 3)
                
                Text(title)
                    .font(Font.getFont(size: size, scalingFactor: 0.40))
                    .lineLimit(1)
                
                Spacer()
            }
            .rotationEffect(.degrees(90))
            .frame(width: size.height / 1.5)
        }
    }
}

extension PlayerOptionsView {
    
    struct BackgroundColorButtonGenerator: View {
        
        @ObservedObject var viewModel: ViewModel
        
        var colorOptions: [[Color]] = [
            LifeStockColor.topColorBar,
            LifeStockColor.botColorBar,
        ]
        
        var body: some View {
            GeometryReader { geometry in
                body(for: geometry.size)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
        }
        
        func body(for size: CGSize) -> some View {
            VStack {
                Spacer()
                HStack(spacing: 20) {
                    ForEach(colorOptions, id: \.self) { row in
                        VStack(spacing: 20) {
                            ForEach(row, id: \.self) { color in
                                backgroundColorButton(
                                    viewModel: viewModel,
                                    player: viewModel.playerIDSelected,
                                    color: color,
                                    size: size)
                            }
                        }
                    }
                }
                .padding(.vertical, 10)
                .padding(.leading)
                
                Spacer()
            }
        }
    }
}

extension PlayerOptionsView.BackgroundColorButtonGenerator {
    
    struct backgroundColorButton: View {
        
        @ObservedObject var viewModel: PlayerOptionsView.ViewModel
        
        var player: Int
        var color: Color
        var size: CGSize
        
        var body: some View {
            Button(action: {
                withAnimation {
                    viewModel.changeColor(of: player, to: color)
                    viewModel.navigateToPlayerCardsView()
                }
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(color)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 3)
                        .foregroundColor(Color.white)
                        .opacity(color == viewModel.currentColor(of: player) ? 1 : 0.3)
                }
                .frame(width: size.height / 10, height: size.height / 10)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

extension PlayerOptionsView {
    
    struct BackButton: View {
        
        @ObservedObject var viewModel: ViewModel
        
        var body: some View {
            GeometryReader { geometry in
                body(for: geometry.size)
            }
        }
        
        func body(for size: CGSize) -> some View {
            HStack {
                ZStack(alignment: .top) {
                    Rectangle().hidden()
                    
                    Button(action: {
                        withAnimation {
                            viewModel.navigateToPlayerCardsView()
                        }
                    }) {
                        Image(systemName: SFSymbols.leftChevron)
                            .font(Font.getFont(size: size, scalingFactor: 0.40))
                            .foregroundColor(Color.white)
                            .padding()
                    }
                    .rotationEffect(.degrees(90))
                }
                Spacer()
            }
        }
    }
}
