//
//  NotificationSettingView.swift
//  That Plan
//
//  Created by Jiyoung Park on 5/1/25.
//

import SwiftUI

struct NotificationSettingView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var isDailyOn = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ToggleRow(title: "Daily Plan Reminders", isOn: $isDailyOn)
            
            Spacer()
        }
        .task {
            loadNotificationAuthorization()
        }
        .onChange(of: isDailyOn) { newValue in
            if newValue {
                NotificationManager.shared.requestAuthorization { granted in
                    if !granted {
                        NotificationManager.shared.openNotificationSettings()
                    }
                    loadNotificationAuthorization()
                }
            } else {
                NotificationManager.shared.openNotificationSettings()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            loadNotificationAuthorization()
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .background(.white)
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
                Text("Notification Settings")
                    .font(.cabinSemibold16)
                    .foregroundStyle(.gray800)
            }
        }
    }
    
    struct ToggleRow: View {
        let title: String
        @Binding var isOn: Bool
        
        var body: some View {
            VStack(spacing: 0) {
                HStack {
                    Text(title)
                        .font(.cabinMedium16)
                        .foregroundStyle(.gray700)
                    
                    Spacer()
                    
                    Image("toggle_\(isOn ? "on" : "off")")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation {
                                isOn.toggle()
                            }
                        }
                }
                .padding(.vertical, 20)
            }
            .contentShape(Rectangle())
        }
    }
    
    func loadNotificationAuthorization() {
        Task {
            isDailyOn = await NotificationManager.shared.checkNotificationAuthorization()
        }
    }
}

#Preview {
    NotificationSettingView()
}
