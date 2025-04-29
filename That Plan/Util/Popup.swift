//
//  Popup.swift
//  That Plan
//
//  Created by Jiyoung Park on 4/29/25.
//
import SwiftUI

struct Popup<PopupContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let popupContent: () -> PopupContent

    func body(content: Content) -> some View {
        ZStack {
            content

            if isPresented {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isPresented.toggle()
                    }

                popupContent()
            }
        }
    }
}
