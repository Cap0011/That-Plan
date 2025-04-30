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
    @State private var isLaunching = true
    
    var body: some View {
        if isLaunching {
            SplashView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        isLaunching = false
                    }
                }
        } else {
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
}

#Preview {
    TabView()
}
