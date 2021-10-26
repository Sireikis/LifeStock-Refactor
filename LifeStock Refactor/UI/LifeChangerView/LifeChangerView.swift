//
//  LifeChangerView.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/20/21.
//

import SwiftUI


struct LifeChangerView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    let buttons: [[CalculatorButton]] = [
        [.ac, .one, .four, .seven],
        [.zero, .two, .five, .eight],
        [.delete, .three, .six, .nine]
    ]
    
    init(viewModel: ViewModel) {
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


/*
 Reused by CalculatorView
 -Code smell, LifeChangerView and CalculatorView could be made generic
 */
struct ButtonView: View {
    
    @ObservedObject var viewModel: LifeChangerView.ViewModel
    
    var button: CalculatorButton
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        Button(action: {
            viewModel.receiveInput(from: button)
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: RoundedCornerStyle.continuous)
                    .foregroundColor(button.backgroundColor)
                Text(button.title)
                    .font(Font.getFont(size: size, scalingFactor: 0.70))
                    .foregroundColor(Color.white)
                    .rotationEffect(.degrees(90))
            }
        }
    }
}

struct InputView: View {
    
    @ObservedObject var viewModel: LifeChangerView.ViewModel
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            Text(viewModel.displayField)
                .font(Font.getFont(size: size, scalingFactor: 0.90))
                .foregroundColor(.white)
                .lineLimit(1)
            // Stops the numbers from easing in and out when changed
                .id(UUID())
                .transition(.identity)
                .frame(width: size.height, height: size.width)
            
        }
        .rotationEffect(.degrees(90))
        .frame(width: size.width, height: size.height)
    }
}

extension LifeChangerView {
    
    struct MenuBar: View {
        
        @ObservedObject var viewModel: ViewModel
        
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
                        viewModel.updatePlayerLife()
                        withAnimation {
                            viewModel.navigateToPlayerCardsView()
                        }
                    }) {
                        Image(systemName: SFSymbols.checkMark)
                            .font(Font.getFont(size: size, scalingFactor: 0.40))
                            .foregroundColor(Color.white)
                            .padding()
                            .rotationEffect(.degrees(90))
                    }
                }
                
                GeometryReader { inner in
                    ZStack {
                        Rectangle().hidden()
                        Text(viewModel.lifeTotalForSelectedPlayer())
                            .font(Font.getFont(size: size, scalingFactor: 0.40))
                            .foregroundColor(Color.white)
                            .lineLimit(1)
                            // When transitioning back to playercard view the previous lifetotal indicator will
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
                            viewModel.navigateToCalculatorView()
                        }
                    }) {
                        Text("Calc")
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
