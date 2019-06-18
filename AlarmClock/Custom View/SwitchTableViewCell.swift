//
//  SwitchTableViewCell.swift
//  AlarmClock
//
//  Created by Madison Kaori Shino on 6/17/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

//Define the Delegate Protocol
protocol SwitchCellDelegate: class {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell)
}

class SwitchTableViewCell: UITableViewCell {
    
    //Define the Delegate
    weak var cellDelegate: SwitchCellDelegate?
    
    var alarm: Alarm? {
        didSet {
            guard let alarm = alarm else { return }
            updateViews(alarm: alarm)
        }
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    func updateViews(alarm: Alarm) {
        timeLabel.text = alarm.fireTimeAsString
        nameLabel.text = alarm.alarmName
        alarmSwitch.isOn = alarm.alarmEnabled
    }
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        cellDelegate?.switchCellSwitchValueChanged(cell: self)
    }
}
