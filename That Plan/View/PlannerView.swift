//
//  PlannerView.swift
//  That Plan
//
//  Created by Jiyoung Park on 3/1/25.
//

import SwiftUI

struct PlannerView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: CDTask.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \CDTask.createdAt, ascending: true)]
    ) var tasks: FetchedResults<CDTask>

    @State private var selectedDate = Date()
    @State private var calendarSize: CGFloat = .zero
    
    let calendar = Calendar.current
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 7)
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    let weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("My Planner")
                    .font(.EBGaramond21)
                    .foregroundStyle(.black)
                
                Spacer()
                
                NavigationLink(destination: NoteView()) {
                    ZStack {
                        Image("note")
                        RoundedRectangle(cornerRadius: 1)
                            .foregroundStyle(.black)
                            .frame(width: 6, height: 2)
                            .offset(y: -1)
                    }
                }
            }
            .padding(.horizontal, 20)
            
            CalendarView(selectedDate: $selectedDate, tasks: Array(tasks), isPicker: false)
                .padding(.top, 25)
                .padding(.horizontal, 20)
                .padding(.bottom, 22)
            
            if tasks.filter({ ($0.type == TaskType.quick.text || $0.type == TaskType.todo.text) && Calendar.current.isDate($0.date ?? Date(), inSameDayAs: selectedDate) }).isEmpty {
                Spacer()
                
                VStack(spacing: 13) {
                    Text("No plans saved for \(Calendar.current.isDateInToday(selectedDate) ? "today" : "this day").")
                        .font(.cabinMedium16)
                        .foregroundStyle(.gray600)
                    
                    Text("Go to the Today tab to add a new plan.")
                        .font(.cabin14)
                        .foregroundStyle(.gray500)
                }
                .frame(maxWidth: .infinity)
                
                Spacer()
            } else {
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 0) {
                        if !tasks.filter({ $0.type == TaskType.quick.text && Calendar.current.isDate($0.date ?? Date(), inSameDayAs: selectedDate) }).isEmpty {
                            quick
                                .padding(.bottom, 38)
                        }
                        
                        if !tasks.filter({ $0.type == TaskType.todo.text && Calendar.current.isDate($0.date ?? Date(), inSameDayAs: selectedDate) }).isEmpty {
                            today
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .padding(.top, 70)
        .background(.white)
    }
    
    var quick: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Quick")
                .font(.EBGaramond19)
                .foregroundStyle(.gray600)
                .padding(.horizontal, 20)
            
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(tasks.filter { $0.type == TaskType.quick.text && Calendar.current.isDate($0.date ?? Date(), inSameDayAs: selectedDate) }, id: \.id) { task in
                        NavigationLink(destination: DetailView(task: task)) {
                            ChecklistItem(content: task.contents ?? "", isChecked: Binding( get: { task.isCompleted }, set: { newValue in
                                task.isCompleted = newValue
                                try? viewContext.save()
                            }), time: nil)
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.top, 10)
        }
    }
    
    var today: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Today")
                .foregroundStyle(.black)
                .font(.EBGaramond19)
                .padding(.horizontal, 20)
            
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(Utility.sortedTasks(tasks: Array(tasks), date: selectedDate), id: \.id) { task in
                        NavigationLink(destination: DetailView(task: task)) {
                            ChecklistItem(content: task.contents ?? "", isChecked: Binding( get: { task.isCompleted }, set: { newValue in
                                task.isCompleted = newValue
                                try? viewContext.save()
                            }), time: task.hour > 0 && task.minute > 0 ? Utility.formattedTime(hour: Int(task.hour), minute: Int(task.minute)) : nil)
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.top, 10)
        }
    }
}

#Preview {
    PlannerView()
}
