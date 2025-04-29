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
    
    func body(content: Content) -> some View {
        ZStack {
            content
            toastView
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + config.duration) {
                        isShowing = false
                    }
                }
            }
            
            Spacer()
        }
        .animation(config.animation, value: isShowing)
        .transition(config.transition)
    }
    
    struct Config {
        let textColor: Color
        let font: Font
        let backgroundColor: Color
        let duration: TimeInterval
        let transition: AnyTransition
        let animation: Animation
        
        init(textColor: Color = .white,
             font: Font = .EBGaramond17,
             backgroundColor: Color = Utility.mainColor,
             duration: TimeInterval = Toast.short,
             transition: AnyTransition = .opacity,
             animation: Animation = .linear(duration: 0.3)) {
            self.textColor = textColor
            self.font = font
            self.backgroundColor = backgroundColor
            self.duration = duration
            self.transition = transition
            self.animation = animation
        }
    }
}
