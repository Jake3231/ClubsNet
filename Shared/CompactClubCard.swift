//
//  CompactClubCard.swift
//  MOCK-HackUTDVIII
//
//  Created by Jake Spann on 11/13/21.
//

import SwiftUI

struct CompactClubCard: View {
    @Binding var club: Organization
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                //.frame(width: 250, height: 100)
                .foregroundColor(Color("CardBackground") )
                .shadow(color: .secondary, radius: 3)
        VStack(alignment: .leading) {
          //  HStack(alignment: .center) {
              //  AsyncImage(url: URL(string: ))
                AsyncImage(url: URL(string: "https://utdallas-cdn.presence.io/organization-photos/e84b1f83-51b3-4fcd-8fd6-e0d4e2be5e31/\(club.photoUri ?? "")")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Image("acm")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .frame(maxHeight: 40)
                Text(club.name ??  "Unknown")
                    .fontWeight(.bold)
              //  Spacer()
           // }
        }
        .padding()
        }
        .frame(maxWidth: 150, maxHeight: 150)
    }
}

/*struct CompactClubCard_Previews: PreviewProvider {
    static var previews: some View {
        CompactClubCard(club: <#Binding<Organization?>#>)
    }
}*/
