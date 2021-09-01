//
//  ComicEntity+CoreDataClass.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 24/8/21.
//
//

import Foundation
import CoreData

@objc(ComicEntity)
public class ComicEntity: NSManagedObject {
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext!) {
        super.init(entity: entity, insertInto: context)
    }
    
    convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = ComicEntity.entity(managedObjectContext)
        self.init(entity: entity!, insertInto: managedObjectContext)
    }
    
    // MARK: - Static
    static func entity(_ managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entity(forEntityName: ComicEntity.className, in: managedObjectContext)
    }
    
    static func insert(comics: [Comic],
                       character: CharacterEntity,
                       context: NSManagedObjectContext) {
        var savedComics = [Int64]()
        for comic in comics {
            var comicEntity: ComicEntity
            if let fetchedCharacter = ComicEntity.getById(comic.id, context: context){
                comicEntity = fetchedCharacter
            } else {
                comicEntity = ComicEntity(context: context)
                comicEntity.mId = comic.id
            }
            comicEntity.name = comic.title
            comicEntity.mDescription = character.description
            comicEntity.character = character
            
            ThumbnailEntity.insert(thumbnail: comic.thumbnail, comic: comicEntity, context: context)
            
            savedComics.append(comic.id)
        }
        deleteById(savedComics, character: character, context: context)
    }
    
    static func getById(_ id: Int64, context: NSManagedObjectContext) -> ComicEntity? {
        let predicate = NSPredicate(format: "mId = %d", id)
        do {
            return try ComicEntity.objects(for: predicate, context: context).first
        } catch {
            debugPrint("Error getting Characterentity \(#function)  - \(#file)")
            return nil
        }
    }
    
    static func deleteById(_ ids: [Int64], character: CharacterEntity, context: NSManagedObjectContext) {
        let predicate = NSPredicate(format: "NOT mId = %@ AND character = %@", ids, character)
        do {
            let comics = try ComicEntity.objects(for: predicate, context: context)
            comics.forEach { context.delete($0) }
        } catch {
            debugPrint("Error getting Characterentity \(#function)  - \(#file)")
        }
    }
}

// MARK: - Fetchable
extension ComicEntity: Fetchable {
    enum AttributeName : String { case name }
}

