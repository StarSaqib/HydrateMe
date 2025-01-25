//
//  LogsEntity+CoreDataClass.swift
//  Hydrate Me
//
//  Created by admin on 25/1/25.
//
//

import Foundation
import CoreData
import UIKit


public class LogsEntity: NSManagedObject {
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    class func saveLogToCoreData(logsModel: LogsModel) -> Bool {
        let logsEntity = LogsEntity(context: context)
        
        logsEntity.id = logsModel.id
        logsEntity.waterIntake = Int64(logsModel.waterIntake)
        logsEntity.date = logsModel.date
        logsEntity.unitValue = Int64(logsModel.unitValue)
        logsEntity.unitType = logsModel.unitType
        
        do {
            try context.save()
            print("Logs saved successfully.")
            return true
        } catch {
            print("Failed to save Logs: \(error.localizedDescription)")
            return false
        }
    }
    
    class func fetchLogsFromCoreData() -> [LogsModel] {
        let fetchRequest: NSFetchRequest<LogsEntity> = LogsEntity.fetchRequest()
        var logsModelArray = [LogsModel]()
        
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let logs = try context.fetch(fetchRequest)
            
            for log in logs {
                let logModel = LogsModel(id: log.id,
                                         date: log.date ?? Date(),
                                         unitType: log.unitType ?? "",
                                         unitValue: Int(log.unitValue),
                                         waterIntake: Int(log.waterIntake))
                logsModelArray.append(logModel)
            }
            return logsModelArray
        } catch {
            print("Failed to fetch Logs: \(error)")
            return logsModelArray
        }
    }
    
    class func updateLogInCoreData(logsModel: LogsModel) -> Bool {
        let fetchRequest: NSFetchRequest<LogsEntity> = LogsEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", logsModel.id)
        
        do {
            let logs = try context.fetch(fetchRequest)
            if let logsEntity = logs.first {
                logsEntity.waterIntake = Int64(logsModel.waterIntake)
                logsEntity.date = logsModel.date
                logsEntity.unitValue = Int64(logsModel.unitValue)
                logsEntity.unitType = logsModel.unitType
                
                do {
                    try context.save()
                    print("Logs updated successfully.")
                    return true
                } catch {
                    print("Failed to update Logs: \(error.localizedDescription)")
                }
            }
        } catch {
            print("Failed to update Logs: \(error.localizedDescription)")
        }
        return false
    }
    
    class func deleteLogRecord(id: Int64) -> Bool {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LogsEntity")
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            if let results = try context.fetch(fetchRequest) as? [NSManagedObject], let objectToDelete = results.first {
                context.delete(objectToDelete)
                
                try context.save()
                print("Log Record deleted successfully")
                return true
            } else {
                print("No matching log record found")
            }
        } catch {
            print("Failed to delete log record: \(error.localizedDescription)")
        }
        return false
    }
    
    class func deleteAllLogsFromCoreData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = LogsEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            // Execute the batch delete request
            try context.execute(deleteRequest)
            
            // Save the context to persist the changes
            try context.save()
            print("All Logs deleted successfully.")
        } catch {
            print("Failed to delete all Logs: \(error)")
        }
    }
}
