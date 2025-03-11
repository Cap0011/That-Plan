//
//  TabView.swift
//  That Plan
//
//  Created by Jiyoung Park on 3/4/25.
//

import SwiftUI

struct TabView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var tab: Tab = .today
    
    var body: some View {
        NavigationStack {
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
                
                if presentationMode.wrappedValue.isPresented == false {
                    TabbarView(selectedTab: $tab)
                }
            }
            .background(.white)
            .ignoresSafeArea()
        }
    }
}

#Preview {
    TabView()
}
