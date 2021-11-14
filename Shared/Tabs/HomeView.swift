//
//  HomeView.swift
//  MOCK-HackUTDVIII
//
//  Created by Jake Spann on 11/14/21.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var networkController: OrganizationsController
    
    var body: some View {
        NavigationView() {
            List {
                Section("Recently Viewed") {
                    if !$networkController.recentlyViewed.isEmpty {
                        HStack {
                            ForEach($networkController.organizations) {club in
                                if networkController.recentlyViewed.contains(club.wrappedValue) {
                                NavigationLink(destination: ClubView(club: club)) {
                                    CompactClubCard(club: club)
                                        #if os(iOS)
                                        .listRowSeparator(.hidden)
                                            #endif
                                    
                                }
                                }
                            }
                            }
                    } else {
                        HStack {
                            Spacer()
                        Text("Clubs will appear here as you browse the app")
                            .foregroundColor(.secondary)
                            .listRowSeparator(.hidden)
                            .frame(alignment: .center)
                            .multilineTextAlignment(.center)
                            Spacer()
                        }
                        .listRowSeparator(.hidden)
                    }
                }
                Section("Favorites") {
                    ForEach($networkController.organizations) {club in
                        if club.wrappedValue.isFavorite ?? false {
                        NavigationLink(destination: ClubView(club: club)) {
                          
                                ClubCard(club: club.wrappedValue)
                            
#if os(iOS)
                                .listRowSeparator(.hidden)
#endif
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .onAppear(perform: {
                if networkController.organizations.isEmpty {
                    networkController.fetchClubs(nil)
                }
                
            })
            .navigationTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
