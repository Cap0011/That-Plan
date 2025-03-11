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
                        isExpanded.toggle()
                    }
            } else {
                TextEditor(text: $newText)
                    .kerning(0.2)
                    .font(.cabin17)
                    .foregroundStyle(.black)
                    .scrollContentBackground(.hidden)
                    .lineSpacing(5)
                    .frame(height: 124)
                    .padding(.vertical, 18)
                    .padding(.horizontal, 16)
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
        .clipShape(Rectangle())
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
                NavigationLink(destination: BreakDownGuideView(goal: text, texts: tasks)) {
                    Text("Next")
                        .font(.EBGaramond19)
                        .foregroundStyle(.nextgreen)
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
                .foregroundStyle(.monthgreen)
            
            Text("Finish")
                .font(.EBGaramond19)
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    ShortGoalView(text: "Make bed without checking Reels.")
}
