//
//  NotesPresenter.swift
//  TestApp
//
//

import Foundation

protocol INotesPresenter: class {
    func addNote()
    
    func configure(cell: NoteCell, at indexPath: IndexPath)
    func loadNotes(callback: @escaping (() -> Void))
    func didSelect(rowAt indexPath: IndexPath)
    func deleteNote(at indexPath: IndexPath)
    
    func searchNotes(with term: String)
    
    var numberOfNotes: Int { get }
}

protocol NotesViewControllerDelegate: class {
    func didSelect(note: RNote)
    func didRequestAddNote()
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
    func searchNotes(with term: String) {
        notesService.fetchNotes { [weak self] notes in
            // Filters notes that does not contain the terms being search. If term is empty show all notes.
            // Using lowercased so the search is case insensitive.
            self?.notes = term.isEmpty ? (notes ?? []) : (notes ?? []).filter { $0.content.lowercased().contains(term.lowercased()) }
            self?.view.updateData()
        }
    }
    
    func deleteNote(at indexPath: IndexPath) {
        notesService.delete(note: notes[indexPath.row]) { [weak self] (error) in
            if let error = error {
                // Let the view
            } else {
                self?.notes.remove(at: indexPath.row)
                self?.view.updateData()
            }
        }
    }
    
    func addNote() {
        coordinatorDelegate?.didRequestAddNote()
    }
    
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
