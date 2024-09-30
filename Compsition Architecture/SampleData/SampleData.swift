//
//  SampleData.swift
//  Compsition Architecture
//
//  Created by BingBing on 2024/9/30.
//
import Foundation

final class SampleData {
    
    static let A1: [IncomingOrder] = [
        IncomingOrder(
            orderID: 1,
            tag: "A1",
            orderItems: [
                IncomingOrderItem(itemID: 1001, orderID: 1, name: "Pizza", quantity: 1),
                IncomingOrderItem(itemID: 1002, orderID: 1, name: "Pasta", quantity: 1),
                IncomingOrderItem(itemID: 1003, orderID: 1, name: "Salad", quantity: 1)
            ]
        )
    ]
}
