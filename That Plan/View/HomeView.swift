//
//  ContentView.swift
//  That Plan
//
//  Created by Jiyoung Park on 2/17/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
            entity: CDTask.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \CDTask.createdAt, ascending: true)]
        ) var tasks: FetchedResults<CDTask>
    
    @State var selectedDate = Date()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    Image("xrOL3O")
                    
                    Spacer()
                    
                    NavigationLink(destination: AddView()) {
                        Image("add")
                            .frame(width: 23, height: 23)
                            .clipShape(Rectangle())
                    }
                }
                
                HStack(spacing: 20) {
                    ForEach(getDatesfromThisWeek(), id: \.self) { date in
                        dateSelector(date: date, selectedDate: $selectedDate)
                            .onTapGesture {
                                selectedDate = date
                            }
                    }
                }
                .padding(.vertical, 20)
                
                if tasks.filter({ Calendar.current.isDate($0.date ?? Date(), inSameDayAs: selectedDate) }).isEmpty {
                    VStack(spacing: 13) {
                        Text("No plans saved for \(Calendar.current.isDateInToday(selectedDate) ? "today" : "this day").")
                            .font(.cabinMedium16)
                            .foregroundStyle(.gray600)
                        
                        Text("Tap the plus button in the top right to add one.")
                            .font(.cabin14)
                            .foregroundStyle(.gray500)
                    }
                    .padding(.top, 230)
                    
                    Spacer()
                } else {
                    ScrollView(.vertical) {
                        VStack(alignment: .leading, spacing: 0) {
                            if !tasks.filter({ $0.type == TaskType.daily.text }).isEmpty {
                                daily
                            }
                            
                            if !tasks.filter({ $0.type == TaskType.quick.text }).isEmpty {
                                quick
                                    .padding(.top, 34)
                            }
                            
                            if !tasks.filter({ $0.type == TaskType.todo.text }).isEmpty {
                                today
                                    .padding(.top, 40)
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .padding(.horizontal, 20)
            .background(.white)
        }
    }
    
    var daily: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 5) {
                Text("Daily")
                    .foregroundStyle(.dailygreen)
                Image("chevron_right")
                    .offset(y: 2)
            }
            .font(.EBGaramond19)
            .onTapGesture {
                //TODO: move to edit view
            }
            
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 13) {
                    ForEach(tasks.filter { $0.type == TaskType.daily.text && $0.contents != nil }, id: \.id) { task in
                        Text(task.contents!)
                    }
                }
                .font(.cabin15)
                .foregroundStyle(.gray800)
                
                Spacer()
            }
            .padding(.horizontal, 17)
            .padding(.vertical, 18)
            .background(RoundedRectangle(cornerRadius: 12).foregroundStyle(.boxbackground))
            .padding(.top, 10)
        }
    }
    
    var quick: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Quick")
                .font(.EBGaramond19)
                .foregroundStyle(.gray900)
            
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(tasks.filter { $0.type == TaskType.quick.text && Calendar.current.isDate($0.date ?? Date(), inSameDayAs: selectedDate) }, id: \.id) { task in
                        checklistItem(content: task.contents ?? "", isChecked: Binding( get: { task.isCompleted }, set: { newValue in
                            task.isCompleted = newValue
                            try? viewContext.save()
                        }), time: nil)
                    }
                }
                
                Spacer()
            }
            .padding(.top, 20)
        }
    }
    
    var today: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Today")
                .foregroundStyle(.black)
                .font(.EBGaramond19)
            
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(Utility.sortedTasks(tasks: Array(tasks), date: selectedDate), id: \.id) { task in
                        checklistItem(content: task.contents ?? "", isChecked: Binding( get: { task.isCompleted }, set: { newValue in
                            task.isCompleted = newValue
                            try? viewContext.save()
                        }), time: task.hour > 0 && task.minute > 0 ? Utility.formattedTime(hour: Int(task.hour), minute: Int(task.minute)) : nil)
                    }
                }
                
                Spacer()
            }
            .padding(.top, 20)
        }
    }
    
    func getDatesfromThisWeek() -> [Date] {
        var dates: [Date] = []
        for i in -3...3 {
            dates.append(Calendar.current.date(byAdding: .day, value: i, to: Date())!)
        }
        return dates
    }
    
    struct dateSelector: View {
        let date: Date
        @Binding var selectedDate: Date
        
        @State private var day = ""
        @State private var weekday = ""
        @State private var isItToday: Bool = false
        
        var body: some View {
            ZStack(alignment: .center) {
                if isItToday {
                    Image("dateBackground")
                        .offset(y: 5)
                }
                VStack(spacing: 2) {
                    Text(day)
                        .font(.charisSIL17)
                    Text(weekday)
                        .font(.facultyGlyphic10)
                        .kerning(0.25)
                }
                .foregroundStyle(isItToday ? .white : .unselected)
                
                if Calendar.current.isDate(selectedDate, inSameDayAs: date) && !isItToday {
                    Image("ellipse")
                        .offset(y: 30)
                }
            }
            .frame(width: 33)
            .onAppear {
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "en_US")

                dateFormatter.dateFormat = "dd"
                day = dateFormatter.string(from: date)

                dateFormatter.dateFormat = "EEE"
                weekday = dateFormatter.string(from: date)
                
                if Calendar.current.isDateInToday(date) {
                    isItToday = true
                }
            }
        }
    }
}

struct checklistItem: View {
    let content: String
    @Binding var isChecked: Bool
    let time: String?

    var body: some View {
        HStack(spacing: 0) {
            Image(isChecked ? "checked" : "unchecked")
            .onTapGesture {
                isChecked.toggle()
            }
            
            Text(content)
                .font(.cabin15)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 14)
                .padding(.trailing, 20)

            if let time = time {
                Text(time)
                    .font(.charisSIL12)
                    .foregroundColor(.timegray)
            }
        }
    }
}

#Preview {
    HomeView()
}
