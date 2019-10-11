//
//  AlarmDetailTableViewController.swift
//  AlarmClock
//
//  Created by Madison Kaori Shino on 6/17/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {

    //PROPERTIES
    var alarm: Alarm? {
        didSet {
            loadViewIfNeeded()
            updateView()
        }
    }
    var alarmIsOn = true
    
    //OUTLETS
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var enableButton: UIButton!
    
    //LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpAlarmButton()
    }

    //HELPER FUNCTIONS
    private func updateView() {
        if let alarm = alarm {
            alarmIsOn = alarm.alarmEnabled
            datePicker.date = alarm.fireDate
            nameTextField.text = alarm.alarmName
            navigationItem.title = alarm.alarmName
        } else {
            navigationItem.title = "New Alarm"
        }
    }
    
    func setUpAlarmButton() {
        switch alarmIsOn {
        case true:
            enableButton.setTitle("TURN OFF", for: .normal)
        case false:
            enableButton.setTitle("TURN ON", for: .normal)
        }
    }
    
    func setViewComponents() {
        view.backgroundColor = .black
        enableButton.layer.borderColor = #colorLiteral(red: 1, green: 0.5931261182, blue: 0.1643602252, alpha: 1)
        enableButton.layer.borderWidth = 4
        enableButton.layer.cornerRadius = enableButton.frame.height / 2
        datePicker.layer.borderWidth = 2
        datePicker.layer.cornerRadius = 10
        datePicker.layer.borderColor = #colorLiteral(red: 1, green: 0.5932606459, blue: 0.1740602553, alpha: 1)
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        nameTextField.backgroundColor = #colorLiteral(red: 0.2004078329, green: 0.1992231905, blue: 0.201322794, alpha: 1)
        nameTextField.textColor = .white
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Name Your Alarm",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
    //ACTIONS
    @IBAction func enableButtonTapped(_ sender: Any) {
        alarmIsOn = !alarmIsOn
        setUpAlarmButton()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let alarmName = nameTextField.text
            else { return }
        if let alarm = alarm {
            AlarmController.sharedInstance.updateAlarmOfType(alarm: alarm, with: alarmName, fireDate: datePicker.date, isEnabled: alarmIsOn)
        } else {
            AlarmController.sharedInstance.addAlarmWith(fireDate: datePicker.date, name: alarmName, isEnabled: alarmIsOn)
        }
        navigationController?.popViewController(animated: true)
    }
}
