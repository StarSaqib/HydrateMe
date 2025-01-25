//
//  LogsViewController.swift
//  Hydrate Me
//
//  Created by admin on 24/1/25.
//

import UIKit

class LogsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var popupBackgroundView: UIView!
    @IBOutlet weak var popupView: UIView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var unitMLCountLabel: UILabel!
    @IBOutlet weak var resultCountLabel: UILabel!
    @IBOutlet weak var noRecordsFound: UILabel!
    
    @IBOutlet weak var unitQuantityField: UITextField!
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    var logs = [LogsModel]()
    var units = [UnitModel(type: "glass", imageName: "Glass250ml", value: 250, label: "250ml"),
                 UnitModel(type: "bottle", imageName: "Bottle1L", value: 1000, label: "1000ml"),
                 UnitModel(type: "large bottle", imageName: "Bottle2L", value: 2000, label: "2000ml"),
                 UnitModel(type: "very large bottle", imageName: "Bottle2.5L", value: 2500, label: "2500ml")]
    
    var selectedUnitValue = 0
    var resultCount = 0
    var selectedUnitType = ""
    
    var selectedLogId:Int64 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        addBtn.dropShadow()
        updateBtn.dropShadow()
        deleteBtn.dropShadow()
        popupView.dropShadow()
        datePicker.maximumDate = Date()
        unitQuantityField.addTarget(self, action: #selector(handleTextChanged(_:)), for: .editingChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        reloadTableView()
    }
    
    @objc func handleTextChanged(_ textField: UITextField) {
        setResultLabel()
    }
    
    func setResultLabel() {
        let unitCount = Double(selectedUnitValue)
        if let unitQuantitytString = unitQuantityField.text,
            let unitQuantity = Double(unitQuantitytString) {
            resultCount = Int(unitCount * unitQuantity)
            resultCountLabel.text = "\(resultCount)"
        }
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func saveLog() -> Bool {
        let logModel = LogsModel(id: Int64(Date().timeIntervalSince1970),
                                 date: datePicker.date,
                                 unitType: selectedUnitType,
                                 unitValue: selectedUnitValue,
                                 waterIntake: resultCount)
        return LogsEntity.saveLogToCoreData(logsModel: logModel)
    }
    
    func updateLog() -> Bool {
        let logModel = LogsModel(id: selectedLogId,
                                 date: datePicker.date,
                                 unitType: selectedUnitType,
                                 unitValue: selectedUnitValue,
                                 waterIntake: resultCount)
        return LogsEntity.updateLogInCoreData(logsModel: logModel)
    }
    
    func deleteLog() -> Bool {
        return LogsEntity.deleteLogRecord(id: selectedLogId)
    }
    
    func reloadTableView() {
        logs = LogsEntity.fetchLogsFromCoreData()
        noRecordsFound.isHidden = (logs.count > 0)
        tableView.reloadData()
    }
    
    func showAlert(for message: String) {
        let aleart = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        aleart.addAction(okAction)
        self.present(aleart, animated: true)
    }
    

    @IBAction func didTapAddButton(_ sender: UIButton) {
        let isDone = saveLog()
        if isDone {
            showAlert(for: "Log saved successfully!!")
        } else {
            showAlert(for: "Failed to save, please try again")
        }
        reloadTableView()
        popupBackgroundView.isHidden = true
    }
    
    @IBAction func didTapUpdateButton(_ sender: UIButton) {
        let isDone = updateLog()
        if isDone {
            showAlert(for: "Log updated successfully!!")
        } else {
            showAlert(for: "Failed to update, please try again")
        }
        reloadTableView()
        popupBackgroundView.isHidden = true
    }
    
    @IBAction func didTapDeleteButton(_ sender: UIButton) {
        let isDone = deleteLog()
        if isDone {
            showAlert(for: "Log deleted successfully!!")
        } else {
            showAlert(for: "Failed to delete, please try again")
        }
        reloadTableView()
        popupBackgroundView.isHidden = true
    }
    
    @IBAction func didTapClosePopup(_ sender: UIButton) {
        popupBackgroundView.isHidden = true
    }
    
    @IBAction func didTapAddLogButton(_ sender: UIButton) {
        addBtn.isHidden = false
        updateBtn.isHidden = true
        deleteBtn.isHidden = true
        popupBackgroundView.isHidden = false
    }
    
}

extension LogsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogsTableViewCell", for: indexPath) as! LogsTableViewCell
        let log = logs[indexPath.row]
        let targetIntake = UserDefaults.standard.integer(forKey: TARGET_INTAKE)
        let hydrationStatus = Utilities.getHydrationStatus(waterIntake: log.waterIntake)
        cell.waterIntakeLabel.text = "\(log.waterIntake)ml"
        cell.intakeTargetLabel.text = "\(targetIntake)ml"
        cell.durationLabel.text = Utilities.getDateLabel(with: log.date)
        cell.hydrationStatus.text = hydrationStatus
        cell.containerView.backgroundColor = Utilities.getHydrationStatusColor(status: hydrationStatus)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let log = logs[indexPath.row]
        selectedLogId = log.id
        datePicker.date = log.date
        unitMLCountLabel.text = "\(log.unitValue)"
        resultCountLabel.text = "\(log.waterIntake)"
        unitQuantityField.text = "\(Double(log.waterIntake)/Double(log.unitValue))"
        selectedUnitValue = log.unitValue
        selectedUnitType = log.unitType
        setResultLabel()
        addBtn.isHidden = true
        updateBtn.isHidden = false
        deleteBtn.isHidden = false
        popupBackgroundView.isHidden = false
    }
    
    
}

extension LogsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return units.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LogsCollectionViewCell", for: indexPath) as! LogsCollectionViewCell
        let unit = units[indexPath.row]
        cell.imageView.image = UIImage(named: unit.imageName)
        cell.unitLabel.text = unit.label
        cell.contentView.dropShadow()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let unit = units[indexPath.row]
        selectedUnitValue = unit.value
        selectedUnitType = unit.type
        self.unitMLCountLabel.text = "\(selectedUnitValue)"
        setResultLabel()
    }
    
}
