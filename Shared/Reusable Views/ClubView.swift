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
                Spacer()
            }
            Spacer()
        }
        }
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
