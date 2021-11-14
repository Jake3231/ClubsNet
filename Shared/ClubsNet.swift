//
//  MOCK_HackUTDVIIIApp.swift
//  Shared
//
//  Created by Jake Spann on 11/13/21.
//

import SwiftUI

@main
struct ClubsNet: App {
    @StateObject var networkController = OrganizationsController()
    @AppStorage("didRunSetup") var didSetUp: Bool = false
    @State var setupStage: SetupStage = .welcome
    @State var selectedCategories: [String] = []
    
    var body: some Scene {
        WindowGroup {
            if didSetUp {
                MainView()
                    .environmentObject(networkController)
            } else {
                switch setupStage {
                case .welcome:
                    SetupWelcome(didSetUp: $didSetUp, setupStage: $setupStage)
                        .environmentObject(networkController)
                case .userTypeSelector:
                    UserTypeSelectorView(didSetup: $didSetUp, setupStage: $setupStage)
                        .environmentObject(networkController)
                case .categorySelector:
                    CategoriesSelector(SelectedCategories: $selectedCategories, didSetup: $didSetUp, setupStage: $setupStage)
                        .environmentObject(networkController)
                case .favoriteClubsSelector:
                    FavoriteClubsSelector(selectedCategories: selectedCategories)
                        .environmentObject(networkController)
                    
            }
        }
    }
}
}

enum SetupStage {
    case welcome
    case userTypeSelector
    case categorySelector
    case favoriteClubsSelector
}
