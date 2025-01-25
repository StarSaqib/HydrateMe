//
//  LogsEntity+CoreDataProperties.swift
//  Hydrate Me
//
//  Created by admin on 25/1/25.
//
//

import Foundation
import CoreData


extension LogsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LogsEntity> {
        return NSFetchRequest<LogsEntity>(entityName: "LogsEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var waterIntake: Int64
    @NSManaged public var date: Date?
    @NSManaged public var unitValue: Int64
    @NSManaged public var unitType: String?

}

extension LogsEntity : Identifiable {

}
