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
    @Published var categories: [String] = [
        "Academic Interest",
        "Cultural",
        "Service",
        "Student Leadership",
        "Special Interest",
        "Arts and Music",
        "Honor Society",
        "Fraternity & Sorority Life",
        "Educational/Departmental",
        "Social",
        "Religious",
        "Political",
        "University Department",
        "University Recreation",
        "Student Government",
        "Student Media"
]
    @Published var recentlyViewed: [Organization] = [] // Stack
    @Published var organizationsPerCategory: [String:[Organization]] = [:]
    var favoriteClubs: [Organization] {organizations.filter({$0.isFavorite ?? false})}
    
    @Published var didFinishSortingClubs: Bool = true
    
    func getOrganizations(completion: @escaping ([Organization]) -> Void) {
        DispatchQueue.global(qos: .background).async {
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
    }
    
    func notifyOfViewed(club: Organization?) {
        if !recentlyViewed.contains(club!) {
        if club != nil {
        if recentlyViewed.last != club! {
            if recentlyViewed.count == 3 {recentlyViewed.removeFirst()}
            recentlyViewed.append(club!)
        }
        }
        }
    }
    
    func getAdvancedDataFor(organization: String) {
        DispatchQueue.global(qos: .background).async {
            let urlString = "https://api.presence.io/utdallas/v1/organizations/\(organization)"

                if let url = URL(string: urlString) {
                    if let data = try? Data(contentsOf: url) {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .useDefaultKeys
                        decoder.dateDecodingStrategy = .secondsSince1970
                        let club = try! decoder.decode(Organization.self, from: data)
                        let index = self.organizations.firstIndex(where: {$0.uri == organization})
                        
                        DispatchQueue.main.async {
                            self.organizations[index ?? 0].twitter = club.twitter
                            self.organizations[index ?? 0].facebook = club.facebook
                            self.organizations[index ?? 0].description = club.description
                        }
                        
                        
                        print("fetched club info")
                    }
                }
            }
    }
    
    func fetchClubs(_ completion: (() -> Void)?) {
        getOrganizations() { clubs in
            DispatchQueue.main.async {self.organizations = clubs
                
            
            // On a background thread, begin sorting organizations into categories
            if !self.didFinishSortingClubs {
            /*DispatchQueue.global(qos: .background).async {
                for club in self.organizations {
                    for category in club.categories {
                        if !category.isEmpty {
                        DispatchQueue.main.async {
                           // print(self.organizationsPerCategory[category])
                            if self.organizationsPerCategory[category] == nil {
                                self.organizationsPerCategory[category] = []
                            }
                            self.organizationsPerCategory[category]! += [club]
                        }
                        }
                    }
                }
                print("Finished sorting clubs into categories")
                DispatchQueue.main.async {self.didFinishSortingClubs = true}
            }*/
            }
            }
            if completion != nil {
                completion!()
            }
        }
    }
    
    
    func getOrganizationsFor(category: String) -> [Organization] {
        print("searching for \(category)")
        /*var organizations:[Organization] = []
        for organization in organizationsPerCategory[category] ?? [] {
            organizations.append(organizations.first(where: {$0.uri == organization})!)
        }
        return organizations*/
        //print(organizationsPerCategory)
        return organizationsPerCategory[category] ?? []
    }
    
    func organizationFrom(uri: String) -> Organization? {
        return organizations.first(where: {$0.uri == uri})
    }
    
   /* func favorite(organization: String) {
        print("FAVORITING \(organization)")
        if !favoriteClubs.contains(organization) {
            favoriteClubs.append(organization)
        }
    }*/
}
