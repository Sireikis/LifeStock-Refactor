//
//  StartScreenView.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/4/21.
//

import SwiftUI


struct StartScreenView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    @State var isPresented: Bool = false
    
    var body: some View {
        ZStack {
            LifeStockColor.darkBackground.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Life Stock")
                    .font(Font.getFont(size: ScreenSize.size, scalingFactor: Constants.titleScalingFactor))
                    .lineLimit(1)
                    .shadow(color: .black, radius: 5, x: 5, y: 5)
                    .foregroundColor(.white)
                
                Group {
                    Button(action: {
                        withAnimation {
                            viewModel.navigateToChoosePlayersView()
                        }
                    }) {
                        StandardButton(text: "Start")
                            .frame(width: ScreenSize.width / 2, height: ScreenSize.height / 8)
                    }
                    
                    Button(action: {
                        isPresented = true
                    }) {
                        StandardButton(text: "Settings")
                            .frame(width: ScreenSize.width / 2, height: ScreenSize.height / 8)
                    }
                }
                .offset(y: ScreenSize.height / Constants.yOffset)
            }
        }
        .sheet(isPresented: $isPresented) {
            SettingsScreenView(
                viewModel: SettingsScreenView.ViewModel(container: viewModel.container),
                isPresented: $isPresented)
        }
        .onAppear {
            // Only run the first time the app is launched
            if !viewModel.performedFirstTimeStartUp {
                // Set PersistentData values to proper initial values
                viewModel.performFirstTimeStartUp()
            }
        }
    }
}

extension StartScreenView {
    
    enum Constants {
        
        static let titleScalingFactor: CGFloat = 0.15
        static let yOffset: CGFloat = 6
    }
}

// MARK: - Preview

struct StartScreenView_Previews: PreviewProvider {
    
    static var previews: some View {
        StartScreenView(viewModel: .init(container: .preview))
    }
}
