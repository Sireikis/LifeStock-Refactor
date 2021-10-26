//
//  ButtonStyles.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/4/21.
//

import SwiftUI


private struct WhiteBorderButtonStyle: View {
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10, style: .continuous)
            .stroke(lineWidth: 4)
            .foregroundColor(Color.white)
    }
}

struct StandardButton: View {
    
    enum Constants {
        
        static let buttonScalingFactor: CGFloat = 0.45
    }
    
    let text: String
    let size: CGSize
    let scalingFactor: CGFloat
    
    init(text: String, size: CGSize = ScreenSize.size, scalingFactor: CGFloat = Constants.buttonScalingFactor) {
        self.text = text
        self.size = size
        self.scalingFactor = scalingFactor
    }
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .foregroundColor(Color.black)
            Text(text)
                .font(Font.getFont(size: size, scalingFactor: scalingFactor))
                .foregroundColor(.white)
        }
        .background(WhiteBorderButtonStyle())
    }
}

struct SettingsButton: View {
    
    var description: String
    var image: String
    var backgroundColor: Color
    var foregroundColor: Color = .white
    
    var body: some View {
        HStack {
            Image(systemName: image)
                .frame(width: 25, height: 25)
                .foregroundColor(foregroundColor)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 5))
            Text(description)
        }
    }
}

extension SettingsButton {
    
    /// White background, image is black.
    init(description: String, image: String) {
        self.init(description: description, image: image, backgroundColor: .white, foregroundColor: .black)
    }
}

struct ContactSectionButton: View {
    
    var description: String
    var image: String
    var backgroundColor: Color
    
    var body: some View {
        HStack {
            SettingsButton(description: "", image: image, backgroundColor: backgroundColor, foregroundColor: .white)
            Text(description)
                .foregroundColor(.blue)
            Spacer()
            Image(systemName: SFSymbols.rightChevron)
                .foregroundColor(.black)
        }
    }
}
