//
//  NotesService.swift
//  TestApp
//
//  Created by Raphael Souza on 2019-04-21.
//  
//

import Foundation
import RESTManager

protocol NotesDataSource {
    func fetchNotes(callback: @escaping NotesResponseHandler)
    func fetchNote(with id: String, callback: @escaping NoteResponseHandler)
    func update(_ note: RNote, callback: @escaping ResponseHandler)
    func delete(_ note: RNote, callback: @escaping ResponseHandler)
    func save(_ content: String, callback: @escaping ResponseHandler)
}

typealias NoteResponseHandler = (_ note: RNote?) -> Void
typealias NotesResponseHandler = (_ note: [RNote]?) -> Void
typealias ResponseHandler = (_ error: Error?) -> Void

class NotesService {
    private let remote: NotesDataSource = NotesRemoteDataSource()
    private let local: NotesDataSource = NotesLocalDataSource()
    
    func fetchNotes(callback: @escaping NotesResponseHandler) {
        if true {
            remote.fetchNotes(callback: callback)
        } else {
            local.fetchNotes(callback: callback)
        }
    }
    
    func update(_ note: RNote, callback: @escaping ResponseHandler) {
        // Update note on the server
        remote.update(note) { [weak self] (error) in
            // Return error if there's any
            if let error = error {
                callback(error)
            } else {
                // if no error, save it locally
//                self?.local.update(note, callback: callback)
                callback(nil)
            }
        }
    }
    
    func save(_ content: String, callback: @escaping ResponseHandler) {
        remote.save(content) { [weak self] (error) in
            if let error = error {
                callback(error)
            } else {
                // if no error, save it locally
                //self?.local.save(content, callback: callback)
                callback(nil)
            }
        }
    }
    
    func delete(note: RNote, callback: @escaping ResponseHandler) {
        remote.delete(note) { [weak self] (error) in
            if let error = error {
                callback(error)
            } else {
                // if no error, delete it locally
                //self?.local.delete(note, callback: callback)
                callback(nil)
            }
        }
    }
}
