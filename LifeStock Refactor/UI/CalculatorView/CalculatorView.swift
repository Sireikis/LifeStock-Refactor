//
//  CalculatorView.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/21/21.
//

import SwiftUI


struct CalculatorView: View {
    
    @ObservedObject var viewModel: LifeChangerView.ViewModel
    
    let buttons: [[CalculatorButton]] = [
        [.ac, .one, .four, .seven],
        [.zero, .two, .five, .eight],
        [.delete, .three, .six, .nine],
        [.equals, .plus, .minus, .multiply]
    ]
    
    init(viewModel: LifeChangerView.ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            LifeStockColor.darkBackground.edgesIgnoringSafeArea(.all)
            
            HStack {
                VStack {
                    ForEach(buttons, id: \.self) { row in
                        HStack {
                            ForEach(row, id: \.self) { button in
                                ButtonView(
                                    viewModel: viewModel,
                                    button: button)
                            }
                        }
                    }
                }
                .padding(.vertical, 10)
                .padding(.leading)
                
                InputView(viewModel: viewModel)
                    .frame(width: size.width / 5)
                MenuBar(viewModel: viewModel)
                    .frame(width: size.width / 6)
            }
        }
    }
}

extension CalculatorView {
    
    struct MenuBar: View {
        
        @ObservedObject var viewModel: LifeChangerView.ViewModel
        
        var body: some View {
            GeometryReader { geometry in
                body(for: geometry.size)
            }
        }
        
        func body(for size: CGSize) -> some View {
            VStack {
                ZStack(alignment: .top) {
                    Rectangle().hidden()
                    
                    Button(action: {
                        withAnimation {
                            viewModel.navigateToLifeChangerView()
                        }
                        viewModel.resetCalculatorVariables()
                    }) {
                        Image(systemName: SFSymbols.leftChevron)
                            .font(Font.getFont(size: size, scalingFactor: 0.40))
                            .foregroundColor(Color.white)
                            .padding()
                            .rotationEffect(.degrees(90))
                    }
                }
                
                GeometryReader { inner in
                    ZStack {
                        Rectangle().hidden()
                        Text(String(viewModel.lifeTotalForSelectedPlayer()))
                            .font(Font.getFont(size: size, scalingFactor: 0.40))
                            .foregroundColor(Color.white)
                            .lineLimit(1)
                            // When transitioning back to playercard view the prev liftotal display will
                            // pop out. This stops it when transitioning from a low number to a higher number
                            // but not a high number to low number.
                            .animation(.easeInOut(duration: 1.0), value: 0)
                            .frame(width: inner.size.height, height: inner.size.width)
                    }
                    .rotationEffect(.degrees(90))
                    .frame(width: size.width, height: size.height)
                    .position(x: inner.size.width / 2, y: inner.size.height / 2)
                }
                
                ZStack(alignment: .bottom) {
                    Rectangle().hidden()
                    
                    Button(action: {
                        withAnimation {
                            viewModel.navigateToPlayerCardsViewFromCalc()
                        }
                        viewModel.updatePlayerLife()
                        viewModel.resetCalculatorVariables()
                    }) {
                        Image(systemName: SFSymbols.checkMark)
                            .font(Font.getFont(size: size, scalingFactor: 0.40))
                            .foregroundColor(Color.white)
                    }
                    .rotationEffect(.degrees(90))
                }
                .padding(.bottom)
            }
        }
    }
}
