//
//  RNote.swift
//  MockNotes
//
//  Created by Raphael Souza on 2019-04-26.
//  Copyright © 2019 Raphael Inc. All rights reserved.
//

import Foundation

// Model to be parsed from remote

class RNote: Codable {
    let id: String
    var content: String
    private var createdAtRaw: String
    
    var createdAt: Date? {
        return createdAtRaw.date(as: .iso8601)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case content
        case createdAtRaw = "createdAt"
    }
}
