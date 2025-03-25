//
//  RoutineEditView.swift
//  That Plan
//
//  Created by Jiyoung Park on 3/24/25.
//

import SwiftUI

struct RoutineEditView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var routine: CDTask
    @State private var text = ""
    @FocusState private var isFocused: Bool
    
    @State private var isDeletePopupPresented = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TextEditor(text: $text)
                .kerning(0.2)
                .font(.cabin17)
                .foregroundStyle(.black)
                .scrollContentBackground(.hidden)
                .lineSpacing(5)
                .frame(height: 154)
                .padding(.vertical, 18)
                .padding(.horizontal, 16)
                .background(RoundedRectangle(cornerRadius: 12).foregroundStyle(.boxbackground))
            
            finishButton
                .padding(.top, 24)
                .onTapGesture {
                    if text.isEmpty {
                        // TODO: Alert!
                    } else {
                        routine.contents = text
                        try? viewContext.save()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            
            Spacer()
        }
        .padding(.top, 15)
        .padding(.horizontal, 20)
        .clipShape(Rectangle())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            if isDeletePopupPresented {
                ZStack {
                    Color.black.opacity(0.3).ignoresSafeArea()
                    DeletePopupView(isPresented: $isDeletePopupPresented) {
                        viewContext.delete(routine)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .task {
            text = routine.contents ?? ""
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
            
            ToolbarItem(placement: .principal) {
                Text("Edit")
                    .foregroundStyle(.black)
                    .font(.EBGaramondSemibold19)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Image("delete")
                    .onTapGesture {
                        viewContext.delete(routine)
                    }
            }
        }
        .background(.white)
    }
    
    var finishButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 50)
                .foregroundStyle(.monthgreen)
            
            Text("Finish")
                .font(.EBGaramond19)
                .foregroundStyle(.white)
        }
    }
}

struct DeletePopupView: View {
    @Binding var isPresented: Bool
    let onDelete: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Delete")
                .foregroundStyle(.gray800)
            
            Text("Are you sure you want\nto delete this item?")
                .foregroundStyle(.gray700)
                .padding(.top, 12)
            
            HStack(spacing: 0) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.clear)
                        .frame(height: 43)
                    
                    Text("Cancel")
                        .foregroundStyle(.gray600)
                }
                .onTapGesture {
                    isPresented = false
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.monthgreen)
                        .frame(height: 43)
                    
                    Text("Delete")
                        .foregroundStyle(.white)
                }
                .onTapGesture {
                    isPresented = false
                    onDelete()
                }
            }
            .padding(.top, 30)
            .padding(.bottom, 18)
        }
        .padding(.top, 30)
        .padding(.horizontal, 16)
        .padding(.bottom, 18)
        .background(RoundedRectangle(cornerRadius: 20).foregroundStyle(.white))
        .padding(.horizontal, 48)
    }
}

struct ReminderView: View {
    @Binding var isPresented: Bool
    let title: String
    let contents: String
    let buttonText: String
    let onAction: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            Text(title)
            Text(contents)
                .padding(.top, 12)
                        
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 43)
                    .foregroundStyle(.monthgreen)
                Text(buttonText)
                    .foregroundStyle(.white)
            }
            .padding(.top, 36)
        }
        .padding(.top, 45)
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
        .background(RoundedRectangle(cornerRadius: 20).foregroundStyle(.white))
        .padding(.horizontal, 48)
    }
}

#Preview {
//    DeletePopupView(isPresented: .constant(false)) {  }
    ReminderView(isPresented: .constant(false), title: "Reminder", contents: "Select a task type to continue.", buttonText: "Got it") { }
}
