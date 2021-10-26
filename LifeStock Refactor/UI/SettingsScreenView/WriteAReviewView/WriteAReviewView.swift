//
//  WriteAReviewView.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/5/21.
//

import SwiftUI


extension SettingsScreenView {
    
    struct WriteAReviewView: View {

        var url: URL {
            guard let writeReviewURL = URL(string: LifeStockURLs.review)
            else {
                // !!! TODO: Handle Error with alert
                fatalError("Expected a valid URL")
            }
            return writeReviewURL
        }
        
        var body: some View {
            HStack {
                SettingsButton(description: "", image: SFSymbols.writeReview, backgroundColor: .yellow)
                Link("Write A Review", destination: url)
                Spacer()
                Image(systemName: SFSymbols.rightChevron)
                    .foregroundColor(.black)
            }
        }
    }
}


struct WriteAReviewView_Previews: PreviewProvider {
    
    static var previews: some View {
        SettingsScreenView.WriteAReviewView()
    }
}
