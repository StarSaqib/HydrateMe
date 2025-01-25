//
//  HomeViewController.swift
//  Hydrate Me
//
//  Created by admin on 25/1/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var clearDataBtn: UIButton!
    
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var hydrationStatusLabel: UILabel!
    @IBOutlet weak var solutionLabel: UILabel!
    @IBOutlet weak var waterDrunkLabel: UILabel!
    @IBOutlet weak var drinkLeftLabel: UILabel!
    
    @IBOutlet weak var hydrationProgressView: UIProgressView!
    
    @IBOutlet weak var hydrationStatusView: UIView!
    @IBOutlet weak var cardView: UIView!
    
    var userDetailsViewModel: UserDetailsViewModel!
    
    var targetIntake = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateProgress()
    }
    
    func setupUI() {
        clearDataBtn.dropShadow()
        hydrationStatusView.dropShadow()
        cardView.dropShadow()
        
        if let userDetails = UserDetailsEntity.fetchUserDetailsFromCoreData(),
            let userName = userDetails.userName {
            greetingLabel.text = "Hi \(userName),"
        }
        
        targetIntake = Int(UserDefaults.standard.integer(forKey: TARGET_INTAKE))
        drinkLeftLabel.text = "Left: \(targetIntake)ml"
    }
    
    func updateProgress() {
        if let todaysLog = LogsEntity.fetchLogsFromCoreData().first {
            
            let hydrationStatus = Utilities.getHydrationStatus(waterIntake: todaysLog.waterIntake)
            hydrationStatusLabel.text = hydrationStatus
            hydrationStatusView.backgroundColor = Utilities.getHydrationStatusColor(status: hydrationStatus)
            waterDrunkLabel.text = "Drunk: \(todaysLog.waterIntake)ml"
            drinkLeftLabel.text = "Left: \(targetIntake - todaysLog.waterIntake)ml"
            hydrationProgressView.progress = Float(todaysLog.waterIntake) / Float(targetIntake)
            solutionLabel.text = "What you should do? = \(Utilities.getSolutionLabel(status: hydrationStatus))"
            solutionLabel.textColor = Utilities.getSolutionLabelColor(status: hydrationStatus)
        }
    }
    
    func moveToUserDetailsVC() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.showUserDetailsScreen()
        }
    }
    
    @IBAction func didTapClearButton(_ sender: UIButton) {
        LogsEntity.deleteAllLogsFromCoreData()
        UserDetailsEntity.deleteUserDetailsFromCoreData()
        moveToUserDetailsVC()
        
    }
    
}
