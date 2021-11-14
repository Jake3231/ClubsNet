//
//  FavoriteClubsSelector.swift
//  MOCK-HackUTDVIII
//
//  Created by Jake Spann on 11/13/21.
//

import SwiftUI

struct FavoriteClubsSelector: View {
    @AppStorage("didRunSetup") var didSetUp: Bool = false
    @AppStorage("favoriteClubs") var favoriteClubs: Data?
    @Binding var selectedCategories: [String]
    @EnvironmentObject var organizationsController: OrganizationsController
    
    @State var selectedClubs: [String] = []
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Select your favorite clubs")
                .font(.system(size: 50))
                .fontWeight(.bold)
                .padding()
                .navigationBarBackButtonHidden(true)
            Spacer()
            List() {
                ForEach($selectedCategories, id: \.self) {category in
                    Section(category.wrappedValue) {
                        ForEach(organizationsController.getOrganizationsFor(category: category.wrappedValue), id:
                                    \.name) {organization in
                            CondensedClubView(club: organization)
                                .onTapGesture(perform: {
                                    if selectedClubs.contains(organization.uri) {
                                        selectedClubs.removeAll(where: {$0 == organization.uri})
                                    } else {
                                        selectedClubs.append(organization.uri)
                                    }
                                })
                        }
                    }
                }
            }
            .contentShape(Rectangle())
            .frame(minHeight: 400)
            Button(action: {
                for club in selectedClubs {
                    print("FAVORITING CLUB")
                    organizationsController.favorite(organization: club)
                }
                didSetUp = true
                
            }) {
                Text("Done")
                    .font(.system(size: 25))
                    .frame(minWidth: 150)
            }
            .buttonStyle(.borderedProminent)
            .cornerRadius(20)
            .padding(.bottom, 300)
        }
    }
}

struct CondensedClubView: View {
    var club: Organization
    @State var isSelected: Bool = false
    
    var body: some View {
        HStack {
            Text(club.name)
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
                /*.onTapGesture {
                    isSelected.toggle()
                }*/
        
            Spacer()
            
        if isSelected {
            Image(systemName: "star.fill")
               
        } else {
            Image(systemName: "star")
        }
             
        }
    }
}

struct FavoriteClubsSelector_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteClubsSelector(selectedCategories: .constant([]))
    }
}
