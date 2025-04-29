//
//  AlertManager.swift
//  That Plan
//
//  Created by Jiyoung Park on 4/29/25.
//

import SwiftUI

final class AlertManager: ObservableObject {
    static let shared = AlertManager()
    @Published var isShowingToast = false
    private init() {}
}
