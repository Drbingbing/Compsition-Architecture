//
//  Order.swift
//  Compsition Architecture
//
//  Created by BingBing on 2024/9/19.
//

import Foundation

public struct OrderItem: Hashable, Sendable {
    
    public var state: OrderItemState
    public let itemID: Int
    public let orderID: Int
    public let name: String
    public let quantity: Int
    
    public init(itemID: Int, orderID: Int, name: String, quantity: Int, state: OrderItemState) {
        self.itemID = itemID
        self.orderID = orderID
        self.name = name
        self.quantity = quantity
        self.state = state
    }
}

public struct Order: Sendable, Hashable {
    
    public let orderID: Int
    public let tag: String
    public let orderItems: [OrderItem]
    
    public init(orderID: Int, tag: String, orderItems: [OrderItem]) {
        self.orderID = orderID
        self.tag = tag
        self.orderItems = orderItems
    }
}
