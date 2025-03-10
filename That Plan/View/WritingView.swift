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
            
            NavigationLink(destination: SortingView(text: text)) {
                finishButton
                    .padding(.top, 24)
            }
            
            Spacer()
        }
        .padding(.top, 15)
        .clipShape(Rectangle())
        .onTapGesture {
            isFocused = false
        }
        .padding(.horizontal, 20)
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
                NavigationLink(destination: SortingView(text: text)) {
                    Text("Next")
                        .font(.EBGaramond19)
                        .foregroundStyle(.nextgreen)
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

#Preview {
    WritingView()
}
