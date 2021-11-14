//
//  FavoriteClubsSelector.swift
//  MOCK-HackUTDVIII
//
//  Created by Jake Spann on 11/13/21.
//

import SwiftUI

struct FavoriteClubsSelector: View {
    @AppStorage("didRunSetup") var didSetUp: Bool = false
    var selectedCategories: [String]
    @EnvironmentObject var organizationsController: OrganizationsController
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Select your favorite clubs")
                .font(.system(size: 50))
                .fontWeight(.bold)
                .padding([.bottom, .leading, .trailing])
                .navigationBarBackButtonHidden(true)
            List() {
                ForEach(selectedCategories, id: \.self) {category in
                    Section(category) {
                        ForEach($organizationsController.organizations, id:
                                    \.uri) {$organization in
                            if organization.categories.contains(category) {
                                CondensedClubView(club: $organization)
                                .onTapGesture(perform: {
                                    organization.isFavorite = true
                                })
                            }
                        }
                        }
                    }
                }
           }
            .contentShape(Rectangle())
            Button(action: {
                didSetUp = true
                
            }) {
                Text("Done")
                    .font(.system(size: 25))
                    .frame(minWidth: 150)
            }
            .buttonStyle(.borderedProminent)
            .cornerRadius(20)
            .padding(.bottom)
        }
    }

struct CondensedClubView: View {
    @Binding var club: Organization
    
    var body: some View {
        HStack {
            Text(club.name)
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
        
            Spacer()
            Image(systemName: (club.isFavorite ?? false) ? "star.fill" : "star")
        }
    }
}

struct FavoriteClubsSelector_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteClubsSelector(selectedCategories: [])
    }
}
