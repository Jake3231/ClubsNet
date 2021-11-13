//
//  Category.swift
//  MOCK-HackUTDVIII
//
//  Created by Jake Spann on 11/13/21.
//

import Foundation


struct Category: Identifiable {
    var name: String
    var uri: String
    var id: String {uri}
}
