//
//  SetADateView.swift
//  That Plan
//
//  Created by Jiyoung Park on 3/4/25.
//

import SwiftUI

struct SetADateView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext

    let text: String
    let index: Int
    
    @State private var date = Date()
    @State private var time = Date()
    @State private var hour: Int?
    @State private var minute: Int?
    @State private var isNotificationOn = false
    
    @State private var isCalendarOpen = false
    @State private var isTimeOpen = false
    
    @State private var isNotificationSettingOpen = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Set a date")
                .font(.EBGaramond24)
                .foregroundStyle(.black)
            
            Text("Please select the date \(index != 0 ? "and time " : "")for this task.")
                .kerning(0.2)
                .font(.cabin16)
                .foregroundStyle(.gray800)
                .padding(.top, 10)
            
            Text(text)
                .kerning(0.2)
                .font(.cabin15)
                .foregroundStyle(.gray800)
                .padding(.vertical, 18)
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 12).foregroundStyle(.background0))
                .padding(.top, 32)
                .lineLimit(1)
            
            VStack(alignment: .leading, spacing: 22) {
                dateSet
                
                if index != 0 {
                    timeSet
                    
                    notificationSet
                }
            }
            .padding(.top, 24)
            
            Spacer()
        }
        .padding(.top, 15)
        .padding(.horizontal, 20)
        .background(.white)
        .onChange(of: time) { newValue in
            hour = newValue.get(.hour)
            minute = newValue.get(.minute)
        }
        .onChange(of: isNotificationOn) { newValue in
            Task {
                if await !NotificationManager.shared.checkNotificationAuthorization() && newValue {
                    NotificationManager.shared.requestAuthorization { granted in
                        if !granted {
                            isNotificationOn = false
                            NotificationManager.shared.openNotificationSettings()
                            isNotificationSettingOpen = true
                        }
                    }
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            Task {
                if await !NotificationManager.shared.checkNotificationAuthorization() {
                    isNotificationOn = false
                }
                
                if await NotificationManager.shared.checkNotificationAuthorization() && isNotificationSettingOpen {
                    isNotificationOn = true
                }
                
                isNotificationSettingOpen = false
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image(systemName: "chevron.backward")
                    .foregroundStyle(.backgray)
                    .frame(width: 40, height: 40)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Text("Done")
                    .font(.EBGaramond19)
                    .foregroundStyle(.black)
                    .onTapGesture {
                        // TODO: Notification Set
                        addTask()
                        AlertManager.shared.isShowingToast.toggle()
                        withAnimation {
                            Utility.resetToRootView()
                        }
                    }
            }
        }
    }
    
    var saveButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 7)
                .frame(width: 81, height: 32)
                .foregroundStyle(Utility.mainColor.opacity(0.1))
            
            Text("Save")
                .font(.EBGaramondSemibold17)
                .foregroundStyle(Utility.mainColor)
        }
    }
    
    var dateSet: some View {
        VStack(spacing: 10) {
            HStack(spacing: 0) {
                Image("calendar_month")
                
                Text("Date")
                    .font(.EBGaramondMedium19)
                    .foregroundStyle(.black)
                    .padding(.leading, 9)
                
                if !isCalendarOpen {
                    ZStack {
                        RoundedRectangle(cornerRadius: 7)
                            .foregroundStyle(.boxbackground)
                            .frame(width: 100, height: 34)
                        
                        Text(date.formattedString(format: "yy.MM.dd"))
                            .font(.charisSIL16)
                            .foregroundStyle(.gray900)
                    }
                    .padding(.leading, 56)
                    .onTapGesture {
                        withAnimation {
                            isCalendarOpen = true
                            isTimeOpen = false
                        }
                    }
                } else {
                    Spacer()
                    
                    saveButton
                    .onTapGesture {
                        withAnimation {
                            isCalendarOpen = false
                        }
                    }
                }
            }
            
            if isCalendarOpen {
                CalendarView(selectedDate: $date, tasks: [CDTask](), isPicker: true)
            }
        }
    }
    
    var timeSet: some View {
        VStack(spacing: 10) {
            HStack(spacing: 0) {
                Image("schedule")
                
                Text("Time")
                    .font(.EBGaramondMedium19)
                    .foregroundStyle(.black)
                    .padding(.leading, 9)
                
                if !isTimeOpen {
                    ZStack {
                        RoundedRectangle(cornerRadius: 7)
                            .foregroundStyle(.boxbackground)
                            .frame(width: 100, height: 34)
                        
                        if let hour = hour, let minute = minute {
                            Text("\(hour < 10 ? "0" : "")\(hour):\(minute < 10 ? "0" : "")\(minute)")
                                .foregroundStyle(.black)
                        } else {
                            Text("None")
                                .foregroundStyle(.gray500)
                        }
                    }
                    .font(.charisSIL16)
                    .padding(.leading, 52)
                    .onTapGesture {
                        withAnimation {
                            isTimeOpen = true
                            isCalendarOpen = false
                        }
                    }
                } else {
                    Spacer()
                    
                    saveButton
                        .onTapGesture {
                            hour = time.get(.hour)
                            minute = time.get(.minute)
                            
                            withAnimation {
                                isTimeOpen = false
                            }
                        }
                }
            }
            
            if isTimeOpen {
                DatePicker("", selection: $time, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .colorScheme(.light)
            }
        }
    }
    
    var notificationSet: some View {
        HStack(spacing: 0) {
            Image("alarm")
            
            Text("Notification")
                .font(.EBGaramondMedium19)
                .foregroundStyle(.black)
                .padding(.leading, 9)
            
            ZStack {
                if !isNotificationOn {
                    Image("toggle_off")
                } else {
                    Image("toggle_on")
                }
            }
            .padding(.leading, 18)
            .onTapGesture {
                withAnimation {
                    isNotificationOn.toggle()
                }
            }
        }
    }
    
    private func addTask() {
        let newTask = CDTask(context: viewContext)
        newTask.id = UUID()
        newTask.type = index == 0 ? TaskType.quick.text : TaskType.todo.text
        newTask.contents = text
        newTask.date = date
        newTask.createdAt = Date()
        if let hour = hour, let minute = minute {
            newTask.hour = Int64(hour)
            newTask.minute = Int64(minute)
        } else {
            newTask.hour = -1
            newTask.minute = -1
        }
        newTask.isNotificationOn = (isNotificationOn == true)
        newTask.isCompleted = false
        
        if isNotificationOn {
            NotificationManager.shared.scheduleNotification(id: newTask.id ?? UUID(), title: "That Plan", body: "Time to tackle today's tasks! Check them out.", date: Date.date(year: date.get(.year), month: date.get(.month), day: date.get(.day), hour: hour ?? 7, minute: minute ?? 0))
        }
        
        do {
            try viewContext.save()
            print("Task saved successfully!")
        } catch {
            print("Failed to save task: \(error)")
        }
    }
}

#Preview {
    SetADateView(text: "Make bed without checking Reels.", index: 1)
}
