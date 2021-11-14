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
                    NavigationLink(destination: ClubView(club: club.wrappedValue)) {
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
                    ForEach($networkController.recentlyViewed.reversed()) {club in
                        NavigationLink(destination: ClubView(club: club.wrappedValue)) {
                               /* ClubCard(club: club.wrappedValue)
                                    .padding([.top, .bottom], 5)*/
                                Text(club.wrappedValue.name)
#if os(iOS)
                            .listRowSeparator(.hidden)
#endif
                            
                        }
                    }
                    } else {
                        Text("None, yet!")
                            .listRowSeparator(.hidden)
                            .frame(alignment: .center)
                    }
                }
                Section("Favorites") {
                    ForEach($networkController.favoriteClubs, id: \.self) {club in
                        NavigationLink(destination: ClubView(club: networkController.organizationFrom(uri: club.wrappedValue))) {
                                ClubCard(club: networkController.organizationFrom(uri: club.wrappedValue))
#if os(iOS)
                            .listRowSeparator(.hidden)
#endif
                            
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
        Text("Announcemnsts")
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
