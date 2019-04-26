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
    var title: String
    var content: String
}
