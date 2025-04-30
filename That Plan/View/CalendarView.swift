//
//  CalendarView.swift
//  That Plan
//
//  Created by Jiyoung Park on 4/30/25.
//

import SwiftUI

struct CalendarView: View {
    @Binding var selectedDate: Date
    let tasks: [CDTask]
    let isPicker: Bool
    
    let calendar = Calendar.current
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 7)
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    let weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    @State private var calendarSize = 0.0
    @State private var month = 1
    @State private var year = 1
    @State private var days = [Int]()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text(months[month - 1])
                    .foregroundStyle(Utility.mainColor)
                    .font(.EBGaramond23)
                
                Text(String(year))
                    .foregroundStyle(Utility.mainColor.opacity(0.7))
                    .font(.charisSIL15)
                    .offset(y: 2)
                    .padding(.leading, 8)
                
                Spacer()
                
                Image("chevron_backward")
                    .frame(width: 23, height: 23)
                    .onTapGesture {
                        withAnimation {
                            if month == 1 {
                                year -= 1
                            }
                            month = (month + 10) % 12 + 1
                        }
                    }
                
                Image("chevron_forward")
                    .frame(width: 23, height: 23)
                    .padding(.leading, 10)
                    .onTapGesture {
                        withAnimation {
                            if month == 12 {
                                year += 1
                            }
                            month = month % 12 + 1
                        }
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
                        dayItem(
                            day: Date.date(year: year, month: month, day: days[index]),
                            isEmpty: tasks.filter({
                                ($0.type == TaskType.quick.text || $0.type == TaskType.todo.text) &&
                                Calendar.current.isDate($0.date ?? Date(), inSameDayAs: Date.date(year: year, month: month, day: days[index]))
                            }).isEmpty, isPicker: isPicker,
                            selectedDate: $selectedDate
                        )
                    } else {
                        Rectangle()
                            .foregroundStyle(.clear)
                    }
                }
            }
            .padding(.horizontal, -4)
            .padding(.top, 18)
        }
        .colorScheme(.light)
        .padding(.top, 20)
        .padding(.horizontal, 24)
        .padding(.bottom, 26)
        .background(RoundedRectangle(cornerRadius: 20).foregroundStyle(Utility.mainColor.opacity(0.05)))
        .task {
            year = selectedDate.get(.year)
            month = selectedDate.get(.month)
            updateDays()
        }
        .onChange(of: month) { _ in
            updateDays()
        }
        .readSize { size in
            calendarSize = size.width - 50
        }
    }
    
    struct dayItem: View {
        let day: Date
        let isEmpty: Bool
        let isPicker: Bool
        
        @Binding var selectedDate: Date
        
        var body: some View {
            ZStack(alignment: .bottom) {
                ZStack {
                    Circle()
                        .frame(width: 27, height: 27)
                        .foregroundStyle((!isPicker && Calendar.current.isDateInToday(day)) || isPicker && Calendar.current.isDate(day, inSameDayAs: selectedDate) ? Utility.mainColor : .clear)
                        .offset(y: 1)
                    
                    Text("\(day.get(.day))")
                        .font(.charisSIL16)
                        .foregroundStyle((!isPicker && Calendar.current.isDateInToday(day)) || isPicker && Calendar.current.isDate(day, inSameDayAs: selectedDate) ? .white : .daygray)
                        .frame(height: 24)
                }
                
                if !isEmpty {
                    Circle()
                        .frame(width: 6, height: 6)
                        .foregroundStyle(Utility.mainColor.opacity(0.5))
                        .offset(y: 10)
                }
                
                if !isPicker && Calendar.current.isDate(day, inSameDayAs: selectedDate) {
                    Circle()
                        .frame(width: 6, height: 6)
                        .foregroundStyle(Utility.mainColor)
                        .offset(y: 10)
                }
            }
            .onTapGesture {
                selectedDate = day
            }
        }
    }
    
    private func updateDays() {
        days = Array(repeating: 0, count: calendar.component(.weekday, from: Date.date(year: year, month: month, day: 1)) - 1) +
        Array(calendar.range(of: .day, in: .month, for: Date.date(year: year, month: month, day: 1)) ?? 1..<30)
    }
}
