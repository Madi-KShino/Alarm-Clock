//
//  Alarm.swift
//  AlarmClock
//
//  Created by Madison Kaori Shino on 6/17/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import Foundation

class Alarm: Codable {
    var alarmName: String
    var fireDate: Date
    var alarmEnabled: Bool
    var uuid: String
    var fireTimeAsString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        return dateFormatter.string(from: fireDate)
    }
    init(fireDate: Date = Date(), alarmName: String, alarmEnabled: Bool = true, uuid: String = UUID().uuidString) {
        self.fireDate = fireDate
        self.alarmName = alarmName
        self.alarmEnabled = alarmEnabled
        self.uuid = uuid
    }
}

extension Alarm: Equatable {
    static func ==(lhs: Alarm, rhs: Alarm) -> Bool {
        return lhs.alarmName == rhs.alarmName &&
            lhs.fireDate == rhs.fireDate 
    }
}
