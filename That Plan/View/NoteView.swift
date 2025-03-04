//
//  NoteView.swift
//  That Plan
//
//  Created by Jiyoung Park on 3/2/25.
//

import SwiftUI

struct NoteView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ScrollView {
            VStack(spacing: 9) {
                NavigationLink(destination: NoteDetailView()) {
                    TaskItemView(type: "Information", content: "Make bed without checking Reels.")
                }
                TaskItemView(type: "Information", content: "Make bed without checking Reels.")
                TaskItemView(type: "Future Goal", content: "Make bed without checking Reels.")
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
