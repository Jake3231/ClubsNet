//
//  Organization.swift
//  MOCK-HackUTDVIII
//
//  Created by Jake Spann on 11/13/21.
//

import Foundation

struct Organization: Codable, Identifiable, Equatable {
    var id: String {uri}
    
    var subdomain: String = "utdallas"
    var campusName: String = "The University Of Texas at Dallas"
    var name: String = "CLUB NAME"
    var uri: String
    var regularMeetingLocation: String?
    var photoType: String?
    var photoUri: String?
    var photoUriWithVersion: String
    var memberCount: Int?
    var categories: [String]
    var orgMember: Bool
    var newOrg: Bool
    var hasUpcomingEvents: Bool
    
}
