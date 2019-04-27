//
//  String.swift
//  MockNotes
//
//  Created by Raphael Souza on 2019-04-26.
//  Copyright © 2019 Raphael Inc. All rights reserved.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }
    
    func date(as format: Date.Format) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.value
        return dateFormatter.date(from: self)
    }
    
}
