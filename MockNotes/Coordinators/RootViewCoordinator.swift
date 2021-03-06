//
//  RootViewCoordinator.swift
//  MockNotes
//
//  Created by Raphael Souza on 2019-04-26.
//  Copyright © 2019 Raphael Inc. All rights reserved.
//

import UIKit

/// Base protocol for RootViewCoordinator
public protocol RootViewControllerProvider: class {
    var rootViewController: UIViewController { get }
}

/// Every root coordinator has to have a RootViewController
public typealias RootViewCoordinator = Coordinator & RootViewControllerProvider
