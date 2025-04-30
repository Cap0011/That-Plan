//
//  PrivacyPolicyView.swift
//  That Plan
//
//  Created by Jiyoung Park on 4/30/25.
//

import SwiftUI

struct PrivacyPolicyView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                TermRow(title: "1. Acceptance of Terms", content: " By using That Plan, you agree to comply with these terms.")
                
                TermRow(title: "2. User Account", content: " You must provide accurate information when creating an account. You are responsible for maintaining the confidentiality of your account and password.")
                
                TermRow(title: "3. Privacy", content: " We collect personal information to improve your experience. Your data is kept private and secure.")
                
                TermRow(title: "4. Acceptable Use", content: " You agree not to use the app for illegal activities or harm others.")
                
                TermRow(title: "5. Termination", content: " We may suspend or terminate your account for violating these terms.")
                
                TermRow(title: "6. Changes to Terms", content: " We may update these terms. Continued use of the app means you accept the updated terms.")
                
                TermRow(title: "7. Contact", content: " For questions, contact us at 5165511@naver.com.")
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)
        }
        .background(.white)
        .scrollIndicators(.hidden)
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
                Text("Terms of Service & Privacy Policy")
                    .font(.cabinSemibold16)
                    .foregroundStyle(.gray800)
            }
        }
    }
    
    struct TermRow: View {
        let title: String
        let content: String
        
        var body: some View {
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.custom("Pretendard-SemiBold", size: 15))
                    .foregroundStyle(.gray700)
                
                Text(content)
                    .font(.custom("Pretendard-Regular", size: 15))
                    .foregroundStyle(.gray700)
                    .lineSpacing(2)
            }
        }
    }
}

#Preview {
    PrivacyPolicyView()
}
