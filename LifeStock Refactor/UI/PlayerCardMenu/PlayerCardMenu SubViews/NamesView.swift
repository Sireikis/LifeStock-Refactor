//
//  NamesView.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/25/21.
//

import SwiftUI


extension PlayerCardMenuView {
 
    struct NamesView: View {
        
        @ObservedObject var viewModel: ViewModel
        
        @State var editing: Bool = false
        @State var playerBeingEdited: Int?
        
        var body: some View {
            GeometryReader { geometry in
                body(for: geometry.size)
            }
        }
        
        func body(for size: CGSize) -> some View {
            ZStack {
                LifeStockColor.darkBackground.edgesIgnoringSafeArea(.all)
                
                VStack {
                    BackButton(
                        viewModel: viewModel,
                        editing: $editing,
                        playerBeingEdited: $playerBeingEdited)
                        .padding(.horizontal)
                        .frame(height: size.height / 10)
                    
                    VStack(spacing: 15) {
                        PlayerNameDisplayGenerator(
                            viewModel: viewModel,
                            editing: $editing,
                            playerBeingEdited: $playerBeingEdited,
                            size: size)
                    }
                    .padding(.horizontal)
                    Spacer()
                }
            }
        }
    }
}

extension PlayerCardMenuView.NamesView {
    
    struct BackButton: View {
        
        @ObservedObject var viewModel: PlayerCardMenuView.ViewModel
        
        @Binding var editing: Bool
        @Binding var playerBeingEdited: Int?
        
        var body: some View {
            GeometryReader { geometry in
                body(for: geometry.size)
            }
        }
        
        func body(for size: CGSize) -> some View {
            HStack {
                ZStack(alignment: .leading) {
                    Rectangle().hidden()
                    
                    if !editing {
                        Button(action: {
                            withAnimation {
                                viewModel.navigateToPlayerCardMenuFromNamesView()
                            }
                        }) {
                            Image(systemName: SFSymbols.leftChevron)
                                .font(Font.getFont(size: size, scalingFactor: 0.40))
                                .foregroundColor(Color.white)
                                .padding()
                        }
                    }
                }
                
                ZStack(alignment: .trailing) {
                    Rectangle().hidden()
                    
                    if editing {
                        Button(action: {
                            editing = false
                            playerBeingEdited = nil
                            hideKeyboard()
                            
                            withAnimation {
                                viewModel.navigateToPlayerCardsFromNamesView()
                            }
                        }) {
                            Image(systemName: SFSymbols.xMark)
                                .font(Font.getFont(size: size, scalingFactor: 0.40))
                                .foregroundColor(Color.white)
                        }
                    } else {
                        Button(action: {
                            withAnimation {
                                viewModel.navigateToPlayerCardsFromNamesView()
                            }
                        }) {
                            Image(systemName: SFSymbols.checkMark)
                                .font(Font.getFont(size: size, scalingFactor: 0.40))
                                .foregroundColor(Color.white)
                        }
                    }
                }
                .padding(.trailing)
            }
        }
    }
}

extension PlayerCardMenuView.NamesView {
    
    struct PlayerNameDisplayGenerator: View {
        
        @ObservedObject var viewModel: PlayerCardMenuView.ViewModel
        
        @Binding var editing: Bool
        @Binding var playerBeingEdited: Int?
        
        var size: CGSize
        
        var body: some View {
            ForEach((1...viewModel.numberOfPlayers), id:\.self) { player in
                PlayerNameDisplay(
                    viewModel: viewModel,
                    playerName: viewModel.playerName(for: player),
                    editing: $editing,
                    playerBeingEdited: $playerBeingEdited,
                    player: player)
                    .frame(width: size.width / 1.20, height: size.height / 10)
            }
        }
    }
}

extension PlayerCardMenuView.NamesView {
    
    struct PlayerNameDisplay: View {
        
        @ObservedObject var viewModel: PlayerCardMenuView.ViewModel
        
        @State var playerName: String
        @Binding var editing: Bool
        @Binding var playerBeingEdited: Int?
        
        var player: Int
        
        var body: some View {
            ZStack {
                TextField(playerName, text: $playerName,
                          onEditingChanged: { _ in
                            viewModel.changePlayerName(of: player, to: playerName)
                            editing.toggle()
                            playerBeingEdited = player
                          },
                          onCommit: {
                            editing = true
                          }
                )
                .keyboardType(.alphabet)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundColor(Color.black)
                .padding()
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .foregroundColor(Color.black)
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(lineWidth: 4)
                            .foregroundColor(Color.white)
                    }
                )
                // Blocks other fields that arent being edited
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .opacity(editing ? playerBeingEdited == player ? 0 : 0.5 : 0)
                )
            }
        }
    }
}
