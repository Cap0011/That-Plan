//
//  AddView.swift
//  That Plan
//
//  Created by Jiyoung Park on 3/3/25.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var tasks = Task.quickTasks
    @State var dates: [Date] = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Add Task")
                .font(.EBGaramond23)
                .foregroundStyle(.black)
                .padding(.top, 15)
            
            NavigationLink(destination: WritingView()) {
                addButton
                    .padding(.top, 27)
            }
            
            Text("History")
                .font(.EBGaramond19)
                .foregroundStyle(.gray600)
                .padding(.top, 35)
                .padding(.bottom, 22)
            
            history
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
                        self.presentationMode.wrappedValue.dismiss()
                    }
            }
        }
    }
    
    var addButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.boxbackground)
                .frame(height: 50)
            
            Image("add")
        }
    }
    
    var history: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 28) {
                ForEach(dates, id: \.self) { date in
                    HistoryItemView(date: date, tasks: tasks.filter { Calendar.current.isDate($0.date ?? Date(), inSameDayAs: date) })
                }
            }
        }
        .scrollIndicators(.hidden)
        .task {
            dates = Array(Set(tasks.map { Calendar.current.startOfDay(for: $0.date ?? Date()) })).sorted(by: >)
        }
    }
    
    struct HistoryItemView: View {
        let date: Date
        let tasks: [Task]
        
        var body: some View {
            VStack(alignment: .leading, spacing: 11) {
                HStack(spacing: 7) {
                    Text(date.formattedString(format: "MM.dd"))
                        .font(.charisSILBold20)
                        .foregroundStyle(.black)
                    
                    Text(date.formattedString(format: "EEE"))
                        .kerning(0.5)
                        .font(.facultyGlyphic13)
                        .foregroundStyle(.gray600)
                        .offset(y: 3)
                }
                
                LazyVStack(alignment: .leading, spacing: 9) {
                    ForEach(tasks, id: \.id) { task in
                        TaskItemView(type: task.type, content: task.contents)
                    }
                }
            }
        }
    }
}

#Preview {
    AddView()
}
