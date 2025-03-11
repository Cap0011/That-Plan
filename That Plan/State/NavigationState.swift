//
//  NavigationState.swift
//  That Plan
//
//  Created by Jiyoung Park on 3/11/25.
//

import Foundation

final class NavigationState: ObservableObject {
    static let shared = NavigationState()
    @Published var isRootView: Bool = true
    
    private init() {}
}
