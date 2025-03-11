//
//  BreakDownTaskView.swift
//  That Plan
//
//  Created by Jiyoung Park on 3/10/25.
//

import SwiftUI

struct BreakDownTaskView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    
    let goal: String
    let texts: [String]
    
    @State private var tasks = [Task]()
    
    @State private var pageIndex = 0
    @State private var selectedIndex: Int?
    @State private var date = Date()
    @State private var hour: Int?
    @State private var minute: Int?
    @State private var isNotificationOn = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if pageIndex % 2 == 0 {
                indexSelection
            } else {
                dateSelection
            }
        }
        .task {
            for index in texts.indices {
                tasks.append(Task(id: UUID(), type: "", contents: texts[index]))
            }
        }
        .onChange(of: pageIndex / 2) { _ in
            resetValues()
        }
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
                        if pageIndex == 0 {
                            self.presentationMode.wrappedValue.dismiss()
                        } else {
                            pageIndex -= 1
                        }
                    }
            }
            
            ToolbarItem(placement: .principal) {
                Text("\(pageIndex / 2 + 1)/\(texts.count)")
                    .font(.charisSILBold19)
                    .foregroundStyle(.black)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Text(pageIndex % 2 == 1 ? "Done" : "Next")
                    .font(.EBGaramond19)
                    .foregroundStyle(pageIndex % 2 == 1 ? .black : .nextgreen)
                    .onTapGesture {
                        if pageIndex == 2 * texts.count - 1 {
                            addTasks()
                            resetToRootView()
                        } else {
                            if pageIndex % 2 == 1 {
                                updateTask()
                                resetValues()
                            }
                            pageIndex += 1
                        }
                    }
            }
        }
    }
    
    var indexSelection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Detailed Task")
                .font(.EBGaramond24)
                .foregroundStyle(.black)
            
            Text("Please choose the best fit for this task.")
                .kerning(0.2)
                .font(.cabin16)
                .foregroundStyle(.gray800)
                .padding(.top, 10)
            
            Text(texts[pageIndex / 2])
                .kerning(0.2)
                .font(.cabin15)
                .foregroundStyle(.gray800)
                .padding(.vertical, 18)
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 12).foregroundStyle(.boxbackground))
                .padding(.top, 16)
            
            HStack {
                Spacer()
                
                Image("south")
                
                Spacer()
            }
            .padding(.vertical, 15)
            
            HStack(spacing: 12) {
                TypeView(title: "Quick Task", index: 0, selectedIndex: $selectedIndex)
                
                TypeView(title: "To-Do Task", index: 1, selectedIndex: $selectedIndex)
            }
            .padding(.top, 10)
            
            nextButton
                .padding(.top, 35)
                .onTapGesture {
                    if selectedIndex != nil {
                        pageIndex += 1
                    } else {
                        // TODO: Alert !
                        print("Task type hasn't selected yet.")
                    }
                }
            
            Spacer()
        }
    }
    
    var dateSelection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Set a date")
                .font(.EBGaramond24)
                .foregroundStyle(.black)
            
            Text("Please select the date \(selectedIndex != 0 ? "and time " : "")for this task.")
                .kerning(0.2)
                .font(.cabin16)
                .foregroundStyle(.gray800)
                .padding(.top, 10)
            
            Text(texts[pageIndex / 2])
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
                
                if selectedIndex != 0 {
                    timeSet
                    
                    notificationSet
                }
            }
            .padding(.top, 24)
            
            Spacer()
        }
    }
    
    var nextButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 50)
                .foregroundStyle(.monthgreen)
            
            Text("Next")
                .font(.EBGaramond19)
                .foregroundStyle(.white)
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
    
    private func resetToRootView() {
        guard let window = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow }) else { return }
        
        window.rootViewController = UIHostingController(rootView: HomeView())
        window.makeKeyAndVisible()
    }
    
    private func updateTask() {
        tasks[pageIndex / 2].createdAt = Date()
        tasks[pageIndex / 2].type = selectedIndex == 0 ? TaskType.quick.text : TaskType.todo.text
        tasks[pageIndex / 2].date = date
        tasks[pageIndex / 2].hour = hour
        tasks[pageIndex / 2].minute = minute
        tasks[pageIndex / 2].isNotificationOn = isNotificationOn
    }
    
    private func resetValues() {
        if tasks.isEmpty {
            selectedIndex = nil
            date = Date()
            hour = nil
            minute = nil
            isNotificationOn = false
        } else {
            let task = tasks[pageIndex / 2]
            if task.type == "" {
                selectedIndex = nil
            } else {
                selectedIndex = task.type == TaskType.quick.text ? 0 : 1
            }
            date = task.date ?? Date()
            hour = task.hour
            minute = task.minute
            isNotificationOn = task.isNotificationOn ?? false
        }
    }
    
    private func addTasks() {
        for task in tasks {
            let newTask = CDTask(context: viewContext)
            newTask.id = task.id
            newTask.type = task.type
            newTask.contents = task.contents
            newTask.date = task.date
            newTask.createdAt = task.createdAt
            if let hour = task.hour, let minute = task.minute {
                newTask.hour = Int64(hour)
                newTask.minute = Int64(minute)
            } else {
                newTask.hour = -1
                newTask.minute = -1
            }
            newTask.isNotificationOn = (task.isNotificationOn == true)
            newTask.isCompleted = false
            
            //TODO: ParentID?
            
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
    BreakDownTaskView(goal: "To be a millionaire", texts: ["Get a job", "Take a break", "Mind control", "Do whatever to make a lotta money"])
}
