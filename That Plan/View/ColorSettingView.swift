//
//  ColorSettingView.swift
//  That Plan
//
//  Created by Jiyoung Park on 4/30/25.
//

import SwiftUI

struct ColorSettingView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @AppStorage("colorIndex") private var selectedIndex: Int = 0
    @State private var cardWidth = 0.0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Choose the main color\nthat matches your mood.")
                .multilineTextAlignment(.leading)
                .font(.cabin17)
                .kerning(0.2)
                .foregroundStyle(.gray800)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 5)
                .padding(.bottom, 24)
            
            HStack(spacing: 15) {
                ForEach(0...2, id: \.self) { index in
                    ColorCard(index: index, width: cardWidth, selectedIndex: $selectedIndex)
                }
            }
            
            HStack(spacing: 15) {
                ForEach(3...5, id: \.self) { index in
                    ColorCard(index: index, width: cardWidth, selectedIndex: $selectedIndex)
                }
            }
            .padding(.top, 36)
            
            Spacer()
        }
        .padding(.top, 20)
        .padding(.horizontal, 15)
        .background(.white)
        .readSize { size in
            cardWidth = (size.width - 60) / 3
        }
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
            
            ToolbarItem(placement: .principal) {
                Text("Themes & Color")
                    .font(.cabinSemibold16)
                    .foregroundStyle(.gray800)
            }
        }
    }
    
    struct ColorCard: View {
        let index: Int
        let width: CGFloat
        @Binding var selectedIndex: Int
        
        var body: some View {
            VStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: width, height: 210)
                        .foregroundStyle(Color("Main\(index)"))
                    
                    Image("SplashLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35)
                }
                
                Image("radio\(index == selectedIndex ? "" : "_un")")
            }
            .onTapGesture {
                selectedIndex = index
            }
        }
    }
}

#Preview {
    ColorSettingView()
}
