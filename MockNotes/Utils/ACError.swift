//
//  ACError.swift
//  MockNotes
//
//  Created by Raphael Souza on 2019-04-26.
//  Copyright © 2019 Raphael Inc. All rights reserved.
//

import Foundation

// Errors

enum ACError: Error {
    case unknown
    case invalidNote
    case emptyContentNote
}

extension ACError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unknown: return Localizable.Error.unknown
        case .invalidNote: return Localizable.Error.invalidNote
        case .emptyContentNote: return Localizable.Error.emptyContentNote
        }
    }
}
