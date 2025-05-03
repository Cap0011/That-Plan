//
//  Toast.swift
//  That Plan
//
//  Created by Jiyoung Park on 4/29/25.
//

import SwiftUI

struct Toast: ViewModifier {
    // these correspond to Android values f
    // or DURATION_SHORT and DURATION_LONG
    static let short: TimeInterval = 2
    static let long: TimeInterval = 3.5
    
    let message: String
    @Binding var isShowing: Bool
    let config: Config
    
    @State private var offsetY: CGFloat = -100
    
    func body(content: Content) -> some View {
        ZStack {
            content
            toastView
                .offset(y: offsetY)
        }
    }
    
    private var toastView: some View {
        VStack {
            if isShowing {
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(config.backgroundColor)
                        .frame(height: 44)
                    
                    HStack(spacing: 10) {
                        Image("check")
                        
                        Text(message)
                            .foregroundColor(config.textColor)
                            .font(config.font)
                        
                        Spacer()
                    }
                    .padding(.leading, 17)
                }
                .padding(.top, 60)
                .padding(.horizontal, 20)
                .onAppear {
                    withAnimation(config.animation) {
                        offsetY = 0
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + config.duration) {
                        isShowing = false
                        offsetY = -100
                    }
                }
            }
            
            Spacer()
        }
        .animation(config.animation, value: isShowing)
        .transition(.move(edge: .top).combined(with: .opacity))
    }
    
    struct Config {
        let textColor: Color
        let font: Font
        let backgroundColor: Color
        let duration: TimeInterval
        let animation: Animation
        
        init(textColor: Color = .white,
             font: Font = .EBGaramond17,
             backgroundColor: Color = Utility.mainColor,
             duration: TimeInterval = Toast.short,
             animation: Animation = .easeInOut(duration: 0.5)) {
            self.textColor = textColor
            self.font = font
            self.backgroundColor = backgroundColor
            self.duration = duration
            self.animation = animation
        }
    }
}
