//
//  SettingsScreenView.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/5/21.
//

import SwiftUI
import MessageUI


struct SettingsScreenView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    @Binding var isPresented: Bool
    
    @State var isShowingMailView = false
    @State var mailError = false
    @State var result: Result<MFMailComposeResult, Error>? = nil
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("General")) {
                    NavigationLink(destination: GeneralSettingsView()) {
                        SettingsButton(
                            description: "General",
                            image: SFSymbols.gear,
                            backgroundColor: LifeStockColor.gray)
                    }
                    
                    NavigationLink(destination: CounterSettingsView()) {
                        SettingsButton(
                            description: "Default Counters",
                            image: SFSymbols.counters,
                            backgroundColor: .clear,
                            foregroundColor: .black)
                    }
                }
                
                Section(header: Text("Contact")) {
                    SubmitFeedbackLink(isShowingMailView: $isShowingMailView, mailError: $mailError)
                    WriteAReviewLink()
                    AboutMeLink()
                    
                    ZStack {
                        ContactSectionButton(description: "Tip Jar", image: SFSymbols.tipJar, backgroundColor: .pink)
                        NavigationLink(destination: TipJar(viewModel: viewModel)) {
                            EmptyView()
                        }
                    }
                }
                
                Section(header: Text("Tips")) {
                    Tips()
                }
            }
            .navigationBarItems(trailing: backButton())
            .navigationBarTitle("Settings", displayMode: .inline)
        }
        .sheet(isPresented: $isShowingMailView) {
            MailView(result: $result)
        }
        .alert(isPresented: $mailError) {
            Alert(
                title: Text("Error"),
                message: Text("Can't send emails from this device. You must link an email account to the mail app."),
                dismissButton: .default(Text("Got it!"))
            )
        }
        .onDisappear {
            viewModel.set(.commanderDamageEnabled, to: viewModel.commanderDamageEnabled)
            viewModel.set(.namesEnabled, to: viewModel.playerNamesEnabled)
        }
    }
    
    private func backButton() -> some View {
        Button(action: {
            isPresented = false
        }) {
            Text("Done")
        }
    }
}

extension SettingsScreenView {
    
    private struct SubmitFeedbackLink: View {
        
        @Binding var isShowingMailView: Bool
        @Binding var mailError: Bool
        
        var body: some View {
            Button(action: {
                MFMailComposeViewController.canSendMail() ? isShowingMailView.toggle() : mailError.toggle()
            }) {
                ContactSectionButton(
                    description: "Submit Feedback",
                    image: SFSymbols.submitFeedback,
                    backgroundColor: .green)
            }
        }
    }
    
    private struct WriteAReviewLink: View {
        
        var url: URL {
            guard let writeReviewURL = URL(string: "https://apps.apple.com/app/id1542466908?action=write-review")
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
    
    private struct AboutMeLink: View {
        
        var body: some View {
            ZStack {
                ContactSectionButton(
                    description: "About Me",
                    image: SFSymbols.aboutMe,
                    backgroundColor: .blue)
                
                NavigationLink(destination: AboutMeView()) {
                    EmptyView()
                }
            }
        }
    }
    
    private struct Tips: View {
        
        var body: some View {
            Text("Tap to the left or right of your life total to adjust it.")
            Text("Tap your life total to input a custom life value and access the calculator.")
            Text("Tap your name to access individual player settings--like color and display options.")
            Text("Tap your commander damage display to alter counter and commander damage settings.")
            Text("In Settings you can set custom launch options that will be remembered.")
        }
    }
}


struct SettingsScreenView_Previews: PreviewProvider {

    @State static var isPresented = true

    static var previews: some View {

        SettingsScreenView(viewModel: SettingsScreenView.ViewModel(container: .preview), isPresented: $isPresented)
    }
}
