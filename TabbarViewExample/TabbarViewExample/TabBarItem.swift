//
//  TabBarItem.swift
//  TabbarViewExample
//
//  Created by Taewon Yoon on 4/22/24.
//

import Foundation
import SwiftUI

//struct TabBarItem: Hashable {
//    let iconName: String
//    let title: String
//    let color: Color
//}

enum TabBarItem: Hashable {
    case home, favorite, profile, message
    
    var iconName: String {
        switch self {
        case .home: return "house"
        case .favorite: return "heart"
        case .profile: return "person"
        case .message: return "message"
        }
    }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .favorite: return "Favorites"
        case .profile: return "Profile"
        case .message: return "Messages"
        }
    }
    
    var color: Color {
        switch self {
        case .home: return Color.red
        case .favorite: return Color.blue
        case .profile: return Color.green
        case .message: return Color.orange
        }
    }
    
}

