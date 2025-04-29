//
//  DailyRoutineView.swift
//  That Plan
//
//  Created by Jiyoung Park on 3/24/25.
//

import SwiftUI

struct DailyRoutineView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: CDTask.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \CDTask.createdAt, ascending: true)],
        predicate: NSPredicate(format: "type == %@", TaskType.daily.text)
    ) var routines: FetchedResults<CDTask>
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 9) {
                    ForEach(Array(routines), id: \.id) { routine in
                        NavigationLink(destination: RoutineEditView(routine: routine)) {
                            if let contents = routine.contents {
                                TaskItemView(type: "Daily", content: contents)
                            }
                        }
                    }
                }
                .padding(.top, 15)
                .padding(.horizontal, 19)
                .background(.white)
            }
            .scrollIndicators(.hidden)
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
                
                ToolbarItem(placement: .principal) {
                    Text("Daily Routine")
                        .font(.EBGaramond18)
                        .foregroundStyle(.black)
                }
            }
        }
    }
}

#Preview {
    DailyRoutineView()
}
