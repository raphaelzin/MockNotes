//
//  Localizable.swift
//  MockNotes
//
//  Created by Raphael Souza on 2019-04-26.
//  Copyright © 2019 Raphael Inc. All rights reserved.
//

import Foundation

struct Localizable {
    
    struct General {
        static let save = "save".localized
        static let cancel = "cancel".localized
        static let ok = "ok".localized
    }
    
    struct Error {
        static let unknown = "unknown_error".localized
        static let invalidNote = "invalid_note".localized
        static let emptyContentNote = "empty_content_note".localized
    }
    
    
    struct Home {
        static let notes = "notes".localized
    }
    
    struct Details {
        static let note = "note".localized
        static let waitThatsIlegal = "wait_thats_ilegal".localized
        static let weHaveAProblem = "we_have_a_problem".localized
    }
}
