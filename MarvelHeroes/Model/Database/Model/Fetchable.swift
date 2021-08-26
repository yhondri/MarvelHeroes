//
//  Fetchable.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 24/8/21.
//

import Foundation
import CoreData

// Code from: https://github.com/stklieme/Fetchable/blob/master/Fetchable.swift (created by stklieme modified by Yhondri).

protocol Fetchable {
    associatedtype FetchableType: NSManagedObject = Self
    associatedtype AttributeName: RawRepresentable
    
    static var entityName : String { get }

    static func objects(context: NSManagedObjectContext) throws -> [FetchableType]
    static func objects(for predicate: NSPredicate?, sortedBy: AttributeName?, ascending: Bool, fetchLimit: Int, context: NSManagedObjectContext) throws -> [FetchableType]
    static func objects(sortedBy sortDescriptors: [NSSortDescriptor], predicate: NSPredicate?, fetchLimit: Int, context: NSManagedObjectContext) throws -> [FetchableType]
}

extension Fetchable where Self : NSManagedObject, AttributeName.RawValue == String {
    /// Returns the entity name for the current class.
    
    static var entityName : String {
        return String(describing:self)
    }
    
    
    /// Returns the fetched objects of the current entity
    ///
    /// - Returns: A non-optional array of objects of the current NSManagedObject subclass.
    
    static func objects(context: NSManagedObjectContext) throws -> [FetchableType] {
        let request = fetchRequest(predicate: nil, sortedBy: nil, ascending:true, fetchLimit: 0)
        return try context.fetch(request)
    }
    
    
    /// Returns the fetched objects of the current entity for the given parameters, sorted by one key
    ///
    /// - Parameters:
    ///   - predicate: The fetch predicate (optional, default is nil).
    ///   - sortedBy: The key to sort the result (optional, default is not sorted).
    ///   - ascending: The sorting direction (optional, default is ascending).
    ///   - fetchLimit: The number of items to be fetched (optional, default is no limit).
    /// - Returns: A non-optional array of objects of the current NSManagedObject subclass.
    
    static func objects(for predicate: NSPredicate? = nil,
                        sortedBy: AttributeName? = nil,
                        ascending: Bool = true,
                        fetchLimit: Int = 0,
                        context: NSManagedObjectContext) throws -> [FetchableType] {
        let request = fetchRequest(predicate: predicate, sortedBy: sortedBy, ascending: ascending, fetchLimit: fetchLimit)
        return try context.fetch(request)
    }
    
    
    /// Returns the fetched objects of the current entity for the given parameters, sorted by an array of sort descriptors.
    ///
    /// - Parameters:
    ///   - sortDescriptors: an array of sort descriptors.
    ///   - predicate: The fetch predicate (optional, default is nil).
    ///   - fetchLimit: the number of items to be fetched (optional, default is no limit).
    /// - Returns: A non-optional array of objects of the current NSManagedObject subclass.
    
    static func objects(sortedBy sortDescriptors: [NSSortDescriptor],
                        predicate: NSPredicate? = nil,
                        fetchLimit: Int = 0,
                        context: NSManagedObjectContext) throws -> [FetchableType] {
        let request = fetchRequest(predicate: predicate, sortDescriptors: sortDescriptors, fetchLimit: fetchLimit)
        return try context.fetch(request)
    }
    
    /// Returns the fetched objects of the current entity for the given parameters, sorted by an array of tuples representing 'key' and 'ascending' parameter of an NSSortDescriptor.
    ///
    /// - Parameters:
    ///   - sortCriteria: An variadic array of tuples representing 'key' and 'ascending' parameter of an NSSortDescriptor.
    ///   - predicate: The fetch predicate (optional, default is nil).
    ///   - fetchLimit: the number of items to be fetched (optional, default is no limit).
    /// - Returns: A non-optional array of objects of the current NSManagedObject subclass.
    
    
    static func objects(sortedBy sortCriteria: (AttributeName, Bool)...,
                        predicate: NSPredicate? = nil,
                        fetchLimit: Int = 0,
                        context: NSManagedObjectContext) throws -> [FetchableType] {
        let sortDescriptors = sortCriteria.map{ NSSortDescriptor(key: $0.0.rawValue, ascending: $0.1)  }
        let request = fetchRequest(predicate: predicate, sortDescriptors: sortDescriptors, fetchLimit: fetchLimit)
        return try context.fetch(request)
    }
    
    
    /// Returns the first found object of the current entity
    ///
    /// - Returns: The first found object of the current NSManagedObject subclass or nil.
    
    static func object(context: NSManagedObjectContext) throws -> FetchableType? {
        let request = fetchRequest(predicate: nil, sortedBy: nil, ascending:true, fetchLimit: 1)
        return try context.fetch(request).first
    }
    
    
    /// Returns the first found object of the current entity for the given parameters, sorted by one key.
    ///
    /// - Parameters:
    ///   - predicate: The fetch predicate (optional, default is nil).
    ///   - sortedBy: The key to sort the result (optional, default is not sorted).
    ///   - ascending: The sorting direction (optional, default is ascending).
    /// - Returns: The first found object of the current NSManagedObject subclass or nil.
    
    static func object(for predicate: NSPredicate? = nil,
                       sortedBy: AttributeName? = nil,
                       ascending: Bool = true,
                       context: NSManagedObjectContext) throws -> FetchableType? {
        return try objects(for: predicate, sortedBy: sortedBy, ascending: ascending, context: context).first
    }
    
    
    /// Returns the first found object of the current entity for the given predicate, sorted by an array of sort descriptors.
    ///
    /// - Parameters:
    ///   - sortDescriptors: An array of sort descriptors.
    ///   - predicate: The fetch predicate (optional, default is nil).
    /// - Returns: The first found object of the current NSManagedObject subclass or nil.
    
    static func object(sortedBy sortDescriptors: [NSSortDescriptor],
                       predicate: NSPredicate? = nil,
                       context: NSManagedObjectContext) throws -> FetchableType? {
        return try objects(sortedBy: sortDescriptors, predicate: predicate, fetchLimit: 1, context: context).first
    }
    
    
    /// Returns the first found object of the current entity for the given predicate, sorted by an array of tuples representing 'key' and 'ascending' parameter of an NSSortDescriptor.
    ///
    /// - Parameters:
    ///   - sortCriteria: An variadic array of tuples representing 'key' and 'ascending' parameter of an NSSortDescriptor.
    ///   - predicate: The fetch predicate (optional, default is nil).
    /// - Returns: The first found object of the current NSManagedObject subclass or nil.
    
    
   static func object(sortedBy sortCriteria: (AttributeName, Bool)...,
                        predicate: NSPredicate? = nil,
                        context: NSManagedObjectContext) throws -> FetchableType? {
        let sortDescriptors = sortCriteria.map{ NSSortDescriptor(key: $0.0.rawValue, ascending: $0.1)  }
        return try objects(sortedBy: sortDescriptors, predicate: predicate, fetchLimit: 1, context: context).first
    }
    
    /// A Core Data fetch request for the current NSManagedObject subclass for sorting by one key.
    ///
    /// - Parameters:
    ///   - predicate: The fetch predicate (optional, default is nil).
    ///   - sortedBy: The key to sort the result (optional, default is not sorted).
    ///   - ascending: The sorting direction (optional, default is ascending).
    ///   - fetchLimit: The number of items to be fetched (optional, default is no limit).
    /// - Returns: The fetch request for the current NSManagedObject subclass.
    
    private static func fetchRequest(predicate: NSPredicate? = nil,
                             sortedBy: AttributeName? = nil,
                             ascending: Bool = true,
                             fetchLimit: Int = 0) -> NSFetchRequest<FetchableType> {
        let sortDescriptors : [NSSortDescriptor]? = sortedBy != nil ? [NSSortDescriptor(key: sortedBy!.rawValue, ascending: ascending)] : nil
        return fetchRequest(predicate: predicate, sortDescriptors: sortDescriptors, fetchLimit: fetchLimit)
    }
    
    
    /// A Core Data fetch request for the current NSManagedObject subclass for sorting by an array of sort descriptors.
    ///
    /// - Parameters:
    ///   - predicate: The fetch predicate (optional, default is nil).
    ///   - sortDescriptors: An array of sort descriptors (optional, default is not sorted).
    ///   - fetchLimit: The number of items to be fetched (optional, default is no limit).
    /// - Returns: The fetch request for the current NSManagedObject subclass.
    
    private static func fetchRequest(predicate: NSPredicate? = nil,
                             sortDescriptors: [NSSortDescriptor]?,
                             fetchLimit: Int = 0) -> NSFetchRequest<FetchableType> {
        let request = NSFetchRequest<FetchableType>(entityName: entityName)
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        request.fetchLimit = fetchLimit
        return request
    }
}
