//
//  UserDetailsEntity+CoreDataClass.swift
//  Hydrate Me
//
//  Created by admin on 25/1/25.
//
//

import Foundation
import CoreData
import UIKit


public class UserDetailsEntity: NSManagedObject {
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    class func saveUserDetailsToCoreData(userDetailsModel: UserDetailsModel) {
        let userDetailsEntity = UserDetailsEntity(context: context)
        
        userDetailsEntity.userName = userDetailsModel.name
        userDetailsEntity.age = Int32(userDetailsModel.age)
        
        do {
            try context.save()
            print("UserDetails saved successfully.")
        } catch {
            print("Failed to save UserDetails: \(error.localizedDescription)")
        }
    }
    
    class func fetchUserDetailsFromCoreData() -> UserDetailsEntity? {
        let fetchRequest: NSFetchRequest<UserDetailsEntity> = UserDetailsEntity.fetchRequest()
        
        do {
            let userDetails = try context.fetch(fetchRequest)
            return userDetails.last
        } catch {
            print("Failed to fetch UserDetails: \(error)")
            return nil
        }
    }
    
    class func deleteUserDetailsFromCoreData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = UserDetailsEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            // Execute the batch delete request
            try context.execute(deleteRequest)
            
            // Save the context to persist the changes
            try context.save()
            print("All UserDetails deleted successfully.")
        } catch {
            print("Failed to delete all UserDetails: \(error)")
        }
    }
}
