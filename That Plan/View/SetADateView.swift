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
    @State private var hour: Int?
    @State private var minute: Int?
    @State private var isNotificationOn = false
    
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
                .background(RoundedRectangle(cornerRadius: 12).foregroundStyle(.boxbackground))
                .padding(.top, 32)
            
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
                        addTask()
                        Utility.resetToRootView()
                    }
            }
        }
    }
    
    var dateSet: some View {
        HStack(spacing: 0) {
            Image("calendar_month")
            
            Text("Date")
                .font(.EBGaramondMedium19)
                .foregroundStyle(.black)
                .padding(.leading, 9)
            
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
                // TODO: Open Calendar
            }
        }
    }
    
    var timeSet: some View {
        HStack(spacing: 0) {
            Image("schedule")
            
            Text("Time")
                .font(.EBGaramondMedium19)
                .foregroundStyle(.black)
                .padding(.leading, 9)
            
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .foregroundStyle(.boxbackground)
                    .frame(width: 100, height: 34)
                
                if let hour = hour, let minute = minute {
                    Text("\(hour):\(minute)")
                        .foregroundStyle(.black)
                } else {
                    Text("None")
                        .foregroundStyle(.gray500)
                }
            }
            .font(.charisSIL16)
            .padding(.leading, 52)
            .onTapGesture {
                // TODO: Open time picker
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
                isNotificationOn.toggle()
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
        
        do {
            try viewContext.save()
            print("Task saved successfully!")
        } catch {
            print("Failed to save task: \(error)")
        }
    }
}

#Preview {
    SetADateView(text: "Make bed without checking Reels.", index: 0)
}
