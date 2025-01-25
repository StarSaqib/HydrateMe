//
//  UserDetailsViewModel.swift
//  Hydrate Me
//
//  Created by admin on 25/1/25.
//

import Foundation
import UIKit

class UserDetailsViewModel : NSObject {
    
    override init() {
        super.init()
    }
    
    private(set) var userData : UserDetailsModel? {
        didSet {
            self.bindUserDetailsViewModelToController()
        }
    }
        
    var bindUserDetailsViewModelToController : (() -> ()) = {}
    
    func saveUserDetails(userName:String, age:Int) {
        let userDetails = UserDetailsModel(name: userName, age: Int(age))
        UserDetailsEntity.saveUserDetailsToCoreData(userDetailsModel: userDetails)
        setTargetIntake(age: age)
    }
    
    func isUserExist() -> Bool {
        if UserDetailsEntity.fetchUserDetailsFromCoreData() != nil {
            return true
        } else {
            return false
        }
    }
    
    func setTargetIntake(age:Int) {
        var targetIntake:Int = 0
        switch age {
        case 1...3: targetIntake = 1300
            break
        case 4...8: targetIntake = 1700
            break
        case 9...13: targetIntake = 2400
            break
        case 14...18: targetIntake = 3300
            break
        case 19...50: targetIntake = 3700
            break
        default:
            targetIntake = 3700
        }
        
        UserDefaults.standard.set(targetIntake, forKey: TARGET_INTAKE)
    }
}
