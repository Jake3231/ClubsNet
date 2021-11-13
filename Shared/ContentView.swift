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
                    networkController.decodeJSON()
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
                    ForEach($networkController.recentlyViewed.reversed()) {club in
                            NavigationLink(destination: ClubView(club: club)) {
                               /* ClubCard(club: club.wrappedValue)
                                    .padding([.top, .bottom], 5)*/
                                Text(club.wrappedValue.name)
#if os(iOS)
                            .listRowSeparator(.hidden)
#endif
                            
                        }
                    }
                }
                Section("Favorites") {
                }
            }
            .listStyle(.plain)
            .onAppear(perform: {
                if networkController.organizations.isEmpty {
                    networkController.decodeJSON()
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
