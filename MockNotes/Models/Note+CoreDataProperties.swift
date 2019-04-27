//
//  Note+CoreDataProperties.swift
//  
//
//  Created by Raphael Souza on 2019-04-26.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var content: String?
    @NSManaged public var createdAt: NSDate?
    @NSManaged public var id: String?
    
    convenience init(rnote: RNote) {
        self.init()
        self.content   = rnote.content
//        self.createdAt = rnote.createdAt
        self.id = rnote.id
    }
}

