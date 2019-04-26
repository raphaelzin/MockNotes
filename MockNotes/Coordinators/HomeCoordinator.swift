//
//  HomeCoordinator.swift
//  MockNotes
//
//  Created by Raphael Souza on 2019-04-26.
//  Copyright © 2019 Raphael Inc. All rights reserved.
//

import UIKit

class HomeCoordinator: RootViewCoordinator {
    
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController(navigationBarClass: ACNavigationBar.self, toolbarClass: nil)
        return navigationController
    }()
    
    func start() {
        let controller = NotesViewController()
        let presenter = NotesPresenter(view: controller)
        presenter.coordinatorDelegate = self
        controller.presenter = presenter
        
        navigationController.pushViewController(controller, animated: true)
    }
}

// MARK: Notes listing

extension HomeCoordinator: NotesViewControllerDelegate {
    func didSelect(note: RNote) {
        
        let controller = NoteDetailsViewController()
        let presenter = NoteDetailsPresenter(view: controller, note: note)
        presenter.coordinatorDelegate = self
        controller.presenter = presenter
        
        navigationController.pushViewController(controller, animated: true)
    }
}

// MARK:

extension HomeCoordinator: NoteDetailsControllerDelegate {
    func didRequestDismiss() {
        navigationController.popViewController(animated: true)
    }
}
