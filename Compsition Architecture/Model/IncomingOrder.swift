//
//  IncomingOrder.swift
//  Compsition Architecture
//
//  Created by BingBing on 2024/9/30.
//

public struct IncomingOrder: Sendable, Hashable {
    public let orderID: Int
    public let tag: String
    public let orderItems: [IncomingOrderItem]
    
    public init(orderID: Int, tag: String, orderItems: [IncomingOrderItem]) {
        self.orderID = orderID
        self.tag = tag
        self.orderItems = orderItems
    }
}

public struct IncomingOrderItem: Sendable, Hashable {
    public let itemID: Int
    public let orderID: Int
    public let name: String
    public let quantity: Int
    
    public init(itemID: Int, orderID: Int, name: String, quantity: Int) {
        self.itemID = itemID
        self.orderID = orderID
        self.name = name
        self.quantity = quantity
    }
}
