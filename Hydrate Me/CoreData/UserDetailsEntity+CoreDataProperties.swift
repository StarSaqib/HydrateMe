//
//  UserDetailsEntity+CoreDataProperties.swift
//  Hydrate Me
//
//  Created by admin on 25/1/25.
//
//

import Foundation
import CoreData


extension UserDetailsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserDetailsEntity> {
        return NSFetchRequest<UserDetailsEntity>(entityName: "UserDetailsEntity")
    }

    @NSManaged public var userName: String?
    @NSManaged public var age: Int32

}

extension UserDetailsEntity : Identifiable {

}
