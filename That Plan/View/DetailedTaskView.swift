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
    @State private var isPopupPresented = false
    
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
                        isPopupPresented.toggle()
                    }
            }
            
            Spacer()
        }
        .padding(.top, 15)
        .padding(.horizontal, 20)
        .popup(isPresented: $isPopupPresented) {
            selectPopup
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
                if let index = selectedIndex {
                    NavigationLink(destination: SetADateView(text: text, index: index)) {
                        Text("Next")
                            .font(.EBGaramond19)
                            .foregroundStyle(Utility.mainColor.opacity(0.7))
                    }
                } else {
                    Text("Next")
                        .font(.EBGaramond19)
                        .foregroundStyle(Utility.mainColor.opacity(0.7))
                        .onTapGesture {
                            isPopupPresented.toggle()
                        }
                }
            }
        }
    }
    
    var nextButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 50)
                .foregroundStyle(Utility.mainColor)
            
            Text("Next")
                .font(.EBGaramond19)
                .foregroundStyle(.white)
        }
    }
    
    var selectPopup: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.white)
                .frame(width: 297, height: 193)
            
            VStack(spacing: 0) {
                Text("Reminder")
                    .font(.custom("Pretendard-SemiBold", size: 19))
                    .foregroundStyle(.gray800)
                    
                Text("Select a task type to continue.")
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

struct TypeView: View {
    let title: String
    let index: Int
    
    @Binding var selectedIndex: Int?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 15)
                .strokeBorder(selectedIndex == index ? Utility.mainColor : .clear, lineWidth: 4)
                .background(RoundedRectangle(cornerRadius: 15).foregroundStyle(.black))
                .foregroundStyle(.black)
                .frame(height: 116)
            
            VStack(spacing: 14) {
                Image("detail\(index)")
                    .renderingMode(.template)
                    .foregroundStyle(index == selectedIndex ? Utility.mainColor : .white)
                
                Text(title)
                    .font(.EBGaramondMedium16)
                    .foregroundStyle(selectedIndex == index ? Utility.mainColor : .white)
                    .padding(.bottom, 19)
            }
        }
        .onTapGesture {
            selectedIndex = index
        }
    }
}

#Preview {
    DetailedTaskView(text: "Make bed without checking Reels.")
}
