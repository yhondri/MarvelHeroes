//
//  CharacterEntity+CoreDataClass.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 24/8/21.
//
//

import Foundation
import CoreData

@objc(CharacterEntity)
public class CharacterEntity: NSManagedObject {
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext!) {
        super.init(entity: entity, insertInto: context)
    }
    
    convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = CharacterEntity.entity(managedObjectContext)
        self.init(entity: entity!, insertInto: managedObjectContext)
    }
    
    // MARK: - Static
    static func entity(_ managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entity(forEntityName: CharacterEntity.className, in: managedObjectContext)
    }
    
    static func insert(character: Character,
                       comics: [Comic],
                       context: NSManagedObjectContext) {
        var characterEntity: CharacterEntity
        if let fetchedCharacter = CharacterEntity.getById(character.id, context: context){
            characterEntity = fetchedCharacter
        } else {
            characterEntity = CharacterEntity(context: context)
            characterEntity.mId = character.id
        }
        characterEntity.name = character.name
        characterEntity.mDescription = character.description
        
        ThumbnailEntity.insert(thumbnail: character.thumbnail, character: characterEntity, context: context)
    }
    
    static func getAll(context: NSManagedObjectContext) -> [Character] {
        do {
            return try CharacterEntity.objects(sortedBy: (AttributeName.name, true), context: context).compactMap {
                Character(id: $0.mId, name: $0.name, description: $0.mDescription,
                                      thumbnail: Thumbnail(path: $0.thumbnail.path, imageExtension: $0.thumbnail.imageExtension))
            }
        } catch {
            debugPrint("Error loading characters \(error)")
            return []
        }
    }
    
    static func getById(_ id: Int64, context: NSManagedObjectContext) -> CharacterEntity? {
        let predicate = NSPredicate(format: "mId = %d", id)
        do {
            return try CharacterEntity.objects(for: predicate, context: context).first
        } catch {
            debugPrint("Error getting Characterentity \(#function)  - \(#file)")
            return nil
        }
    }
    
    static func deleteById(_ id: Int64, context: NSManagedObjectContext) {
        let predicate = NSPredicate(format: "mId = %d", id)
        do {
            guard let character = try CharacterEntity.objects(for: predicate, context: context).first else { return }
            context.delete(character)
        } catch {
            debugPrint("Error getting Characterentity \(#function)  - \(#file)")
        }
    }
}

// MARK: - Fetchable
extension CharacterEntity: Fetchable {
    enum AttributeName : String { case name }
}
