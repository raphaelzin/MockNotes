//
//  Date.swift
//  MockNotes
//
//  Created by Raphael Souza on 2019-04-26.
//  Copyright © 2019 Raphael Inc. All rights reserved.
//

import Foundation

extension Date {
    /// Returns a string describing the date according to the given format
    func formated(as format: Date.Format) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.value
        return dateFormatter.string(from: self)
    }
}

// List Formats

extension Date {
    enum Format: String {
        case iso8601, simple
        
        var value: String {
            switch self {
            case .iso8601: return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            case .simple: return "MMM d, H:mm"
            }
        }
    }
}
