//
//  SwitchTableViewCell.swift
//  AlarmClock
//
//  Created by Madison Kaori Shino on 6/17/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

//DELEGATE PROTOCOL
protocol SwitchCellDelegate: class {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell)
}

//CLASS
class SwitchTableViewCell: UITableViewCell {
    
    //DEFINE DELEGATE
    weak var cellDelegate: SwitchCellDelegate?
    
    var alarm: Alarm? {
        didSet {
            guard let alarm = alarm else { return }
            updateViews(alarm: alarm)
        }
    }
    
    //OUTLETS
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    //CHANGE VIEW (depending on alarm object properties)
    func updateViews(alarm: Alarm) {
        timeLabel.text = alarm.fireTimeAsString
        nameLabel.text = alarm.alarmName
        alarmSwitch.isOn = alarm.alarmEnabled
        if alarmSwitch.isOn == true {
            nameLabel.textColor = .white
            timeLabel.textColor = .white
        } else {
            nameLabel.textColor = .lightGray
            timeLabel.textColor = .lightGray
        }
    }
    
    //ACTIONS
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        cellDelegate?.switchCellSwitchValueChanged(cell: self)
    }
}
