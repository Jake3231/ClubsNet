//
//  SetupWelcome.swift
//  MOCK-HackUTDVIII
//
//  Created by Jake Spann on 11/13/21.
//

import SwiftUI

struct SetupWelcome: View {
    @EnvironmentObject var comms: OrganizationsController
    @Binding var didSetUp: Bool
    
    var body: some View {
        NavigationView {
        VStack {
        Text("Clubs Net")
            .fontWeight(.bold)
            .font(.system(size: 34))
            NavigationLink(destination: UserTypeSelectorView(didSetup: $didSetUp)) {
       Text("Start")
                    .frame(minWidth: 100)
            }
            .buttonStyle(.borderedProminent)
            .cornerRadius(20)
        }
    }
        .onAppear() {
            comms.fetchClubs(nil)
        }
    }
}

struct SetupWelcome_Previews: PreviewProvider {
    static var previews: some View {
        SetupWelcome(didSetUp: .constant(false))
    }
}
