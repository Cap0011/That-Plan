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
    
    var description: String {
        switch self {
        case .quick: return "Quick: Please select the most suitable category for this task."
        case .todo: return "Todo: Please select the most suitable category for this task."
        case .daily: return "Daily: Please select the most suitable category for this task."
        case .information: return "Information: Please select the most suitable category for this task."
        case .shortterm: return "Short term: Please select the most suitable category for this task."
        case .future: return "Future: Please select the most suitable category for this task."
        }
    }
    
    static func fromText(_ text: String) -> TaskType? {
        switch text.lowercased() {
        case "quick": return .quick
        case "to-do": return .todo
        case "daily routine": return .daily
        case "information": return .information
        case "short-term goal": return .shortterm
        case "future goal": return .future
        default: return nil
        }
    }
}
