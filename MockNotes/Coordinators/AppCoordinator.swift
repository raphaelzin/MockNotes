//
//  AppCoordinator.swift
//  MockNotes
//
//  Created by Raphael Souza on 2019-04-26.
//  Copyright © 2019 Raphael Inc. All rights reserved.
//

import UIKit

class AppCoordinator: RootViewCoordinator {
    
    // MARK: - Properties
    var childCoordinators: [Coordinator] = []
    private(set) var rootViewController: UIViewController = SplashController() {
        didSet {
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.window.rootViewController = self.rootViewController
            })
        }
    }
    
    /// Window to manage
    let window: UIWindow
    
    // MARK: - Init
    
    public init(window: UIWindow) {
        self.window = window
        window.backgroundColor = .white
        self.window.rootViewController = self.rootViewController
        self.window.makeKeyAndVisible()
    }
    
    private func setCurrentCoordinator(_ coordinator: RootViewCoordinator) {
        rootViewController = coordinator.rootViewController
    }
    
    // MARK: - Functions
    
    /// Starts the coordinator
    public func start() {
        
        let homeCoordinator = HomeCoordinator()
        addChildCoordinator(homeCoordinator)
        setCurrentCoordinator(homeCoordinator)
        homeCoordinator.start()
    }
}
