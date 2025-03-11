//
//  TabView.swift
//  That Plan
//
//  Created by Jiyoung Park on 3/4/25.
//

import SwiftUI

struct TabView: View {
    @StateObject private var navigationState = NavigationState.shared
    @State private var tab: Tab = .today
    
    var body: some View {
        VStack(spacing: 0) {
            switch tab {
            case .today:
                HomeView()
            case .planner:
                PlannerView()
            case .settings:
                PlannerView()
            }
            
            Spacer()
            
            if navigationState.isRootView {
                TabbarView(selectedTab: $tab)
            }
        }
        .background(.white)
        .ignoresSafeArea()
    }
}

#Preview {
    TabView()
}
