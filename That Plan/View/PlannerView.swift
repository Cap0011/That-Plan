//
//  PlannerView.swift
//  That Plan
//
//  Created by Jiyoung Park on 3/1/25.
//

import SwiftUI

struct PlannerView: View {
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
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("My Planner")
                        .font(.EBGaramond21)
                    
                    Spacer()
                    
                    NavigationLink(destination: NoteView()) {
                        ZStack {
                            Image("note")
                            RoundedRectangle(cornerRadius: 1)
                                .frame(width: 6, height: 2)
                                .offset(y: -1)
                        }
                    }
                }
                
                planner
                    .padding(.top, 25)
                    .padding(.bottom, 22)
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        quick
                        
                        today
                            .padding(.top, 38)
                    }
                }
            }
            .padding(.horizontal, 20)
        }
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
            
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 20) {
                    checklistItem(content: "Reply to John’s proposal email.", isChecked: true)
                    checklistItem(content: "Order Zero Coke and juice on Amazon.", isChecked: false)
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
                    checklistItem(content: "Attend all three morning classes.", isChecked: true)
                    checklistItem(content: "Outline psychology final report.", isChecked: false)
                    checklistItem(content: "Attend biology tutoring for Leo.", isChecked: false, time: "03:30 pm")
                    checklistItem(content: "Do Chapter 6 Spanish shadowing, write 5 new expressions.", isChecked: false, time: "11:00 pm")
                }
                
                Spacer()
            }
            .padding(.top, 20)
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
