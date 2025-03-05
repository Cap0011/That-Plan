//
//  ContentView.swift
//  That Plan
//
//  Created by Jiyoung Park on 2/17/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var selectedDate: Date?
    
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
                
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 0) {
                        daily
                        quick
                            .padding(.top, 34)
                        today
                            .padding(.top, 40)
                    }
                }
                .scrollIndicators(.hidden)
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
                    ForEach(Task.dailyTasks, id: \.id) { task in
                        Text(task.contents)
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
                    ForEach(Task.quickTasks, id: \.id) { task in
                        checklistItem(content: task.contents, isChecked: task.isCompleted ?? false, time: task.hour != nil && task.minute != nil ? Utility.formattedTime(hour: task.hour!, minute: task.minute!) : nil)
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
                    ForEach(Task.todoTasks.filter { Calendar.current.isDate($0.date!, inSameDayAs: selectedDate ?? Date()) }, id: \.id) { task in
                        checklistItem(content: task.contents, isChecked: task.isCompleted ?? false, time: task.hour != nil && task.minute != nil ? Utility.formattedTime(hour: task.hour!, minute: task.minute!) : nil)
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
        @Binding var selectedDate: Date?
        
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
                
                if let selectedDate = selectedDate {
                    if Calendar.current.isDate(selectedDate, inSameDayAs: date) && !isItToday {
                        Image("ellipse")
                            .offset(y: 30)
                    }
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
    let isChecked: Bool
    let time: String?
    
    init(content: String, isChecked: Bool, time: String? = nil) {
        self.content = content
        self.isChecked = isChecked
        self.time = time
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                if isChecked {
                    Image("checked")
                } else {
                    Image("unchecked")
                }
            }
            .onTapGesture {
                // TODO: Toggle isChecked
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
