//
//  LifeStock_RefactorApp.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/4/21.
//

import SwiftUI

@main
struct LifeStock_RefactorApp: App {
    
    @Environment(\.scenePhase) private var scenePhase
    
    private let environment = AppEnvironment.bootstrap()
    
    var screenStaysOn: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ParentView(
                viewRouter: environment.container.appState.routing,
                container: environment.container,
                storeManager: environment.container.services.storeManagerService as! RealStoreManagerService)
                .statusBar(hidden: true)
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                if environment.container.services.gameStateService.screenStaysOn {
                    UIApplication.shared.isIdleTimerDisabled = true
                }
            default:
                UIApplication.shared.isIdleTimerDisabled = false
            }
        }
    }
}
