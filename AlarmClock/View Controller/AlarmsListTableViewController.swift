//
//  AlarmsListTableViewController.swift
//  AlarmClock
//
//  Created by Madison Kaori Shino on 6/17/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class AlarmsListTableViewController: UITableViewController {
   
    //LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    //TABLE VIEW DATA
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.sharedInstance.alarms.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? SwitchTableViewCell else { return UITableViewCell() }
        let alarmToDisplay = AlarmController.sharedInstance.alarms[indexPath.row]
        //set delegate
        cell.cellDelegate = self
        cell.updateViews(alarm: alarmToDisplay)
        return cell
    }

   //DELETE EDITING
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alarmToRemove = AlarmController.sharedInstance.alarms[indexPath.row]
            AlarmController.sharedInstance.deleteAlarm(alarmToDelete: alarmToRemove)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    //SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAlarmDetailViewController", let indexPath = tableView.indexPathForSelectedRow {
            let destinationVC = segue.destination as? AlarmDetailTableViewController
            let alarmToShow = AlarmController.sharedInstance.alarms[indexPath.row]
            destinationVC?.alarm = alarmToShow
        }
    }
}

//CONFORM TO PROTOCOL
extension AlarmsListTableViewController: SwitchCellDelegate {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let alarm = AlarmController.sharedInstance.alarms[indexPath.row]
        AlarmController.sharedInstance.toggleEnabled(for: alarm)
        cell.updateViews(alarm: alarm)
    }
}
