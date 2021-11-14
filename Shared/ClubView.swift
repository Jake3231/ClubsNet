//
//  ClubView.swift
//  MOCK-HackUTDVIII
//
//  Created by Jake Spann on 11/13/21.
//

import SwiftUI

struct ClubView: View {
    @EnvironmentObject var clubsController: OrganizationsController
    var club: Organization?
    
    var body: some View {
        Text(club?.name ?? "Name")
            .navigationTitle(club?.name ?? "name")
            .toolbar() {
                ToolbarItem {
                    Button(action: {print("favotire")}, label: {Image(systemName: "heart")})
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
