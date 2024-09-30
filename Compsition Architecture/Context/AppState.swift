//
//  AppState.swift
//  Compsition Architecture
//
//  Created by BingBing on 2024/9/20.
//

import Foundation

final class AppState {
    
    private let finishedItemBox: any FinishedOrderBox = FinishedOrderItemBoxImpl()
    
    @Published var orders: [Order] = []
    
    func mockOrders() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.orders = SampleData.A1.map {
                Order(
                    orderID: $0.orderID,
                    tag: $0.tag,
                    orderItems: $0.orderItems.map {
                        OrderItem(itemID: $0.itemID, orderID: $0.orderID, name: $0.name, quantity: $0.quantity, state: .new)
                    }
                )
            }
        }
    }
    
    func order(at indexPath: IndexPath) -> Order {
        return orders[indexPath.section]
    }
    
    func markOrderItemAsCompleted(_ orderItem: OrderItem) {
        Task {
            await finishedItemBox.add([orderItem])
            
            guard let index = orders.firstIndex(where: { $0.orderID == orderItem.orderID }) else { return }
            
        }
    }
}
