//
//  NoteDetailView.swift
//  That Plan
//
//  Created by Jiyoung Park on 3/2/25.
//

import SwiftUI

struct NoteDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let dummy = [Task.informationTasks[0], Task.futureTasks[0]]
    
    @State private var note: Task?
    @State private var text = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let note = note {
                Text(note.type)
                    .font(.EBGaramond24)
                    .foregroundStyle(.black)
                
                Text(TaskType.fromText(note.type)?.description ?? "Empty")
                    .font(.cabin16)
                    .kerning(0.2)
                    .foregroundStyle(.gray800)
                    .padding(.top, 10)
                
                TextField(text, text: $text)
                    .focused($isFocused)
                    .submitLabel(.done)
                    .font(.cabin15)
                    .kerning(0.2)
                    .foregroundStyle(.gray800)
                    .padding(.horizontal, 16)
                    .background(RoundedRectangle(cornerRadius: 12).foregroundStyle(.boxbackground).frame(height: 50))
                    .frame(height: 50)
                    .padding(.top, 16)
                
                if note.type == TaskType.future.text {
                    NavigationLink(destination: SortingView(text: text)) {
                        sortTasksButton
                            .padding(.top, 66)
                    }
                }
            }
            
            Spacer()
        }
        .padding(.top, 15)
        .padding(.horizontal, 20)
        .contentShape(Rectangle())
        .background(.white)
        .task {
            note = dummy[1]
            text = dummy[1].contents
        }
        .onTapGesture {
            isFocused = false
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
                Text("Edit")
                    .font(.EBGaramond19)
                    .foregroundStyle(.black)
                    .onTapGesture {
                        isFocused.toggle()
                    }
            }
        }
    }
    
    var sortTasksButton: some View {
        ZStack {
            ZStack(alignment: .trailing) {
                RoundedRectangle(cornerRadius: 12)
                    .frame(height: 50)
                    .foregroundStyle(.monthgreen)
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .frame(width: 23, height: 23)
                    .foregroundStyle(.white)
                    .padding(.trailing, 13)
            }
            
            Text("Sort Tasks")
                .font(.EBGaramond19)
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    NoteDetailView()
}
