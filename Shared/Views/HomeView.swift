//
//  HomeView.swift
//  MOCK-HackUTDVIII
//
//  Created by Jake Spann on 11/14/21.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var networkController: OrganizationsController
    
#if os(iOS)
init() {
        //Use this if NavigationBarTitle is with Large Font
    UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(named:"UTDGreen")]

        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(named:"UTDGreen")]
    }
#endif
    
    var body: some View {
        NavigationView() {
            List {
                Section("Recently Viewed") {
                    if !$networkController.recentlyViewed.isEmpty {
                        RecentlyViewedView()
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
                        .listRowBackground(Color(UIColor.secondarySystemBackground))
                    }
                }
                Section("Favorites") {
                    ForEach($networkController.organizations) {club in
                        if club.wrappedValue.isFavorite ?? false {
                            ZStack {
                                ClubCard(club: club.wrappedValue)
                        NavigationLink(destination: ClubView(club: club)) {
                                #if os(iOS)
                                #endif
                        }.opacity(0)
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color(UIColor.secondarySystemBackground))
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
            .background(Color(UIColor.secondarySystemBackground))
            .navigationTitle("Home")
        }
    }
}

struct RecentlyViewedView: View {
    @EnvironmentObject var networkController: OrganizationsController
    
    var body: some View {
       // LazyHGrid(rows: [GridItem(.flexible(minimum: 10, maximum: 100), spacing: 10, alignment: .center)]) {
            ForEach($networkController.organizations) {club in
                if networkController.recentlyViewed.contains(club.wrappedValue) {
                    ZStack {
                        CompactClubCard(club: club)
                            .background(Color(UIColor.secondarySystemBackground))
                NavigationLink(destination: ClubView(club: club)) {
                        #if os(iOS)
                        #endif
                }.opacity(0)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color(UIColor.secondarySystemBackground))
                }
            }
           // }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
