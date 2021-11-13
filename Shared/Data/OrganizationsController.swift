//
//  CommunicationController.swift
//  MOCK-HackUTDVIII
//
//  Created by Jake Spann on 11/13/21.
//

import Foundation
import Combine

class OrganizationsController: ObservableObject {
    @Published var organizations: [Organization] = []
    @Published var categories: [String] = []
    @Published var recentlyViewed: [Organization] = [] // Stack
    
    func getOrganizations(completion: ([Organization]) -> Void){
        let urlString = "https://api.presence.io/utdallas/v1/organizations"

            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    decoder.dateDecodingStrategy = .secondsSince1970
                    let clubs = try! decoder.decode([Organization].self, from: data)
                    completion(clubs)
                    print("fetched clubs")
                }
            }
    }
    
    func notifyOfViewed(club: Organization) {
        if recentlyViewed.last != club {
            if recentlyViewed.count == 3 {recentlyViewed.removeFirst()}
            recentlyViewed.append(club)
        }
    }
    
    func decodeJSON(completion: (() -> Void)?) {
        getOrganizations() {clubs in
            organizations = clubs
        }
    }
    
    // Compute all of the available categories
    func getCategories() {
        if organizations.isEmpty {
            decodeJSON(completion: {print("done")})
        }
                       print("computing categories")
        let newCategories = organizations.flatMap({$0.categories})
        for category in newCategories {
            if !categories.contains(category) {
                categories.append(category)
            }
        }
    }
}
