//
//  AreYouSureView.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/25/21.
//

import SwiftUI


extension PlayerCardMenuView {
    
    struct AreYouSureView: View {
        
        @ObservedObject var viewModel: ViewModel
        
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
                            viewModel.toggleView(.areYouSure)
                        }
                    }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.black)
                        .frame(width: size.width / 1.5, height: size.height / 3)
                    
                    GeometryReader { geometry in
                        VStack(alignment: .center, spacing: 10) {
                            ReminderText()
                            HStack(spacing: 0) {
                                Button(action: {
                                    withAnimation {
                                        viewModel.toggleView(.areYouSure)
                                    }
                                }) {
                                    StandardButton(text: "Cancel", size: size, scalingFactor: 0.20)
                                }
                                .padding()
                                
                                ExitButton(viewModel: viewModel)
                            }
                            .frame(height: geometry.size.height / 2)
                        }
                    }
                    .frame(width: size.width / 1.5, height: size.height / 3)
                }
            }
            .foregroundColor(Color.white)
        }
    }
}

extension PlayerCardMenuView.AreYouSureView {
    
    struct ReminderText: View {
        
        var topMessage: String = "Are you sure?"
        var bottomMessage: String = "This will exit the game."
        
        var body: some View {
            GeometryReader { geometry in
                body(for: geometry.size)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
        }
        
        func body(for size: CGSize) -> some View {
            VStack {
                Text(topMessage)
                    .font(Font.getFont(size: size, scalingFactor: 0.20))
                Text(bottomMessage)
                    .font(Font.getFont(size: size, scalingFactor: 0.20))
            }
        }
    }
}

extension PlayerCardMenuView.AreYouSureView {
    
    struct ExitButton: View {
        
        @ObservedObject var viewModel: PlayerCardMenuView.ViewModel
        
        @State var resetGame: Bool = false
        
        var body: some View {
            GeometryReader { geometry in
                body(for: geometry.size).onDisappear {
                    if resetGame {
                        viewModel.resetGame()
                        viewModel.resetViewRouter()
                    }
                }
            }
        }
        
        func body(for size: CGSize) -> some View {
            Button(action: {
                withAnimation {
                    viewModel.navigateToStartScreenView()
                    resetGame = true
                }
            }) {
                StandardButton(text: "Exit", size: size, scalingFactor: 0.20)
            }
            .padding()
        }
    }
}
