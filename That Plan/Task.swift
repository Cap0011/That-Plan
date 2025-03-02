//
//  Task.swift
//  That Plan
//
//  Created by Jiyoung Park on 3/2/25.
//

import Foundation

struct Task {
    let id: UUID
    var type: String
    var contents: String
    var date: Date?
    var hour: Int?
    var minute: Int?
    var isNotificationOn: Bool?
    var isCompleted: Bool?
    var parentTaskId: UUID?
    var childTaskIds: [UUID] = []
}
