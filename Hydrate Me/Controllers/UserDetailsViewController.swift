//
//  UserDetailsViewController.swift
//  Hydrate Me
//
//  Created by admin on 25/1/25.
//

import UIKit

class UserDetailsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var proceedBtn: UIButton!
    
    private var userDetailsViewModel : UserDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        userNameField.delegate = self
        ageField.delegate = self
        ageField.returnKeyType = .done
        proceedBtn.dropShadow()
        
        self.userDetailsViewModel =  UserDetailsViewModel()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    func presentHomeVC() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.showMainScreen()
        }
    }
    
    
    @IBAction func didTapProceed(_ sender: UIButton) {
        if let userName = userNameField.text, !userName.isEmpty,
           let ageString = ageField.text, !ageString.isEmpty,
            let age = Int(ageString) {
            self.userDetailsViewModel.saveUserDetails(userName: userName, age: age)
            presentHomeVC()
        } else {
            errorLabel.isHidden = false
        }
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Resign first responder when return or done is pressed
        textField.resignFirstResponder()
        return true
    }

}
