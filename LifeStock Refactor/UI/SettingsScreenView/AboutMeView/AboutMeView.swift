//
//  AboutMeView.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/5/21.
//

import SwiftUI


extension SettingsScreenView {
    
    struct AboutMeView: View {
        
        var body: some View {
            Form {
                Section(header: Text("IOS Development and Design")) {
                    VStack(alignment: .leading) {
                        Text("Ignas Sireikis")
                            .font(.title)
                        
                        Text("Developer of iOS software with aspirations to create apps that facilitate more than just playing cards--start small, think big. Interested in the life sciences, technology, and an avid player of EDH.")
                            .font(.body)
                    }
                }
            }
            .navigationBarTitle("About Me", displayMode: .inline)
        }
    }
}


struct AboutMeView_Previews: PreviewProvider {
    
    static var previews: some View {
        SettingsScreenView.AboutMeView()
    }
}
