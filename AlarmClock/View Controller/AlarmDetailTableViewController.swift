//
//  AlarmDetailTableViewController.swift
//  AlarmClock
//
//  Created by Madison Kaori Shino on 6/17/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpAlarmButton()
    }
    
    var alarm: Alarm? {
        didSet {
            loadViewIfNeeded()
            updateView()
        }
    }
    var alarmIsOn = true
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var enableButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func updateView() {
        guard let alarm = alarm else { return }
        alarmIsOn = alarm.alarmEnabled
        datePicker.date = alarm.fireDate
        nameTextField.text = alarm.alarmName
    }
    
    func setUpAlarmButton() {
        switch alarmIsOn {
        case true:
            enableButton.setTitle("ON", for: .normal)
        case false:
            enableButton.setTitle("OFF", for: .normal)
        }
    }
    
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
