//
//  MainViewController.swift
//  Hydrate Me
//
//  Created by admin on 25/1/25.
//

import UIKit

class MainTabBarController: RoundedTabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        overrideUserInterfaceStyle = .light
    }
    
    // MARK: - Tab Bar Delegate Method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let generator = UIImpactFeedbackGenerator(style: .soft)
        generator.impactOccurred()
    }
}
