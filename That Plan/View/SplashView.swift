//
//  SplashView.swift
//  That Plan
//
//  Created by Jiyoung Park on 4/30/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Utility.mainColor.ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image("SplashLogo")
                
                Text("That Plan")
                    .foregroundStyle(.white)
                    .font(.EBGaramondMedium28)
            }
            .padding(.bottom, 50)
        }
    }
}

#Preview {
    SplashView()
}
