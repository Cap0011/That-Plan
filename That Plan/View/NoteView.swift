//
//  NoteView.swift
//  That Plan
//
//  Created by Jiyoung Park on 3/2/25.
//

import SwiftUI

struct NoteView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: CDTask.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \CDTask.createdAt, ascending: true)],
        predicate: NSPredicate(format: "type == %@ OR type == %@", TaskType.information.text, TaskType.future.text)
    ) var tasks: FetchedResults<CDTask>
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            if tasks.isEmpty {
                VStack(spacing: 13) {
                    Text("No tasks to save in this note.")
                        .font(.cabin16)
                        .foregroundStyle(.gray600)
                    
                    Text("Shows 'information' and 'Future Goal' tasks.\nAdded items appear automatically.")
                        .font(.cabin14)
                        .foregroundStyle(.gray500)
                        .multilineTextAlignment(.center)
                }
                .offset(y: -50)
            } else {
                ScrollView {
                    VStack(spacing: 9) {
                        ForEach(Array(tasks), id: \.id) { task in
                            NavigationLink(destination: DetailView(task: task)) {
                                if let type = task.type, let contents = task.contents {
                                    TaskItemView(type: type, content: contents)
                                }
                            }
                        }
                    }
                    .padding(.top, 15)
                    .padding(.horizontal, 19)
                    .background(.white)
                }
                .scrollIndicators(.hidden)
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
            
            ToolbarItem(placement: .principal) {
                Text("Note")
                    .font(.EBGaramond18)
                    .foregroundStyle(.black)
            }
        }
    }
}

struct TaskItemView: View {
    let type: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text(type)
                    .font(.EBGaramond18)
                    .foregroundStyle(.tasktitlegreen)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .frame(width: 23, height: 23)
                    .foregroundStyle(.gray400)
                    .clipShape(Rectangle())
            }
            
            Text(content)
                .kerning(0.2)
                .font(.cabin15)
                .foregroundStyle(.gray800)
        }
        .padding(16)
        .padding(.bottom, 2)
        .background(RoundedRectangle(cornerRadius: 12).foregroundStyle(.boxbackground))
    }
}

#Preview {
    NoteView()
}
