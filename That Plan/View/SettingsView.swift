//
//  SettingsView.swift
//  That Plan
//
//  Created by Jiyoung Park on 4/30/25.
//

import SwiftUI

struct SettingsView: View {    
    let titles = ["Theme & Color", "Terms of Service & Privacy Policy", "Announcements", "Notification Settings"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(titles.indices, id: \.self) { index in
                NavigationLink(destination: destinationView(for: index)) {
                    SettingRow(title: titles[index])
                }
            }

            Spacer()
        }
        .padding(.top, 110)
        .padding(.horizontal, 20)
        .background(.white)
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Settings")
                    .font(.EBGaramond18)
                    .foregroundStyle(.black)
            }
        }
    }
    
    var appVersionRow: some View {
        VStack(spacing: 0) {
            HStack {
                Text("App Version")
                    .font(.cabinMedium16)
                    .foregroundStyle(.gray700)
                
                Spacer()
                
                Text(getAppVersion())
                    .font(.cabinMedium16)
                    .foregroundStyle(.gray700)
            }
            .padding(.vertical, 20)
        }
        .contentShape(Rectangle())
    }
    
    struct SettingRow: View {
        let title: String
        
        var body: some View {
            VStack(spacing: 0) {
                HStack {
                    Text(title)
                        .font(.cabinMedium16)
                        .foregroundStyle(.gray700)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.forward")
                        .foregroundStyle(.gray400)
                        .font(.system(size: 13))
                        .frame(width: 23, height: 23)
                        .contentShape(Rectangle())
                }
                .padding(.vertical, 20)
                
                Rectangle()
                    .frame(height: 1.5)
                    .foregroundStyle(.background0)
            }
            .contentShape(Rectangle())
        }
    }
    
    private func destinationView(for index: Int) -> AnyView {
        switch index {
        case 0:
            return AnyView(ColorSettingView())
        case 1:
            return AnyView(PrivacyPolicyView())
        default:
            return AnyView(HomeView())
        }
    }
    
    private func getAppVersion() -> String {
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return appVersion
        }
        return "Unknown"
    }
}

#Preview {
    SettingsView()
}
