//
//  NoteDetailView.swift
//  That Plan
//
//  Created by Jiyoung Park on 3/2/25.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var task: CDTask
        
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(task.type ?? "")
                .font(.EBGaramond24)
                .foregroundStyle(.black)
            
            if task.type == TaskType.future.text {
                Text(TaskType.fromText(task.type ?? "")?.description ?? "")
                    .font(.cabin16)
                    .kerning(0.2)
                    .foregroundStyle(.gray800)
                    .padding(.top, 10)
            }
            
            Text(task.contents ?? "")
                .font(.cabin15)
                .kerning(0.2)
                .foregroundStyle(.gray800)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .padding(.vertical, 18)
                .padding(.horizontal, 16)
                .background(RoundedRectangle(cornerRadius: 12).foregroundStyle(.boxbackground))
                .padding(.top, 16)
            
            if task.type == TaskType.future.text {
                NavigationLink(destination: SortingView(text: task.contents ?? "")) {
                    sortTasksButton
                        .padding(.top, 66)
                }
            }
            
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
                NavigationLink(destination: EditView(task: task)) {
                    Text("Edit")
                        .font(.EBGaramond19)
                        .foregroundStyle(.black)
                }
            }
        }
    }
    
    var sortTasksButton: some View {
        ZStack {
            ZStack(alignment: .trailing) {
                RoundedRectangle(cornerRadius: 12)
                    .frame(height: 50)
                    .foregroundStyle(Utility.mainColor)
                
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
