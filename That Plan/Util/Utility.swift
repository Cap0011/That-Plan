//
//  Utility.swift
//  That Plan
//
//  Created by Jiyoung Park on 3/5/25.
//

import Foundation

struct Utility {
    static func formattedTime(hour: Int, minute: Int) -> String {
        let ampm = hour >= 12 ? "pm" : "am"
        let formattedHour = hour % 12 == 0 ? 12 : hour % 12
        let formattedMinute = String(format: "%02d", minute)
        return "\(String(format: "%02d", formattedHour)):\(formattedMinute) \(ampm)"
    }
    
    static func sortedTasks(tasks: [CDTask], date: Date) -> [CDTask] {
        return tasks.filter { $0.type == TaskType.todo.text && Calendar.current.isDate($0.date ?? Date(), inSameDayAs: date) }.sorted {
            if $0.hour < 0 {
                if $1.hour < 0 {
                    return $0.createdAt ?? Date() < $1.createdAt ?? Date()
                }
                return true
            }
            
            if $1.hour < 0 {
                return false
            }
            
            return $0.hour == $1.hour ? $0.minute < $1.minute : $0.hour < $1.hour
        }
    }
}
