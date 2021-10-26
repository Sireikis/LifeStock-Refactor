//
//  DependencyInjector.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/12/21.
//

import SwiftUI


//struct DIContainer: EnvironmentKey {
struct DIContainer {
    
    let appState: AppState
    let services: Services

//    static var defaultValue: Self { Self.default }
//
//    private static let `default` = Self(appState: AppState(), services: .stub)
}

//extension EnvironmentValues {
//
//    var injected: DIContainer {
//        get { self[DIContainer.self] }
//        set { self[DIContainer.self] = newValue }
//    }
//}

#if DEBUG
extension DIContainer {
    static var preview: Self {
        .init(appState: AppState.preview, services: .stub)
    }
}
#endif

// MARK: - Injection in the view hierarchy

//extension View {
//
//    func inject(
//        _ appState: AppState,
//        _ interactors: DIContainer.Interactors
//    ) -> some View {
//        let container = DIContainer(appState: .init(appState),
//                                    interactors: interactors)
//        return inject(container)
//    }
//
//    func inject(_ container: DIContainer) -> some View {
//        return self
//            .modifier(RootViewAppearance())
//            .environment(\.injected, container)
//    }
//}
