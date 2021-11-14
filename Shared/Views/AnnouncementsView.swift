//
//  AnnouncementsView.swift
//  MOCK-HackUTDVIII
//
//  Created by Jake Spann on 11/14/21.
//

import SwiftUI

struct AnnouncementsView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "hammer.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 100, maxHeight: 100)
                    .imageScale(.large)
                Text("Under construction, check back later!")
            }
                .navigationTitle("Annoncements")
        }
    }
}

struct AnnouncementsView_Previews: PreviewProvider {
    static var previews: some View {
        AnnouncementsView()
    }
}
