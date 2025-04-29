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
    
    @State var routine: CDTask
    @State private var text = ""
    @FocusState private var isFocused: Bool
    
    @State private var isDeletePopupPresented = false
    @State private var isEmptyPopupPresented = false
    
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
                .focused($isFocused)
            
            finishButton
                .padding(.top, 24)
                .onTapGesture {
                    if text.isEmpty {
                        isEmptyPopupPresented.toggle()
                    } else {
                        routine.contents = text
                        try? viewContext.save()
                        Utility.resetToRootView()
                        AlertManager.shared.isShowingToast = true
                    }
                }
            
            Spacer()
        }
        .padding(.top, 15)
        .padding(.horizontal, 20)
        .contentShape(Rectangle())
        .onTapGesture {
            isFocused = false
        }
        .popup(isPresented: $isDeletePopupPresented) {
            DeletePopupView(isPresented: $isDeletePopupPresented) {
                viewContext.delete(routine)
                Utility.resetToRootView()
            }
        }
        .popup(isPresented: $isEmptyPopupPresented) {
            emptyPopup
                .offset(y: -50)
        }
        .task {
            isFocused = true
            text = routine.contents ?? ""
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
                    .foregroundStyle(.gray400)
                    .onTapGesture {
                        isDeletePopupPresented.toggle()
                    }
            }
        }
        .background(.white)
    }
    
    var finishButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 50)
                .foregroundStyle(Utility.mainColor)
            
            Text("Finish")
                .font(.EBGaramond19)
                .foregroundStyle(.white)
        }
    }
    
    var emptyPopup: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.white)
                .frame(width: 297, height: 193)
            
            VStack(spacing: 0) {
                Text("Reminder")
                    .font(.custom("Pretendard-SemiBold", size: 19))
                    .foregroundStyle(.gray800)
                    
                Text("Enter a task to proceed.")
                    .font(.custom("Pretendard-Regular", size: 16))
                    .foregroundStyle(.gray700)
                    .padding(.top, 12)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Utility.mainColor)
                        .frame(width: 265, height: 43)
                    
                    Text("Got it")
                        .font(.custom("Pretendard-Medium", size: 15))
                        .foregroundStyle(.white)
                }
                .padding(.top, 36)
                .onTapGesture {
                    isEmptyPopupPresented.toggle()
                }
            }
            .padding(.top, 45)
            .padding(.horizontal, 16)
            .padding(.bottom, 17)
        }
    }
}

struct DeletePopupView: View {
    @Binding var isPresented: Bool
    let onDelete: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Delete")
                .font(.custom("Pretendard-SemiBold", size: 19))
                .foregroundStyle(.gray800)
            
            Text("Are you sure you want\nto delete this item?")
                .font(.custom("Pretendard-Regular", size: 16))
                .foregroundStyle(.gray700)
                .padding(.top, 12)
            
            HStack(spacing: 0) {
                Text("Cancel")
                    .font(.custom("Pretendard-Medium", size: 15))
                    .foregroundStyle(.gray600)
                    .frame(width: 128, height: 43)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isPresented = false
                    }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Utility.mainColor)
                        .frame(width: 128, height: 43)
                    
                    Text("Delete")
                        .font(.custom("Pretendard-Medium", size: 15))
                        .foregroundStyle(.white)
                }
                .onTapGesture {
                    isPresented = false
                    onDelete()
                }
            }
            .padding(.top, 30)
        }
        .padding(.top, 30)
        .padding(.horizontal, 16)
        .padding(.bottom, 17)
        .background(RoundedRectangle(cornerRadius: 20).foregroundStyle(.white))
        .padding(.horizontal, 48)
    }
}
