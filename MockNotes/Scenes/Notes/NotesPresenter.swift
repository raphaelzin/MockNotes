//
//  NotesPresenter.swift
//  TestApp
//
//


import Foundation

protocol INotesPresenter: class {
    func configure(cell: NoteCell, at indexPath: IndexPath)
    func loadNotes(callback: @escaping (() -> Void))
    func didSelect(rowAt indexPath: IndexPath)
    
    var numberOfNotes: Int { get }
}

protocol NotesViewControllerDelegate: class {
    func didSelect(note: RNote)
}

class NotesPresenter {
    unowned let view: NotesView
    private let notesService = NotesService()
    private var notes: [RNote] = []
    
    weak var coordinatorDelegate: NotesViewControllerDelegate?
    
    init(view: NotesView) {
        self.view = view
    }
}

// MARK: NotePresenter Implementation

extension NotesPresenter: INotesPresenter {
    
    var numberOfNotes: Int {
        return notes.count
    }
    
    func didSelect(rowAt indexPath: IndexPath) {
        coordinatorDelegate?.didSelect(note: notes[indexPath.row])
    }
    
    func configure(cell: NoteCell, at indexPath: IndexPath) {
        cell.configure(with: notes[indexPath.row])
    }
    
    func loadNotes(callback: @escaping () -> Void) {
        notesService.fetchNotes { [weak self] notes in
            self?.notes = notes ?? []
            self?.view.updateData()
            callback()
        }
    }
}
