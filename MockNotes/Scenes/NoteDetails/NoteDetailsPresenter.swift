//
//  NoteDetailsPresenter.swift
//  TestApp
//
//  Created by Raphael Souza on 2019-04-24.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import Foundation

import RxCocoa
import RxSwift

protocol NoteDetailsViewPresenter: class {
    func saveChanges()
}

protocol NoteDetailsControllerDelegate: class {
    func didRequestDismiss()
}

class NoteDetailsPresenter {
    
    // MARK: Attributes
    
    private let notesService = NotesService()
    private let note: RNote?
    
    weak var coordinatorDelegate: NoteDetailsControllerDelegate?
    unowned var view: NoteDetailsView
    
    private lazy var contentRelay = BehaviorRelay<String?>(value: note?.content)
    
    // MARK: Initializer
    
    init(view: NoteDetailsView, note: RNote? = nil) {
        self.view = view
        self.note = note
        
        self.view.bindData(content: contentRelay)
    }
}

// MARK: NoteDetailsViewPresenter implementation

extension NoteDetailsPresenter: NoteDetailsViewPresenter {
    func saveChanges() {
        // If there's a note, means that we're supposed to save changes to an existing note
        if let note = note {
            note.content = contentRelay.value ?? ""
            update(note)
        } else {
            createNote(with: contentRelay.value ?? "")
        }
    }
}

// MARK: Private methods

private extension NoteDetailsPresenter {
    
    func update(_ note: RNote) {
        // Save changes and if there's an error, let the view know
        notesService.update(note) { [weak self] (error) in
            if let error = error {
                self?.view.display(error)
            } else {
                self?.coordinatorDelegate?.didRequestDismiss()
            }
        }
    }
    
    func createNote(with content: String) {
        // Save changes and if there's an error, let the view know
        notesService.save(content) { [weak self] (error) in
            if let error = error {
                self?.view.display(error)
            } else {
                self?.coordinatorDelegate?.didRequestDismiss()
            }
        }
    }
}
