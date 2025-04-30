//
//  AnnouncementView.swift
//  That Plan
//
//  Created by Jiyoung Park on 4/30/25.
//

import SwiftUI

struct AnnouncementView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let announcements = [Announcement(title: "App Update: New Features Added!", date: "25.01.05", contents: "We’re excited to announce the latest update to [App Name]!\nHere’s what's new:\nNew Themes: Customize your planner with fresh new designs and color options.\nImproved Notifications: You can now set reminders for each individual plan with specific times.\nBug Fixes: We've fixed some minor bugs to improve the app’s performance. \nFor questions, contact us at [email]."), Announcement(title: "App Update: New Features Added!", date: "25.01.05", contents: "We’re excited to announce the latest update to [App Name]!\nHere’s what's new:\nNew Themes: Customize your planner with fresh new designs and color options.\nImproved Notifications: You can now set reminders for each individual plan with specific times.\nBug Fixes: We've fixed some minor bugs to improve the app’s performance. \nFor questions, contact us at [email]!")]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(announcements, id: \.contents) { announcement in
                    AnnouncementRow(announcement: announcement)
                }
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
                Text("Announcements")
                    .font(.cabinSemibold16)
                    .foregroundStyle(.gray800)
            }
        }
    }
    
    struct Announcement {
        let title: String
        let date: String
        let contents: String
    }
    
    struct AnnouncementRow: View {
        let announcement: Announcement
        
        var body: some View {
            VStack(alignment: .leading, spacing: 6) {
                Text(announcement.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(announcement.date)
                
                Text(announcement.contents)
                    .font(.custom("Pretendard-Regular", size: 15))
                    .lineSpacing(4)
                
                Rectangle()
                    .frame(height: 1.5)
                    .foregroundStyle(.background0)
                    .padding(.top, 8)
                    .padding(.bottom, 14)
            }
            .kerning(0.2)
            .font(.custom("Pretendard-SemiBold", size: 15))
            .foregroundStyle(.gray700)
        }
    }
}

#Preview {
    AnnouncementView()
}
