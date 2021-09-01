//
//  ThumbnailEntity+CoreDataProperties.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 24/8/21.
//
//

import Foundation
import CoreData


extension ThumbnailEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ThumbnailEntity> {
        return NSFetchRequest<ThumbnailEntity>(entityName: "ThumbnailEntity")
    }

    @NSManaged public var path: String
    @NSManaged public var imageExtension: String
    @NSManaged public var character: CharacterEntity?
    @NSManaged public var comic: ComicEntity?

}

extension ThumbnailEntity : Identifiable {

}
