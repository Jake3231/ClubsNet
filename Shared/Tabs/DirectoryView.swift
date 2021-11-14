//
//  DirectoryView.swift
//  MOCK-HackUTDVIII
//
//  Created by Jake Spann on 11/14/21.
//

import SwiftUI

struct DirectoryView: View {
    @EnvironmentObject var networkController: OrganizationsController
    
    var body: some View {
        NavigationView() {
            List {
                ForEach($networkController.organizations) {club in
                    NavigationLink(destination: ClubView(club: club)) {
                        ClubCard(club: club.wrappedValue)
                            .padding([.top, .bottom], 5)
                    }
#if os(iOS)
                    .listRowSeparator(.hidden)
#endif
                    
                }
            }
            .listStyle(.plain)
            .onAppear(perform: {
                if networkController.organizations.isEmpty {
                    networkController.fetchClubs(nil)
                }
                
            })
            .navigationTitle("Directory")
        }
    }
}

struct DirectoryView_Previews: PreviewProvider {
    static var previews: some View {
        DirectoryView()
    }
}
