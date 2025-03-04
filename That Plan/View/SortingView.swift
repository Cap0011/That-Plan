//
//  SortingView.swift
//  That Plan
//
//  Created by Jiyoung Park on 3/3/25.
//

import SwiftUI

struct SortingView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let text: String
    
    @State private var selectedIndex: Int?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Task Sorting")
                .font(.EBGaramond24)
                .foregroundStyle(.black)
            
            Text("Please select the most suitable category for this task.")
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
            
            HStack(spacing: 10) {
                TypeView(title: "Detailed\nTask", index: 0, padding: 27, height: 150, selectedIndex: $selectedIndex)
                
                TypeView(title: "Daily\nRoutine", index: 1, padding: 27, height: 150, selectedIndex: $selectedIndex)
                
                TypeView(title: "Information", index: 2, padding: 27, height: 150, selectedIndex: $selectedIndex)
            }
            
            HStack(spacing: 12) {
                TypeView(title: "Short-term Goal", index: 3, padding: 19, height: 109, selectedIndex: $selectedIndex)
                
                TypeView(title: "Future Goal", index: 4, padding: 19, height: 109, selectedIndex: $selectedIndex)
            }
            .padding(.top, 10)
            
            if let index = selectedIndex {
                NavigationLink(destination: destinationView(for: index)) {
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
                    NavigationLink(destination: destinationView(for: index)) {
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
        let padding: CGFloat
        let height: CGFloat
        
        @Binding var selectedIndex: Int?
        
        var body: some View {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(.black)
                    .frame(height: height)
                
                Text(title)
                    .font(.EBGaramondMedium16)
                    .foregroundStyle(.white)
                    .padding(.bottom, padding)
                    .multilineTextAlignment(.center)
            }
            .onTapGesture {
                selectedIndex = index
            }
        }
    }
    
    func destinationView(for index: Int) -> AnyView {
        // TODO: Add different views on index
        switch index {
        case 0:
            return AnyView(DetailedTaskView(text: text))
        default:
            return AnyView(WritingView())
        }
    }
}

#Preview {
    SortingView(text: "Make bed without checking Reels.")
}
