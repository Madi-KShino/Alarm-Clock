//
//  AlarmController.swift
//  AlarmClock
//
//  Created by Madison Kaori Shino on 6/17/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import Foundation

class AlarmController {
    
    //SINGLETON
    static let sharedInstance = AlarmController()
    
    //SOURCE OF TRUTH
    var alarms = [Alarm]()
    
    init() {
        loadFromPersistentStore()
    }
    
    //EDITING FUNCTIONS
    func addAlarmWith(fireDate: Date, name: String, isEnabled: Bool) {
        let newAlarm = Alarm(fireDate: fireDate, alarmName: name, alarmEnabled: isEnabled)
        alarms.append(newAlarm)
        saveToPersistentStore()
    }
    func updateAlarmOfType(alarm: Alarm, with oldName: String, fireDate: Date, isEnabled: Bool) {
        alarm.alarmName = oldName
        alarm.fireDate = fireDate
        alarm.alarmEnabled = isEnabled
        saveToPersistentStore()
    }
    func deleteAlarm(alarmToDelete: Alarm) {
        if let alarmIndex = alarms.firstIndex(of: alarmToDelete) {
            alarms.remove(at: alarmIndex)
            saveToPersistentStore()
        }
    }
    func toggleEnabled(for alarm: Alarm) {
        alarm.alarmEnabled = !alarm.alarmEnabled
    }
    
    //PERSISTENCE FUNCTIONS
    func saveToPersistentStore() {
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(alarms)
            try data.write(to: fileURL())
        } catch let error {
            print("Error saving to persistent store: \(error.localizedDescription)")
        }
    }
    
    func loadFromPersistentStore() {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let decodedAlarms = try jsonDecoder.decode([Alarm].self, from: data)
            alarms = decodedAlarms
        } catch let error {
            print("Error loading from persistent store: \(error.localizedDescription)")
        }
    }
    
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let fileName = "alarmClock.json"
        let url = documentDirectory.appendingPathComponent(fileName)
        return url
    }
}
