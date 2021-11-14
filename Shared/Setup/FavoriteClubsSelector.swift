//
//  FavoriteClubsSelector.swift
//  MOCK-HackUTDVIII
//
//  Created by Jake Spann on 11/13/21.
//

import SwiftUI

struct FavoriteClubsSelector: View {
    @AppStorage("didRunSetup") var didSetUp: Bool = false
    //@AppStorage("favoriteClubs") var favoriteClubs: Data?
    @Binding var selectedCategories: [String]
    @EnvironmentObject var organizationsController: OrganizationsController
    
   // @State var selectedClubs: [String] = []
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Select your favorite clubs")
                .font(.system(size: 50))
                .fontWeight(.bold)
                .padding([.bottom, .leading, .trailing])
                .navigationBarBackButtonHidden(true)
            //Spacer()
            List() {
                ForEach($selectedCategories, id: \.self) {$category in
                    Section(category) {
                        ForEach($organizationsController.organizations, id:
                                    \.uri) {$organization in
                            if organization.categories.contains(category) {
                                CondensedClubView(club: $organization)
                                .onTapGesture(perform: {
                                    //organization.isFavorite = true
                                })
                            }
                        }
                        }
                    }
                }
            //.frame(minHeight: 500)
           }
            .contentShape(Rectangle())
       // Spacer()
            Button(action: {
                /*for club in selectedClubs {
                    print("FAVORITING CLUB")
                    //organizationsController.favorite(organization: club)
                }*/
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
    @State var isSelected: Bool = false
    
    var body: some View {
        HStack {
            Text(club.name)
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
        
            Spacer()
            Image(systemName: isSelected ? "star.fill" : "star")
        }
    }
}

struct FavoriteClubsSelector_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteClubsSelector(selectedCategories: .constant([]))
    }
}
