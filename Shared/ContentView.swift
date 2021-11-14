//
//  ContentView.swift
//  Shared
//
//  Created by Jake Spann on 11/13/21.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    var body: some View {
        TabView() {
            //NavigationView() {
            HomeView()
                .tabItem() {
                    Label("Home", systemImage: "house")
                }
            DirectoryView()
                .tabItem() {
                    Label("Directory", systemImage: "list.bullet.rectangle.portrait")
                }
            // }
            /* FavoritesView(title: "ACM UTD")
             .tabItem() {
             Label("Favorites", systemImage: "heart")
             }*/
            
            AnnouncementsView()
                .tabItem() {
                    Label("Announcements", systemImage: "bell")
                }
        }
        //Green - 14524F
        //Oragne - BD4F00
    }
}

struct DirectoryView: View {
    @EnvironmentObject var networkController: OrganizationsController
    
    var body: some View {
        NavigationView() {
            List {
                //  Section("Recently Viewed") {
                ForEach($networkController.organizations) {club in
                    NavigationLink(destination: ClubView(club: club)) {
                        ClubCard(club: club.wrappedValue)
                            .padding([.top, .bottom], 5)
                    }
#if os(iOS)
                    .listRowSeparator(.hidden)
#endif
                    
                    //  }
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
                        Text("None, yet!")
                            .listRowSeparator(.hidden)
                            .frame(alignment: .center)
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

struct AnnouncementsView: View {
    var body: some View {
        NavigationView {
            Text("Announcemnsts")
                .navigationTitle("Annoncements")
        }
    }
}

struct FavoritesView: View {
    var title: String
    var body: some View {
        NavigationView() {
            Text(title)
                .navigationTitle("Favorites")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
