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
    
    @State private var month = 1
    @State private var year = 0
    @State private var selectedDate = Date()
    @State private var calendarSize: CGFloat = .zero
    @State private var days = Array(1...30)
    
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
            
            planner
                .padding(.top, 25)
                .padding(.horizontal, 20)
                .padding(.bottom, 22)
            
            if tasks.filter({ ($0.type == TaskType.quick.text || $0.type == TaskType.todo.text) && Calendar.current.isDate($0.date ?? Date(), inSameDayAs: selectedDate) }).isEmpty {
                VStack(spacing: 13) {
                    Text("No plans saved for \(Calendar.current.isDateInToday(selectedDate) ? "today" : "this day").")
                        .font(.cabinMedium16)
                        .foregroundStyle(.gray600)
                    
                    Text("Go to the Today tab to add a new plan.")
                        .font(.cabin14)
                        .foregroundStyle(.gray500)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 114)
                
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
        .padding(.top, 60)
        .background(.white)
    }
    
    var planner: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text(months[month - 1])
                    .foregroundStyle(.monthgreen)
                    .font(.EBGaramond23)
                
                Text(String(year))
                    .foregroundStyle(.yeargreen)
                    .font(.charisSIL15)
                    .offset(y: 2)
                    .padding(.leading, 8)
                
                Spacer()
                
                Image("chevron_backward")
                    .frame(width: 23, height: 23)
                    .onTapGesture {
                        if month == 1 {
                            year -= 1
                        }
                        month = (month + 10) % 12 + 1
                    }
                
                Image("chevron_forward")
                    .frame(width: 23, height: 23)
                    .padding(.leading, 10)
                    .onTapGesture {
                        if month == 12 {
                            year += 1
                        }
                        month = month % 12 + 1
                    }
            }
            .padding(.bottom, 15)
            
            HStack(spacing: (calendarSize - 24 * 7) / 6) {
                ForEach(weekdays, id: \.self) { weekday in
                    Text(weekday)
                        .kerning(0.2)
                        .font(.facultyGlyphic10)
                        .foregroundStyle(.weekdaygray)
                        .frame(width: 24)
                }
            }
            
            LazyVGrid(columns: columns, spacing: 24) {
                ForEach(days.indices, id: \.self) { index in
                    if days[index] > 0 {
                        dayItem(day: Date.date(year: year, month: month, day: days[index]), isEmpty: true, selectedDate: $selectedDate)
                    } else {
                        Rectangle()
                            .foregroundStyle(.clear)
                    }
                }
            }
            .padding(.horizontal, -4)
            .padding(.top, 18)
        }
        .padding(.top, 20)
        .padding(.horizontal, 24)
        .padding(.bottom, 26)
        .background(RoundedRectangle(cornerRadius: 20).foregroundStyle(.boxbackground))
        .onAppear {
            month = selectedDate.get(.month)
            year = selectedDate.get(.year)
            days = Array(repeating: 0, count: calendar.component(.weekday, from: Date.date(year: year, month: month, day: 1)) - 1) + Array(calendar.range(of: .day, in: .month, for: Date.date(year: year, month: month, day: 1)) ?? 1..<30)
        }
        .onChange(of: month) { _ in
            days = Array(repeating: 0, count: calendar.component(.weekday, from: Date.date(year: year, month: month, day: 1)) - 1) + Array(calendar.range(of: .day, in: .month, for: Date.date(year: year, month: month, day: 1)) ?? 1..<30)
        }
        .readSize { size in
            calendarSize = size.width - 50
        }
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
    
    struct dayItem: View {
        let day: Date
        let isEmpty: Bool
        
        @Binding var selectedDate: Date
        
        var body: some View {
            ZStack(alignment: .bottom) {
                ZStack {
                    if Calendar.current.isDateInToday(day) {
                        Circle()
                            .frame(width: 27, height: 27)
                            .foregroundStyle(.monthgreen)
                            .offset(y: 1)
                    }
                    
                    Text("\(day.get(.day))")
                        .font(.charisSIL16)
                        .foregroundStyle(Calendar.current.isDateInToday(day) ? .white : .daygray)
                        .frame(height: 24)
                }
                
                if !isEmpty {
                    Circle()
                        .frame(width: 6, height: 6)
                        .foregroundStyle(.dotlightgreen)
                        .offset(y: 10)
                }
                
                if Calendar.current.isDate(day, inSameDayAs: selectedDate) {
                    Circle()
                        .frame(width: 6, height: 6)
                        .foregroundStyle(.monthgreen)
                        .offset(y: 10)
                }
            }
            .onTapGesture {
                selectedDate = day
            }
        }
    }
}

#Preview {
    PlannerView()
}
