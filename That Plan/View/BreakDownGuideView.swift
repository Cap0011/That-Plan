//
//  BreakDownGuideView.swift
//  That Plan
//
//  Created by Jiyoung Park on 3/10/25.
//

import SwiftUI

struct BreakDownGuideView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let goal: String
    let texts: [String]
    
    var body: some View {
        ZStack {
            Utility.mainColor.ignoresSafeArea()
            VStack(spacing: 18) {
                Text("Before We move on")
                    .font(.EBGaramond28)
                
                Text("Your goals are now detailed tasks.\nNext, we'll turn them into a to-do list.\nHere's what to know before we move on.")
                    .multilineTextAlignment(.center)
                    .font(.cabin16)
                    .kerning(0.3)
                    .lineSpacing(2)
                
                Image("GuideView")
                    .padding(.top, 24)
                
                NavigationLink(destination: BreakDownTaskView(goal: goal, texts: texts)) {
                    button
                        .padding(.top, 32)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 50)
            .foregroundStyle(.white)
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
        }
    }
    
    var button: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 50)
            
            Text("Start Setting Tasks")
                .font(.EBGaramond19)
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    BreakDownGuideView(goal: "To be a millionaire", texts: ["Get a job", "Take a break", "Mind control", "Do whatever to make a lotta money"])
}
