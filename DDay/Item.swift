//
//  Item.swift
//  DDay
//
//  Created by Fenn on 2023/11/7.
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
