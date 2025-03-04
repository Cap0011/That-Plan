//
//  DetailedTaskView.swift
//  That Plan
//
//  Created by Jiyoung Park on 3/4/25.
//

import SwiftUI

struct DetailedTaskView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let text: String
    
    @State private var selectedIndex: Int?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Detailed Task")
                .font(.EBGaramond24)
                .foregroundStyle(.black)
            
            Text("Please choose the best fit for this task.")
                .kerning(0.2)
                .font(.cabin16)
                .foregroundStyle(.gray800)
                .padding(.top, 10)
            
            Text(text)
                .kerning(0.2)
                .font(.cabin15)
                .foregroundStyle(.gray800)
                .padding(.vertical, 18)
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 12).foregroundStyle(.boxbackground))
                .padding(.top, 32)
            
            HStack {
                Spacer()
                
                Image("south")
                
                Spacer()
            }
            .padding(.vertical, 15)
            
            HStack(spacing: 12) {
                TypeView(title: "Quick Task", index: 0, selectedIndex: $selectedIndex)
                
                TypeView(title: "To-Do Task", index: 1, selectedIndex: $selectedIndex)
            }
            .padding(.top, 10)
            
            if let index = selectedIndex {
                NavigationLink(destination: SetADateView(text: text, index: index)) {
                    nextButton
                        .padding(.top, 35)
                }
            } else {
                nextButton
                    .padding(.top, 35)
                    .onTapGesture {
                        // TODO: Alert !
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
                if let index = selectedIndex {
                    NavigationLink(destination: SetADateView(text: text, index: index)) {
                        Text("Next")
                            .font(.EBGaramond19)
                            .foregroundStyle(.nextgreen)
                    }
                } else {
                    Text("Next")
                        .font(.EBGaramond19)
                        .foregroundStyle(.nextgreen)
                        .onTapGesture {
                            // TODO: Alert !
                        }
                }
            }
        }
    }
    
    var nextButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 50)
                .foregroundStyle(.monthgreen)
            
            Text("Next")
                .font(.EBGaramond19)
                .foregroundStyle(.white)
        }
    }
    
    struct TypeView: View {
        let title: String
        let index: Int
        
        @Binding var selectedIndex: Int?
        
        var body: some View {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(.black)
                    .frame(height: 109)
                
                Text(title)
                    .font(.EBGaramondMedium16)
                    .foregroundStyle(.white)
                    .padding(.bottom, 19)
            }
            .onTapGesture {
                selectedIndex = index
            }
        }
    }
}

#Preview {
    DetailedTaskView(text: "Make bed without checking Reels.")
}
