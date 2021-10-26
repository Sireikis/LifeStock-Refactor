//
//  PlayerCardMenuView.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/22/21.
//

import SwiftUI


struct PlayerCardMenuView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    @State var isPresented = false
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            LifeStockColor.darkBackground
                .edgesIgnoringSafeArea(.all)
                .opacity(0.8)
                .onTapGesture {
                    withAnimation {
                        viewModel.toggleView(.playerCardMenu)
                    }
                }
            
            
            VStack {
                BackButton(viewModel: viewModel)
                    .padding(.horizontal)
                    .frame(height: size.height / 10)
                
                VStack(spacing: 20) {
                    HStack(spacing: 20) {
                        ResetButton(viewModel: viewModel)
                        NamesButton(viewModel: viewModel)
                    }
                    .padding(.horizontal)
                    HStack(spacing: 20) {
                        HistoryButton(viewModel: viewModel)
                        SettingsButton(isPresented: $isPresented)
                    }
                    .padding(.horizontal)
                }
                .frame(width: size.width / 1.10, height: size.height / 3.5)
                
                HStack {
                    Spacer()
                    
                    VStack(spacing: -20) {
                        CheckBoxFor(
                            viewModel: viewModel,
                            title: "Commander Damage",
                            functionality: viewModel.toggleCommanderDamage,
                            enabled: viewModel.commanderDamageEnabled)
                            .frame(width: size.width / 1.2, height: size.height / 10)
                        
                        CheckBoxFor(
                            viewModel: viewModel,
                            title: "Player Names",
                            functionality: viewModel.togglePlayerNames,
                            enabled: viewModel.playerNamesEnabled)
                            .frame(width: size.width / 1.2, height: size.height / 10)
                    }
                    .padding(.top, 20)
                }
                MainMenuButton(viewModel: viewModel)
            }
            .foregroundColor(Color.white)
        }
        .sheet(isPresented: $isPresented) {
            SettingsScreenView(
                viewModel: SettingsScreenView.ViewModel(container: viewModel.container),
                isPresented: $isPresented)
        }
    }
}

extension PlayerCardMenuView {
    
    struct BackButton: View {
        
        @ObservedObject var viewModel: ViewModel
        
        var body: some View {
            GeometryReader { geometry in
                body(for: geometry.size)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
        }
        
        func body(for size: CGSize) -> some View {
            HStack(alignment: .top) {
                Spacer()
                
                Button(action: {
                    withAnimation {
                        viewModel.navigateToPlayerCardsViewFromMenu()
                    }
                }) {
                    Image(systemName: SFSymbols.xMark)
                        .font(Font.getFont(size: size, scalingFactor: 0.40))
                        .foregroundColor(Color.white)
                        .padding(.trailing)
                }
            }
        }
    }
}

extension PlayerCardMenuView {
    
    struct ResetButton: View {
        
        @ObservedObject var viewModel: ViewModel
        
        var body: some View {
            GeometryReader { geometry in
                body(for: geometry.size)
            }
        }
        
        func body(for size: CGSize) -> some View {
            GeometryReader { geometry in
                Button(action: {
                    withAnimation {
                        viewModel.resetGame()
                        viewModel.toggleView(.playerCardMenu)
                    }
                }) {
                    StandardButton(text: "Reset", size: size, scalingFactor: 0.35)
                }
            }
        }
    }
}

extension PlayerCardMenuView {
    
    struct NamesButton: View {
        
        @ObservedObject var viewModel: ViewModel
        
        var body: some View {
            GeometryReader { geometry in
                body(for: geometry.size)
            }
        }
        
        func body(for size: CGSize) -> some View {
            Button(action: {
                withAnimation {
                    viewModel.navigateToNamesView()
                }
            }) {
                StandardButton(text: "Names", size: size, scalingFactor: 0.35)
            }
        }
    }
}

extension PlayerCardMenuView {
    
    struct HistoryButton: View {
        
        @ObservedObject var viewModel: ViewModel
        
        var body: some View {
            GeometryReader { geometry in
                body(for: geometry.size)
            }
        }
        
        func body(for size: CGSize) -> some View {
            Button(action: {
                withAnimation {
                    viewModel.navigateToHistoryView()
                }
                
            }) {
                StandardButton(text: "History", size: size, scalingFactor: 0.35)
            }
        }
    }
}

extension PlayerCardMenuView {
    
    struct SettingsButton: View {
        
        @Binding var isPresented: Bool
        
        var body: some View {
            GeometryReader { geometry in
                body(for: geometry.size)
            }
        }
        
        func body(for size: CGSize) -> some View {
            Button(action: {
                isPresented = true
            }) {
                StandardButton(text: "Settings", size: size, scalingFactor: 0.35)
            }
        }
    }
}

extension PlayerCardMenuView {
    
    struct CheckBoxFor: View {
        
        @ObservedObject var viewModel: ViewModel
        
        var title: String
        var functionality: () -> ()
        var enabled: () -> Bool
        
        var body: some View {
            GeometryReader { geometry in
                body(for: geometry.size)
                    //.position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    .foregroundColor(Color.white)
            }
        }
        
        func body(for size: CGSize) -> some View {
            HStack(spacing: 20) {
                Button(action: {
                    withAnimation {
                        functionality()
                    }
                }) {
                    GeometryReader { checkbox in
                        ZStack {
                            Rectangle()
                                .stroke(lineWidth: 2)

                            if enabled() {
                                Image(systemName: SFSymbols.checkMark)
                                    .font(Font.getFont(size: checkbox.size, scalingFactor: 0.60))
                                    .foregroundColor(Color.white)
                            }
                        }
                    }
                }
                .frame(width: size.width / 14, height: size.width / 14)
                
                Text(title)
                    .font(Font.getFont(size: size, scalingFactor: 0.30))
                    .lineLimit(1)
                
                Spacer()
            }
        }
    }
}

extension PlayerCardMenuView {
    
    struct MainMenuButton: View {
        
        @ObservedObject var viewModel: ViewModel
        
        var body: some View {
            GeometryReader { geometry in
                body(for: geometry.size)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 4)
            }
        }
        
        func body(for size: CGSize) -> some View {
            GeometryReader { geometry in
                Button(action: {
                    withAnimation {
                        viewModel.navigateToAreYouSureView()
                    }
                }) {
                    StandardButton(text: "Main Menu", size: geometry.size, scalingFactor: 0.40)
                }
            }
            .frame(width: size.width / 2, height: size.height / 3)
        }
    }
}
