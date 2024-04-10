//
//  Item.swift
//  CustomViewModifier
//
//  Created by Taewon Yoon on 4/7/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
