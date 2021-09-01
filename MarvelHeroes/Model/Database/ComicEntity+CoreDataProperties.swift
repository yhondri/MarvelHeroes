//
//  ComicEntity+CoreDataProperties.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 24/8/21.
//
//

import Foundation
import CoreData


extension ComicEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ComicEntity> {
        return NSFetchRequest<ComicEntity>(entityName: "ComicEntity")
    }

    @NSManaged public var mId: Int64
    @NSManaged public var name: String?
    @NSManaged public var mDescription: String?
    @NSManaged public var thumbnail: ThumbnailEntity?
    @NSManaged public var character: CharacterEntity?

}

extension ComicEntity : Identifiable {

}
