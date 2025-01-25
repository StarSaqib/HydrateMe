//
//  Utilities.swift
//  Hydrate Me
//
//  Created by admin on 25/1/25.
//

import Foundation
import UIKit

class Utilities: NSObject {
    
    class func getDateString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: date)
    }
    
    class func getDateLabel(with date: Date) -> String {
        let calendar = Calendar.current
        let today = Date()
        
        if calendar.isDateInToday(date) {
            return "Today"
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            return dateFormatter.string(from: date)
        }
    }
    
    class func getHydrationStatus(waterIntake:Int) -> String {
        let targetIntake = UserDefaults.standard.integer(forKey: TARGET_INTAKE)
        let result:Double = Double(waterIntake) / Double(targetIntake)
        return getHydrationStatus(for: result)
    }
    
    class func getHydrationStatus(for level: Double) -> String {
        switch level {
        case 0.0..<0.3:
            return "Very Dehydrated"
        case 0.3..<0.6:
            return "Dehydrated"
        case 0.6..<0.9:
            return "Hydrated"
        case 0.9...1.0:
            return "Fully Hydrated"
        default:
            return "Over Hydrated"
        }
    }
    
    class func getHydrationStatusColor(status: String) -> UIColor {
        switch status {
        case "Very Dehydrated":
            return #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        case "Dehydrated":
            return #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        case "Hydrated":
            return #colorLiteral(red: 0.9764705896, green: 0.8339210643, blue: 0.5877215552, alpha: 1)
        case "Fully Hydrated":
            return #colorLiteral(red: 1, green: 0.9306758058, blue: 0.7227032231, alpha: 1)
        default:
            return #colorLiteral(red: 0.9764705896, green: 0.9375514452, blue: 0.8992886526, alpha: 1)
        }
    }
    
    class func getSolutionLabel(status: String) -> String {
        switch status {
        case "Very Dehydrated":
            return "Drink a large bottle of water immediately."
        case "Dehydrated":
            return "Drink 2-3 glassess of water now."
        case "Hydrated":
            return "Drink a glass of water now."
        case "Fully Hydrated":
            return "Keep drinking at the same rate."
        case "Over Hydrated":
            return "Control drinking little bit."
        default:
            return "Drink a large bottle of water immediately."
        }
    }
    
    class func getSolutionLabelColor(status: String) -> UIColor {
        switch status {
        case "Very Dehydrated":
            return UIColor.red
        case "Dehydrated":
            return UIColor.orange
        case "Hydrated":
            return UIColor.green
        case "Fully Hydrated":
            return UIColor.green
        default:
            return UIColor.green
        }
    }
    
}
