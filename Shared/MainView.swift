//
//  ContentView.swift
//  Shared
//
//  Created by Jake Spann on 11/13/21.
//

import SwiftUI
import Combine

struct MainView: View {
    
    var body: some View {
        TabView() {
            HomeView()
                .tabItem() {
                    Label("Home", systemImage: "house")
                }
            DirectoryView()
                .tabItem() {
                    Label("Directory", systemImage: "list.bullet.rectangle.portrait")
                }
            
            AnnouncementsView()
                .tabItem() {
                    Label("Announcements", systemImage: "bell")
                }
        }
        //Green - 14524F
        //Oragne - BD4F00
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
        MainView()
    }
}
