//
//  NotesRemoteDataSource.swift
//  MockNotes
//
//  Created by Raphael Souza on 2019-04-26.
//  Copyright © 2019 Raphael Inc. All rights reserved.
//

import Foundation
import RESTManager

class NotesRemoteDataSource: NotesDataSource {
    private let ENDPOINT_PREFIX = "api/v1/"
    
    func fetchNotes(callback: @escaping NotesResponseHandler) {
        let resource = Resource<[RNote]>(path: ENDPOINT_PREFIX + "notes", method: .get)
        
        resource.request { (result) in
            callback(try? result.decoded() as [RNote])
        }
    }
    
    func fetchNote(with id: String, callback: @escaping NoteResponseHandler) {
        let resource = Resource<RNote>(path: ENDPOINT_PREFIX + "notes/\(id)", method: .get)
        
        resource.request { (result) in
            callback(try? result.decoded() as RNote)
        }
    }
    
    func update(_ note: RNote, callback: @escaping ResponseHandler) {
        let resource = Resource<Bool>(path: ENDPOINT_PREFIX + "notes/\(note.id)", method: .put)
        
        resource.request(parameters: note.dictionary) { (result) in
            callback(result.error as? RError)
        }
    }
    
    func create(_ note: RNote, callback: @escaping ResponseHandler) {
        let resource = Resource<Bool>(path: ENDPOINT_PREFIX + "notes", method: .post)
        
        resource.request(parameters: note.dictionary) { (result) in
            callback(result.error as? RError)
        }
    }
    
    func delete(_ note: RNote, callback: @escaping ResponseHandler) {
        let resource = Resource<Bool>(path: ENDPOINT_PREFIX + "notes/\(note.id)", method: .delete)
        
        resource.request { (result) in
            callback(result.error as? RError)
        }
    }
}
