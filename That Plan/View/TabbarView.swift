//
//  TabbarView.swift
//  That Plan
//
//  Created by Jiyoung Park on 3/4/25.
//

import SwiftUI

struct TabbarView: View {
    @AppStorage("colorIndex") private var colorIndex: Int = 0
    @Binding var selectedTab: Tab
    
    var body: some View {
        ZStack(alignment: .top) {
            UnevenRoundedRectangle(cornerRadii: .init(topLeading: 20.0, bottomLeading: 0.0, bottomTrailing: 0.0, topTrailing: 20.0), style: .continuous)
                .frame(height: 86)
                .foregroundStyle(.white)
                .shadow(color: Color.shadow.opacity(0.2), radius: 2, x: 0, y: 0)
            
            HStack {
                TabbarItem(type: .today, selectedTab: $selectedTab)
                TabbarItem(type: .planner, selectedTab: $selectedTab)
                TabbarItem(type: .settings, selectedTab: $selectedTab)
            }
            .padding(.top, 7)
            .padding(.horizontal, 20)
        }
        .id(colorIndex)
    }
    
    struct TabbarItem: View {
        let type: Tab
        @Binding var selectedTab: Tab
        
        var body: some View {
            VStack(spacing: 6) {
                Image(type.imageName)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(selectedTab != type ? .gray100 : Utility.mainColor)
                
                Text(type.title)
                    .font(.custom("Pretendard-Medium", size: 12))
                    .foregroundStyle(selectedTab != type ? .gray400 : Utility.mainColor)
                    .frame(maxWidth: .infinity)
                    .frame(height: 12)
            }
            .onTapGesture {
                selectedTab = type
            }
        }
    }
}
