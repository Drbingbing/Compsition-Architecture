//
//  FinishedOrderBox.swift
//  Compsition Architecture
//
//  Created by BingBing on 2024/9/20.
//

protocol FinishedOrderBox: Actor {
    
    func add(_ orderItems: [OrderItem]) async
    func remove(_ orderItems: [OrderItem]) async
}

actor FinishedOrderItemBoxImpl: FinishedOrderBox {
    
    private var context: [AnyHashable: FinishedOrderItem] = [:]
    
    func add(_ orderItems: [OrderItem]) async {
        let keyAndValues = orderItems.map { ($0.itemID, convertToFinishedOrderItem($0) ) }
        let dict = Dictionary(keyAndValues, uniquingKeysWith: { $1 })
        context.merge(dict, uniquingKeysWith: { $1 })
        await Current.database.save(finishedOrderItems: dict.map(\.value))
    }
    
    func remove(_ orderItems: [OrderItem]) async {
        let keys = orderItems.map(\.itemID)
        let values = keys.compactMap { context.removeValue(forKey: $0) }
        await Current.database.remove(finishedOrderItems: values)
    }
}

private func convertToFinishedOrderItem(_ from: OrderItem) -> FinishedOrderItem {
    FinishedOrderItem(itemID: from.itemID, date: Current.date(), quantity: from.quantity)
}
