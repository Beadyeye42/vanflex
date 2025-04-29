//
//  Item.swift
//  Vanflex 4
//
//  Created by Brian Nangle on 29/04/2025.
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
