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
    
    var body: some Scene {
        WindowGroup {
            if didSetUp {
                ContentView()
                    .environmentObject(networkController)
            } else {
                SetupWelcome(didSetUp: $didSetUp)
                    .environmentObject(networkController)
            }
        }
    }
}
