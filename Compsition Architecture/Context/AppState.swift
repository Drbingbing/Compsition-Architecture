//
//  AppState.swift
//  Compsition Architecture
//
//  Created by BingBing on 2024/9/20.
//

import Foundation

final class AppState {
    
    private let finishedItemBox: any FinishedOrderBox = FinishedOrderItemBoxImpl()
    
    @Published var allOrders: [Order] = []
    
    func mockOrders() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.allOrders = SampleData.A1.map {
                Order(
                    orderID: $0.orderID,
                    tag: $0.tag,
                    items: $0.orderItems.map {
                        OrderItem(itemID: $0.itemID, orderID: $0.orderID, name: $0.name, quantity: $0.quantity, state: .new)
                    }
                )
            }
        }
    }
    
    func markOrderItemAsCompleted(in orderID: Order.ID, itemID: OrderItem.ID) {
        Task { @MainActor in
            guard let index = allOrders.firstIndex(where: { $0.orderID == orderID }) else { return }
            guard let itemIndex = allOrders[index].items.firstIndex(where: { $0.itemID == itemID }) else { return }
            
            let orderItem = allOrders[index].items[itemIndex]
            let finishedItem = await finishedItemBox.add(orderItem: orderItem)
            allOrders[index].items[itemIndex].state = .finished(finishedItem.date)
        }
    }
}
