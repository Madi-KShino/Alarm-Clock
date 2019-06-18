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
    func switchCellSwitchValueChanged(for cell: SwitchTableViewCell)
}

class SwitchTableViewCell: UITableViewCell {

    var alarm: Alarm? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    //Define the Delegate
    weak var delegate: SwitchCellDelegate?
    
    func updateViews() {
        guard let alarm = alarm else { return }
        timeLabel.text = alarm.fireTimeAsString
        nameLabel.text = alarm.alarmName
        alarmSwitch.isOn = alarm.alarmEnabled
    }
    

    @IBAction func switchValueChanged(_ sender: Any) {
        delegate?.switchCellSwitchValueChanged(for: self)
    }
    
}
