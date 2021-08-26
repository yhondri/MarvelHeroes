//
//  ThumbnailEntity+CoreDataClass.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 24/8/21.
//
//

import Foundation
import CoreData

@objc(ThumbnailEntity)
public class ThumbnailEntity: NSManagedObject {
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext!) {
        super.init(entity: entity, insertInto: context)
    }
    
    convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = ThumbnailEntity.entity(managedObjectContext)
        self.init(entity: entity!, insertInto: managedObjectContext)
    }
    
    // MARK: - Static
    static func entity(_ managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entity(forEntityName: ThumbnailEntity.className, in: managedObjectContext)
    }
    
    static func insert(thumbnail: Thumbnail,
                       comic: ComicEntity,
                       context: NSManagedObjectContext) {
        let thumbnailEntity: ThumbnailEntity = getThumbnailEntity(thumbnail: thumbnail, context: context)
        thumbnailEntity.comic = comic
    }
    
    static func insert(thumbnail: Thumbnail,
                       character: CharacterEntity,
                       context: NSManagedObjectContext) {
        let thumbnailEntity: ThumbnailEntity = getThumbnailEntity(thumbnail: thumbnail, context: context)
        thumbnailEntity.character = character
    }
    
    private static func getThumbnailEntity(thumbnail: Thumbnail, context: NSManagedObjectContext) -> ThumbnailEntity {
        let thumbnailEntity: ThumbnailEntity = ThumbnailEntity(context: context)
        thumbnailEntity.path = thumbnail.path
        thumbnailEntity.imageExtension = thumbnail.imageExtension
        return thumbnailEntity
    }
}
