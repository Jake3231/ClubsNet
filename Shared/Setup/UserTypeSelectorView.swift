//
//  UserTypeSelectorView.swift
//  MOCK-HackUTDVIII
//
//  Created by Jake Spann on 11/13/21.
//

import SwiftUI

struct UserTypeSelectorView: View {
    @Binding var didSetup: Bool
    @EnvironmentObject var comms: OrganizationsController
    @Binding var setupStage: SetupStage
    
    var body: some View {
        VStack {
            Text("Are you a student or club officer?")
                .font(.system(size: 40))
                .fontWeight(.bold)
                .padding()
            //NavigationLink(destination: CategoriesSelector(didSetup: $didSetup)) {
            Button("Student") {
                withAnimation() {
                    setupStage = .categorySelector
                }
            }
                    .font(.system(size: 25))
                    .frame(minWidth: 150)
           // }
            .buttonStyle(.borderedProminent)
            .cornerRadius(20)
            Button(action: {didSetup = true}) {
                Text("Club Officer")
                    .font(.system(size: 25))
                    .frame(minWidth: 150)
            }
            .buttonStyle(.borderedProminent)
            .cornerRadius(20)
            .padding(.bottom, 300)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct UserTypeSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        UserTypeSelectorView(didSetup: .constant(false), setupStage: .constant(.userTypeSelector))
    }
}
