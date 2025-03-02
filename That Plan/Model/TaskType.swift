//
//  TaskType.swift
//  That Plan
//
//  Created by Jiyoung Park on 3/2/25.
//

enum TaskType {
    case quick, todo, daily, information, shortterm, future
    
    var text: String {
        switch self {
        case .quick: return "Quick"
        case .todo: return "To-Do"
        case .daily: return "Daily Routine"
        case .information: return "Information"
        case .shortterm: return "Short-term Goal"
        case .future: return "Future Goal"
        }
    }
}
