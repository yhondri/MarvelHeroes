//
//  CharacterEntity+CoreDataProperties.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 24/8/21.
//
//

import Foundation
import CoreData


extension CharacterEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterEntity> {
        return NSFetchRequest<CharacterEntity>(entityName: "CharacterEntity")
    }

    @NSManaged public var mId: Int64
    @NSManaged public var name: String
    @NSManaged public var mDescription: String?
    @NSManaged public var thumbnail: ThumbnailEntity
    @NSManaged public var comics: NSSet?

}

// MARK: Generated accessors for comics
extension CharacterEntity {

    @objc(addComicsObject:)
    @NSManaged public func addToComics(_ value: ComicEntity)

    @objc(removeComicsObject:)
    @NSManaged public func removeFromComics(_ value: ComicEntity)

    @objc(addComics:)
    @NSManaged public func addToComics(_ values: NSSet)

    @objc(removeComics:)
    @NSManaged public func removeFromComics(_ values: NSSet)

}

extension CharacterEntity : Identifiable {

}
