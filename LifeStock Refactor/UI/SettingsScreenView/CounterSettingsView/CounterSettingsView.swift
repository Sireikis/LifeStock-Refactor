//
//  CounterSettingsView.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/5/21.
//

import SwiftUI

extension SettingsScreenView {
    
    struct CounterSettingsView: View {
        
        @AppStorage("commanderTax") var commanderTax = false
        @AppStorage("storm") var storm = false
        @AppStorage("experience") var experience = false
        @AppStorage("energy") var energy = false
        
        var body: some View {
            Form {
                Section(header: Text("Default Counters"), footer: Text("Each Player will start with these counters.")) {
                    HStack {
                        SettingsButton(description: "Commander Tax", image: SFSymbols.commanderTax)
                            .layoutPriority(1)
                        Toggle(isOn: $commanderTax) { }
                    }
                    HStack {
                        SettingsButton(description: "Storm", image: SFSymbols.storm)
                        Toggle(isOn: $storm) { }
                    }
                    HStack {
                        SettingsButton(description: "Experience", image: SFSymbols.experience)
                        Toggle(isOn: $experience) { }
                    }
                    HStack {
                        SettingsButton(description: "Energy", image: SFSymbols.energy)
                        Toggle(isOn: $energy) { }
                    }
                }
            }
            .navigationBarTitle("Default Counters", displayMode: .inline)
        }
    }
}


struct CounterSettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        SettingsScreenView.CounterSettingsView()
    }
}
