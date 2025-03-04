//
//  Tab.swift
//  That Plan
//
//  Created by Jiyoung Park on 3/4/25.
//

enum Tab {
    case today
    case planner
    case settings
    
    var imageName: String {
        switch self {
        case .today: return "today"
        case .planner: return "planner"
        case .settings: return "settings"
        }
    }
    
    var title: String {
        switch self {
        case .today: return "Today"
        case .planner: return "Planner"
        case .settings: return "Settings"
        }
    }
}

