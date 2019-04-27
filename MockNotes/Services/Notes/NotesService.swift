//
//  NotesService.swift
//  TestApp
//
//  Created by Raphael Souza on 2019-04-21.
//  
//

import Foundation
import RESTManager

class NotesService {
    private let ENDPOINT_PREFIX = "api/v1/"
    
    func fetchNotes(callback: @escaping (_ notes: [RNote]?) -> Void) {
        let resource = Resource<[RNote]>(path: ENDPOINT_PREFIX + "notes", method: .get)
        
        resource.request { (result) in
            callback(try? result.decoded() as [RNote])
        }
    }
    
    func fetchNote(with id: String, callback: @escaping (_ note: RNote?) -> Void) {
        let resource = Resource<RNote>(path: ENDPOINT_PREFIX + "notes/\(id)", method: .get)
        
        resource.request { (result) in
            callback(try? result.decoded() as RNote)
        }
    }
    
    func update(_ note: RNote, callback: @escaping (_ error: RError?) -> Void) {
        let resource = Resource<Bool>(path: ENDPOINT_PREFIX + "notes/\(note.id)", method: .put)
        
        resource.request(parameters: note.dictionary) { (result) in
            callback(result.error as? RError)
        }
    }
}
