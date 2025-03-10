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

extension Task {
    init(cdTask: CDTask) {
        self.id = cdTask.id ?? UUID()
        self.type = cdTask.type ?? ""
        self.contents = cdTask.contents ?? ""
        self.date = cdTask.date
        self.hour = Int(cdTask.hour)
        self.minute = Int(cdTask.minute)
        self.isNotificationOn = cdTask.isNotificationOn
        self.isCompleted = cdTask.isCompleted
    }
}

extension Task {
    static let quickTasks: [Task] = [
        Task(id: UUID(), type: TaskType.quick.text, contents: "Buy groceries", date: Calendar.current.date(byAdding: .day, value: -2, to: Date()), hour: 10, minute: 30, isNotificationOn: true, isCompleted: false),
        Task(id: UUID(), type: TaskType.quick.text, contents: "Call mom", date: Calendar.current.date(byAdding: .day, value: 1, to: Date()), hour: 15, minute: 0, isNotificationOn: true, isCompleted: false),
        Task(id: UUID(), type: TaskType.quick.text, contents: "Reply to emails", date: Calendar.current.date(byAdding: .day, value: -3, to: Date()), hour: 9, minute: 45, isNotificationOn: false, isCompleted: false),
        Task(id: UUID(), type: TaskType.quick.text, contents: "Take medicine", date: Calendar.current.date(byAdding: .day, value: 0, to: Date()), hour: 8, minute: 0, isNotificationOn: true, isCompleted: true),
        Task(id: UUID(), type: TaskType.quick.text, contents: "Check schedule", date: Calendar.current.date(byAdding: .day, value: -5, to: Date()), hour: 7, minute: 30, isNotificationOn: false, isCompleted: false),
        Task(id: UUID(), type: TaskType.quick.text, contents: "Charge phone", date: Calendar.current.date(byAdding: .day, value: 3, to: Date()), hour: 22, minute: 0, isNotificationOn: false, isCompleted: true),
        Task(id: UUID(), type: TaskType.quick.text, contents: "Clean desk", date: Calendar.current.date(byAdding: .day, value: -4, to: Date()), hour: 20, minute: 0, isNotificationOn: false, isCompleted: false),
        Task(id: UUID(), type: TaskType.quick.text, contents: "Make coffee", date: Calendar.current.date(byAdding: .day, value: 2, to: Date()), hour: 7, minute: 15, isNotificationOn: false, isCompleted: true),
        Task(id: UUID(), type: TaskType.quick.text, contents: "Read article", date: Calendar.current.date(byAdding: .day, value: -5, to: Date()), hour: 17, minute: 45, isNotificationOn: false, isCompleted: false),
        Task(id: UUID(), type: TaskType.quick.text, contents: "Listen to music", date: Calendar.current.date(byAdding: .day, value: -5, to: Date()), hour: 18, minute: 30, isNotificationOn: false, isCompleted: true)
    ]

    
    static let informationTasks: [Task] = [
        Task(id: UUID(), type: TaskType.information.text, contents: "Read company updates", date: Date(), hour: 9, minute: 0, isNotificationOn: false, isCompleted: false),
        Task(id: UUID(), type: TaskType.information.text, contents: "Check latest news", date: Date(), hour: 12, minute: 0, isNotificationOn: false, isCompleted: false),
        Task(id: UUID(), type: TaskType.information.text, contents: "Review meeting notes", date: Date(), hour: 14, minute: 15, isNotificationOn: false, isCompleted: false),
        Task(id: UUID(), type: TaskType.information.text, contents: "Read financial report", date: Date(), hour: 16, minute: 0, isNotificationOn: false, isCompleted: false),
        Task(id: UUID(), type: TaskType.information.text, contents: "Check industry trends", date: Date(), hour: 10, minute: 45, isNotificationOn: false, isCompleted: false),
        Task(id: UUID(), type: TaskType.information.text, contents: "Watch educational video", date: Date(), hour: 18, minute: 30, isNotificationOn: false, isCompleted: false),
        Task(id: UUID(), type: TaskType.information.text, contents: "Research new tools", date: Date(), hour: 20, minute: 0, isNotificationOn: false, isCompleted: false),
        Task(id: UUID(), type: TaskType.information.text, contents: "Read user feedback", date: Date(), hour: 11, minute: 30, isNotificationOn: false, isCompleted: false),
        Task(id: UUID(), type: TaskType.information.text, contents: "Check competitor analysis", date: Date(), hour: 13, minute: 15, isNotificationOn: false, isCompleted: false),
        Task(id: UUID(), type: TaskType.information.text, contents: "Study market data", date: Date(), hour: 15, minute: 45, isNotificationOn: false, isCompleted: false)
    ]
    
    static let shortTermTasks: [Task] = [
        Task(id: UUID(), type: TaskType.shortterm.text, contents: "Submit assignment", date: Date(), hour: 23, minute: 59, isNotificationOn: true, isCompleted: false),
        Task(id: UUID(), type: TaskType.shortterm.text, contents: "Book flight tickets", date: Date(), hour: 17, minute: 30, isNotificationOn: true, isCompleted: false),
        Task(id: UUID(), type: TaskType.shortterm.text, contents: "Apply for internship", date: Date(), hour: 10, minute: 0, isNotificationOn: true, isCompleted: false),
        Task(id: UUID(), type: TaskType.shortterm.text, contents: "Prepare for exam", date: Date(), hour: 21, minute: 0, isNotificationOn: true, isCompleted: false),
        Task(id: UUID(), type: TaskType.shortterm.text, contents: "Start fitness challenge", date: Date(), hour: 8, minute: 30, isNotificationOn: true, isCompleted: false),
        Task(id: UUID(), type: TaskType.shortterm.text, contents: "Finish reading book", date: Date(), hour: 22, minute: 0, isNotificationOn: true, isCompleted: false),
        Task(id: UUID(), type: TaskType.shortterm.text, contents: "Organize workspace", date: Date(), hour: 14, minute: 30, isNotificationOn: false, isCompleted: false),
        Task(id: UUID(), type: TaskType.shortterm.text, contents: "Start online course", date: Date(), hour: 19, minute: 0, isNotificationOn: false, isCompleted: false),
        Task(id: UUID(), type: TaskType.shortterm.text, contents: "Update resume", date: Date(), hour: 16, minute: 0, isNotificationOn: false, isCompleted: false),
        Task(id: UUID(), type: TaskType.shortterm.text, contents: "Plan weekend trip", date: Date(), hour: 11, minute: 45, isNotificationOn: false, isCompleted: false)
    ]
    
    static let dailyTasks: [Task] = [
        Task(id: UUID(), type: TaskType.daily.text, contents: "🍵 Meditation paper + warm tea.", date: Date(), hour: 7, minute: 0, isNotificationOn: true, isCompleted: false),
        Task(id: UUID(), type: TaskType.daily.text, contents: "🎧 30-minute walk outside.", date: Date(), hour: 18, minute: 30, isNotificationOn: true, isCompleted: false),
        Task(id: UUID(), type: TaskType.daily.text, contents: "🧘 Yoga session.", date: Date(), hour: 6, minute: 30, isNotificationOn: false, isCompleted: false),
        Task(id: UUID(), type: TaskType.daily.text, contents: "📖 Read a book.", date: Date(), hour: 21, minute: 0, isNotificationOn: false, isCompleted: false),
        Task(id: UUID(), type: TaskType.daily.text, contents: "🏃 Morning jog.", date: Date(), hour: 6, minute: 0, isNotificationOn: true, isCompleted: false),
        Task(id: UUID(), type: TaskType.daily.text, contents: "🎨 Sketching practice.", date: Date(), hour: 20, minute: 0, isNotificationOn: false, isCompleted: false),
        Task(id: UUID(), type: TaskType.daily.text, contents: "🍎 Healthy breakfast.", date: Date(), hour: 8, minute: 0, isNotificationOn: false, isCompleted: false),
        Task(id: UUID(), type: TaskType.daily.text, contents: "📝 Write a journal entry.", date: Date(), hour: 22, minute: 30, isNotificationOn: false, isCompleted: false),
        Task(id: UUID(), type: TaskType.daily.text, contents: "💡 Learn a new word.", date: Date(), hour: 10, minute: 0, isNotificationOn: false, isCompleted: false),
        Task(id: UUID(), type: TaskType.daily.text, contents: "💤 Sleep early.", date: Date(), hour: 23, minute: 0, isNotificationOn: false, isCompleted: false)
    ]
    
    static let futureTasks: [Task] = [
        Task(id: UUID(), type: TaskType.future.text, contents: "Buy a house", date: nil, hour: nil, minute: nil, isNotificationOn: false, isCompleted: false),
        Task(id: UUID(), type: TaskType.future.text, contents: "Travel to Europe", date: nil, hour: nil, minute: nil, isNotificationOn: false, isCompleted: false),
        Task(id: UUID(), type: TaskType.future.text, contents: "Start a business", date: nil, hour: nil, minute: nil, isNotificationOn: false, isCompleted: false),
        Task(id: UUID(), type: TaskType.future.text, contents: "Write a book", date: nil, hour: nil, minute: nil, isNotificationOn: false, isCompleted: false),
        Task(id: UUID(), type: TaskType.future.text, contents: "Learn a new language", date: nil, hour: nil, minute: nil, isNotificationOn: false, isCompleted: false),
        Task(id: UUID(), type: TaskType.future.text, contents: "Run a marathon", date: nil, hour: nil, minute: nil, isNotificationOn: false, isCompleted: false),
        Task(id: UUID(), type: TaskType.future.text, contents: "Get a master's degree", date: nil, hour: nil, minute: nil, isNotificationOn: false, isCompleted: false),
        Task(id: UUID(), type: TaskType.future.text, contents: "Invest in real estate", date: nil, hour: nil, minute: nil, isNotificationOn: false, isCompleted: false),
        Task(id: UUID(), type: TaskType.future.text, contents: "Own a pet", date: nil, hour: nil, minute: nil, isNotificationOn: false, isCompleted: false),
        Task(id: UUID(), type: TaskType.future.text, contents: "Learn to play an instrument", date: nil, hour: nil, minute: nil, isNotificationOn: false, isCompleted: false)
    ]
    
    static let todoTasks: [Task] = [
        Task(id: UUID(), type: TaskType.todo.text, contents: "Complete project report", date: Date().addingTimeInterval(3600 * 2), hour: 14, minute: 0, isNotificationOn: true, isCompleted: false), // 2시간 후
        Task(id: UUID(), type: TaskType.todo.text, contents: "Schedule dentist appointment", date: Date().addingTimeInterval(3600 * 5), hour: 10, minute: 0, isNotificationOn: true, isCompleted: false), // 5시간 후
        Task(id: UUID(), type: TaskType.todo.text, contents: "Finish coding assignment", date: Date().addingTimeInterval(3600 * 8), hour: 16, minute: 30, isNotificationOn: false, isCompleted: false), // 8시간 후
        Task(id: UUID(), type: TaskType.todo.text, contents: "Prepare for meeting", date: Date().addingTimeInterval(3600 * 12), hour: 9, minute: 0, isNotificationOn: true, isCompleted: false), // 12시간 후
        Task(id: UUID(), type: TaskType.todo.text, contents: "Grocery shopping", date: Date().addingTimeInterval(3600 * 18), hour: 17, minute: 45, isNotificationOn: false, isCompleted: false), // 18시간 후
        Task(id: UUID(), type: TaskType.todo.text, contents: "Send invoices", date: Date().addingTimeInterval(3600 * 22), hour: 11, minute: 30, isNotificationOn: false, isCompleted: false), // 22시간 후
        Task(id: UUID(), type: TaskType.todo.text, contents: "Pick up dry cleaning", date: Date().addingTimeInterval(3600 * 24), hour: 12, minute: 15, isNotificationOn: false, isCompleted: false), // 1일 후
        Task(id: UUID(), type: TaskType.todo.text, contents: "Update resume", date: Date().addingTimeInterval(3600 * 30), hour: 19, minute: 30, isNotificationOn: false, isCompleted: false), // 1.5일 후
        Task(id: UUID(), type: TaskType.todo.text, contents: "Plan weekend trip", date: Date().addingTimeInterval(3600 * 40), hour: 20, minute: 45, isNotificationOn: false, isCompleted: false), // 2일 후
        Task(id: UUID(), type: TaskType.todo.text, contents: "Water the plants", date: Date().addingTimeInterval(3600 * 1), hour: 8, minute: 0, isNotificationOn: false, isCompleted: false) // 1시간 후
    ]
}
