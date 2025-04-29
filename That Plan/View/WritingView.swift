//
//  WritingView.swift
//  That Plan
//
//  Created by Jiyoung Park on 3/3/25.
//

import SwiftUI

struct WritingView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var note: Task?
    @State private var text = ""
    @FocusState private var isFocused: Bool
    @State private var isPopupPresented = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TextEditor(text: $text)
                .focused($isFocused)
                .kerning(0.2)
                .font(.cabin17)
                .foregroundStyle(.black)
                .scrollContentBackground(.hidden)
                .lineSpacing(5)
                .frame(height: 154)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(RoundedRectangle(cornerRadius: 12).foregroundStyle(.boxbackground))
            
            if text.isEmpty {
                finishButton
                    .padding(.top, 24)
                    .onTapGesture {
                        isPopupPresented.toggle()
                    }
            } else {
                NavigationLink(destination: SortingView(text: text)) {
                    finishButton
                        .padding(.top, 24)
                }
            }
            
            Spacer()
        }
        .padding(.top, 15)
        .padding(.horizontal, 20)
        .task {
            isFocused = true
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isFocused = false
        }
        .popup(isPresented: $isPopupPresented) {
            emptyPopup
                .offset(y: -50)
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
                Text("Create a Task")
                    .foregroundStyle(.black)
                    .font(.EBGaramondSemibold19)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                if text.isEmpty {
                    Text("Next")
                        .font(.EBGaramond19)
                        .foregroundStyle(Utility.mainColor.opacity(0.7))
                        .onTapGesture {
                            isPopupPresented.toggle()
                        }
                } else {
                    NavigationLink(destination: SortingView(text: text)) {
                        Text("Next")
                            .font(.EBGaramond19)
                            .foregroundStyle(Utility.mainColor.opacity(0.7))
                    }
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
                    isPopupPresented.toggle()
                }
            }
            .padding(.top, 45)
            .padding(.horizontal, 16)
            .padding(.bottom, 17)
        }
    }
}

#Preview {
    WritingView()
}
