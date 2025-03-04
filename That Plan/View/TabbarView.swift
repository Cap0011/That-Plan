//
//  TabbarView.swift
//  That Plan
//
//  Created by Jiyoung Park on 3/4/25.
//

import SwiftUI

struct TabbarView: View {
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
            .padding(.top, 3.5)
            .padding(.horizontal, 60)
        }
    }
    
    struct TabbarItem: View {
        let type: Tab
        @Binding var selectedTab: Tab
        
        var body: some View {
            VStack(spacing: 7) {
                Image(type.imageName + (selectedTab != type ? "_un" : ""))
                Text(type.title).font(.system(size: 12)).foregroundStyle(selectedTab != type ? Color.gray300 : Color.gray900)
                    .frame(maxWidth: .infinity)
            }
            .onTapGesture {
                selectedTab = type
            }
        }
    }
}
