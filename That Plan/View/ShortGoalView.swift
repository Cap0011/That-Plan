//
//  ShortGoalView.swift
//  That Plan
//
//  Created by Jiyoung Park on 3/4/25.
//

import SwiftUI

struct ShortGoalView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let text: String
    
    @State private var isExpanded = false
    @State private var newText = ""
    @State private var tasks = [String]()
    @FocusState private var isFocused: Bool
    
    @State private var isPopupPresented = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Goal Refinement")
                .font(.EBGaramond24)
                .foregroundStyle(.black)
            
            Text("Break your Short-term Goals into detailed tasks and rewrite them clearly.")
                .kerning(0.2)
                .font(.cabin16)
                .foregroundStyle(.gray800)
                .padding(.top, 10)
            
            Text(text)
                .kerning(0.2)
                .font(.cabin15)
                .foregroundStyle(.white)
                .padding(.vertical, 18)
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 12).foregroundStyle(.gray800))
                .padding(.top, 32)
            
            HStack {
                Spacer()
                
                Image("south")
                
                Spacer()
            }
            .padding(.vertical, 15)
            
            if !isExpanded {
                addButton
                    .onTapGesture {
                        isFocused = true
                        isExpanded.toggle()
                    }
            } else {
                TextEditor(text: $newText)
                    .focused($isFocused)
                    .kerning(0.2)
                    .font(.cabin17)
                    .foregroundStyle(.black)
                    .scrollContentBackground(.hidden)
                    .lineSpacing(5)
                    .frame(height: 124)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(RoundedRectangle(cornerRadius: 12).foregroundStyle(.boxbackground))
                
                finishButton
                    .padding(.top, 12)
                    .onTapGesture {
                        tasks.insert(newText, at: 0)
                        newText = ""
                        isExpanded.toggle()
                        isFocused = false
                    }
            }
            
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(tasks.indices, id: \.self) { index in
                        HStack(spacing: 0) {
                            Text(tasks[index])
                                .kerning(0.2)
                                .font(.cabin15)
                                .foregroundStyle(.gray800)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Image("delete")
                                .onTapGesture {
                                    tasks.remove(at: index)
                                }
                                .padding(.leading, 10)
                        }
                        .padding(.vertical, 18)
                        .padding(.horizontal, 16)
                        .background(RoundedRectangle(cornerRadius: 12).foregroundStyle(.boxbackground))
                    }
                }
                .padding(.top, 12)
            }
            .scrollIndicators(.hidden)
            
            Spacer()
        }
        .padding(.top, 15)
        .padding(.horizontal, 20)
        .popup(isPresented: $isPopupPresented) {
            emptyPopup
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isFocused = false
        }
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
                if tasks.isEmpty {
                    Text("Next")
                        .font(.EBGaramond19)
                        .foregroundStyle(Utility.mainColor.opacity(0.7))
                        .onTapGesture {
                            isPopupPresented.toggle()
                        }
                } else {
                    NavigationLink(destination: BreakDownGuideView(goal: text, texts: tasks)) {
                        Text("Next")
                            .font(.EBGaramond19)
                            .foregroundStyle(Utility.mainColor.opacity(0.7))
                    }
                }
            }
        }
    }
    
    var addButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.boxbackground)
                .frame(height: 50)
            
            Image("plus")
        }
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
                    
                Text("Create a new plan to break down\nyour short-term goals.")
                    .font(.custom("Pretendard-Regular", size: 16))
                    .foregroundStyle(.gray700)
                    .padding(.top, 12)
                    .multilineTextAlignment(.center)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Utility.mainColor)
                        .frame(width: 265, height: 43)
                    
                    Text("Got it")
                        .font(.custom("Pretendard-Medium", size: 15))
                        .foregroundStyle(.white)
                }
                .padding(.top, 29)
                .padding(.bottom, 17)
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
    ShortGoalView(text: "Make bed without checking Reels.")
}
