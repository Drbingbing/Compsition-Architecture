//
//  FinshedOrder.swift
//  Compsition Architecture
//
//  Created by BingBing on 2024/9/20.
//

import Foundation

public struct FinishedOrderItem {
    
    public let itemID: Int
    public let date: Date
    public let quantity: Int
        
    public init(itemID: Int, date: Date, quantity: Int) {
        self.itemID = itemID
        self.date = date
        self.quantity = quantity
    }
}

public struct PendingOrderItem {
    
    public let itemID: Int
    public let date: Date
    public let quantity: Int
        
    public init(itemID: Int, date: Date, quantity: Int) {
        self.itemID = itemID
        self.date = date
        self.quantity = quantity
    }
}

public struct CancelledOrderItem {
    public let itemID: Int
    public let date: Date
    
    public init(itemID: Int, date: Date) {
        self.itemID = itemID
        self.date = date
    }
}
