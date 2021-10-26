//
//  Constants.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/4/21.
//

import SwiftUI
import UIKit

enum LifeStockColor {
    
    private static let lightGrey: Double = 50/255
    private static let darkGrey: Double = 30/255
 
    static let lightBackground = Color(red: lightGrey, green: lightGrey, blue: lightGrey)
    static let darkBackground = Color(red: darkGrey, green: darkGrey, blue: darkGrey)
    
    static let blueViolet = Color(red: 121/255, green: 43/255, blue: 255/255)
    static let darkGreen = Color(red: 0, green: 102/255, blue: 0)
    static let goldenBrown = Color(red: 153/255, green: 102/255, blue: 0)
    static let jungleGreen = Color(red: 45/255, green: 155/255, blue: 140/255)
    
    static let blue = Color.blue
    static let gray = Color.gray
    static let green = Color.green
    static let orange = Color.orange
    static let pink = Color.pink
    static let purple = Color.purple
    static let red = Color.red
    
    static let topColorBar: [Color] = [darkBackground, red, blue, green, jungleGreen, gray]
    static let botColorBar: [Color] = [purple, orange, goldenBrown, pink, blueViolet, darkGreen]
}

enum ScreenSize {
    
    static let size = UIScreen.main.bounds.size
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
}

enum SFSymbols {
    
    static let checkMark = "checkmark"
    static let xMark = "xmark"
    static let leftChevron = "chevron.left"
    static let rightChevron = "chevron.right"
    
    static let crown = "crown"
    static let gear = "gear"
    static let Aa = "textformat"
    static let counters = "minus.slash.plus"
    
    static let submitFeedback = "message.fill"
    static let writeReview = "star.fill"
    static let aboutMe = "person.fill"
    static let tipJar = "heart.fill"
    
    static let commanderTax = "shield"
    static let storm = "cloud.bolt"
    static let experience = "star"
    static let energy = "bolt"
}

enum LifeStockURLs {
    
    static let review = "https://apps.apple.com/app/id1542466908?action=write-review"
}

