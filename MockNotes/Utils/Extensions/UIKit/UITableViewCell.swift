//
//  UITableViewCell.swift
//  MockNotes
//
//  Created by Raphael Souza on 2019-04-26.
//  Copyright © 2019 Raphael Inc. All rights reserved.
//

import UIKit

public extension UITableViewCell {
    static var defaultIdentifier: String {
        return String(describing: self)
    }
}
