//
//  Utility.swift
//  That Plan
//
//  Created by Jiyoung Park on 3/5/25.
//

struct Utility {
    static func formattedTime(hour: Int, minute: Int) -> String {
        let ampm = hour >= 12 ? "pm" : "am"
        let formattedHour = hour % 12 == 0 ? 12 : hour % 12
        let formattedMinute = String(format: "%02d", minute)
        return "\(String(format: "%02d", formattedHour)):\(formattedMinute) \(ampm)"
    }
}
