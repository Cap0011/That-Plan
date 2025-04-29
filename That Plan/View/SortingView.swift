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
    @State private var isPopupPresented = false
    
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
                TypeView(title: "Detailed\nTask", index: 0, padding: 0, height: 150, selectedIndex: $selectedIndex)
                
                TypeView(title: "Daily\nRoutine", index: 1, padding: 0, height: 150, selectedIndex: $selectedIndex)
                
                TypeView(title: "Information", index: 2, padding: 10, height: 150, selectedIndex: $selectedIndex)
            }
            
            HStack(spacing: 12) {
                TypeView(title: "Short-term Goal", index: 3, padding: 0, height: 116, selectedIndex: $selectedIndex)
                
                TypeView(title: "Future Goal", index: 4, padding: 0, height: 116, selectedIndex: $selectedIndex)
            }
            .padding(.top, 10)
            .padding(.bottom, 35)
            
            if let index = selectedIndex {
                if index == 0 || index == 3 {
                    NavigationLink(destination: destinationView(for: index)) {
                        nextButton
                    }
                } else {
                    if index == 1 {
                        // TODO: Save the task, Return to HomeView and show toast message
                        nextButton
                            .onTapGesture {
                                AlertManager.shared.isShowingToast = true
                                Utility.resetToRootView()
                            }
                    } else {
                        // TODO: Save the task, Return to HomeView and show popup
                        nextButton
                            .onTapGesture {
                                Utility.resetToRootView()
                            }
                    }
                }
            } else {
                nextButton
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
                .offset(y: -50)
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
                    NavigationLink(destination: destinationView(for: index)) {
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
    
    struct TypeView: View {
        let title: String
        let index: Int
        let padding: CGFloat
        let height: CGFloat
        
        @Binding var selectedIndex: Int?
        
        var body: some View {
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 15)
                    .strokeBorder(selectedIndex == index ? Utility.mainColor : .clear, lineWidth: 4)
                    .background(RoundedRectangle(cornerRadius: 15).foregroundStyle(.black))
                    .foregroundStyle(.black)
                    .frame(height: height)
                
                VStack(spacing: 14 + padding) {
                    Image("type\(index)")
                        .resizable()
                        .frame(width: 44, height: 44)
                    
                    Text(title)
                        .font(.EBGaramondMedium16)
                        .foregroundStyle(selectedIndex == index ? Utility.mainColor : .white)
                        .multilineTextAlignment(.center)
                }
            }
            .onTapGesture {
                selectedIndex = index
            }
        }
    }
    
    func destinationView(for index: Int) -> AnyView {
        switch index {
        case 0:
            return AnyView(DetailedTaskView(text: text))
        case 3:
            return AnyView(ShortGoalView(text: text))
        default:
            return AnyView(HomeView())
        }
    }
}

#Preview {
    SortingView(text: "Make bed without checking Reels.")
}
