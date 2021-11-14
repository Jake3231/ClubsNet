//
//  ClubView.swift
//  MOCK-HackUTDVIII
//
//  Created by Jake Spann on 11/13/21.
//

import SwiftUI

struct ClubView: View {
    @EnvironmentObject var clubsController: OrganizationsController
    @Binding var club: Organization
    
    var body: some View {
        VStack {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                GroupBox {
                    VStack(alignment: .leading) {
                        Label("\(String(club.memberCount ?? 0)) members", systemImage: "person")
                        Label(club.regularMeetingLocation ?? "No regular location", systemImage: "mappin")
                    }
                }
               // Spacer()
            }
            Spacer()
        }
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    GroupBox("Contact") {
                        VStack(alignment: .leading) {
                            HStack {
                                Image("facebook").resizable()
                                    .frame(maxWidth: 20, maxHeight: 20)
                                Text(club.facebook ?? "None")
                                Spacer()
                            }
                            
                            HStack {
                                Image("twitter").resizable()
                                    .frame(maxWidth: 20, maxHeight: 20)
                                Text(club.twitter ?? "Twitter")
                                Spacer()
                            }
                        }
                    }
                }
                Spacer()
            }
            WebView(text: club.description ?? "")
            Spacer()
        }
        .onAppear(perform: {clubsController.getAdvancedDataFor(organization: club.uri)})
        .padding()
        .navigationTitle(club.name)
        .toolbar() {
            ToolbarItem {
                Button(action: {
                    if club.isFavorite == nil {
                        club.isFavorite = true
                    } else {
                        club.isFavorite?.toggle()
                    }
                    
                }, label: {
                    Image(systemName: (club.isFavorite ?? false) ? "star.fill" : "star")
                    
                })
            }
        }
        .onAppear(perform: {clubsController.notifyOfViewed(club: club)})
    }
}

/*struct ClubView_Previews: PreviewProvider {
 static var previews: some View {
 ClubView()
 }
 }*/
