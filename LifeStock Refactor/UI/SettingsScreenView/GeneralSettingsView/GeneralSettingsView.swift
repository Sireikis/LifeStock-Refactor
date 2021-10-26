//
//  GeneralSettingsView.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/5/21.
//

import Combine
import SwiftUI


extension SettingsScreenView {
    
    struct GeneralSettingsView: View {
        
        @AppStorage("customLifeEnabled") var customLifeEnabled = false
        @State var isEditing = false
        
        var body: some View {
            Form {
                Section(
                    header: Text("Default Settings"),
                    footer: Text("Sets default settings for all players. These settings supercede individual settings.")
                ) {
                    CommanderDamage()
                    PlayerNames()
                }
                
                Section(header: Text("Number of Starting Players")) {
                    StartingPlayersPicker()
                }
                
                Section(header: Text("Starting Lifetotals")) {
                    VStack {
                        CustomLife(customLifeEnabled: $customLifeEnabled, isEditing: $isEditing)
                        
                        if !customLifeEnabled {
                            StartingLifePicker()
                        } else {
                            CustomLifeTextField(isEditing: $isEditing)
                        }
                    }
                }
                
                Section {
                    ScreenStaysOn()
                }
            }
            .navigationBarTitle("Default Settings", displayMode: .inline)
        }
    }
}

extension SettingsScreenView.GeneralSettingsView {
    
    private struct CommanderDamage: View {
        
        @AppStorage("commanderDamageEnabled") var commanderDamageEnabled = true
        
        var body: some View {
            HStack {
                SettingsButton(description: "Commander Damage", image: SFSymbols.crown)
                    .layoutPriority(1)
                Toggle(isOn: $commanderDamageEnabled) { }
            }
        }
    }
    
    private struct PlayerNames: View {
        
        @AppStorage("playerNamesEnabled") var playerNamesEnabled = true
        
        var body: some View {
            HStack {
                SettingsButton(description: "Player Names", image: SFSymbols.Aa)
                    .layoutPriority(1)
                Toggle(isOn: $playerNamesEnabled) { }
            }
        }
    }
    
    private struct StartingPlayersPicker: View {
        
        @AppStorage("startingPlayersCount") var startingPlayersCount = 4
        
        var body: some View {
            VStack {
                Picker(selection: $startingPlayersCount, label: Text("Starting Players")) {
                    ForEach(1..<5, id: \.self) { player in
                        Text("\(player)")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
    }
    
    private struct CustomLife: View {
        
        @Binding var customLifeEnabled: Bool
        @Binding var isEditing: Bool
        
        var body: some View {
            HStack {
                Text("Custom Life")
                Spacer()
                Toggle("Custom Life", isOn: $customLifeEnabled)
                    .labelsHidden()
                    .onReceive(
                        Just(customLifeEnabled)) { newValue in
                            if !newValue {
                                isEditing = false
                            }
                        }
            }
        }
    }
    
    private struct StartingLifePicker: View {
        
        @AppStorage("playerLife") var playerLife = 40
        
        var body: some View {
            Picker(selection: $playerLife, label: Text("Starting Lifetotals")) {
                ForEach([20,30,40], id: \.self) { lifetotal in
                    Text("\(lifetotal)")
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
    
    private struct CustomLifeTextField: View {
        
        @AppStorage("customLife") var customLife = "50"
        @Binding var isEditing: Bool
        
        var body: some View {
            HStack {
                TextField(
                    "",
                    text: $customLife,
                    onEditingChanged: {
                        _ in
                        isEditing = true
                    }
                )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .onReceive(
                        Just(customLife)) { newValue in
                            let filtered = newValue.filter { "012345678".contains($0) }
                            if filtered != newValue {
                                customLife = filtered
                            }
                        }
                
                Button(action: {
                    hideKeyboard()
                    isEditing = false
                }) {
                    Text("Submit")
                        .foregroundColor(isEditing ? Color.blue : Color.gray)
                }
                .buttonStyle(BorderlessButtonStyle())
            }
        }
    }
    
    private struct ScreenStaysOn: View {
        
        @AppStorage("screenStaysOn") var screenStaysOn = true
        
        var body: some View {
            HStack {
                Text("Screen Stays On")
                Spacer()
                Toggle("Screen Stays On", isOn: $screenStaysOn)
                    .labelsHidden()
                    .onReceive(
                        Just(screenStaysOn)) { newValue in
                            UIApplication.shared.isIdleTimerDisabled = newValue ? true : false
                        }
            }
        }
    }
}


struct GeneralSettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        SettingsScreenView.GeneralSettingsView()
    }
}
