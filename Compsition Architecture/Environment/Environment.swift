//
//  Environment.swift
//  Compsition Architecture
//
//  Created by BingBing on 2024/9/27.
//

import Foundation

public struct Environment {
    public var database = Database()
    public var date: () -> Date = Date.init
}

public var Current = Environment()

public struct Database {
    
    private static let store = AnyPersistenceStore()
    
    public var saveFinishedOrderItems: ([FinishedOrderItem]) async -> Void = { _ in store.save() }
    public func save(finishedOrderItems orderItems: [FinishedOrderItem]) async {
        await saveFinishedOrderItems(orderItems)
    }
    
    public var removeFinishedOrderItems: ([FinishedOrderItem]) async -> Void = { _ in store.delete() }
    public func remove(finishedOrderItems orderItems: [FinishedOrderItem]) async {
        await removeFinishedOrderItems(orderItems)
    }
    
    public var savePendingOrderItems: ([PendingOrderItem]) async -> Void = { _ in store.save() }
    public func save(pendingOrderItems orderItems: [PendingOrderItem]) async {
        await savePendingOrderItems(orderItems)
    }
    
    public var removePendingOrderItems: ([PendingOrderItem]) async -> Void = { _ in store.delete() }
    public func remove(pendingOrderItems orderItems: [PendingOrderItem]) async {
        await removePendingOrderItems(orderItems)
    }
    
    public var saveCancelledOrderItems: ([CancelledOrderItem]) async -> Void = { _ in store.save() }
    public func save(cancelledOrderItems orderItems: [CancelledOrderItem]) async {
        await saveCancelledOrderItems(orderItems)
    }
    
    public var removeCancelledOrderItems: ([CancelledOrderItem]) async -> Void = { _ in store.delete() }
    public func remove(cancelledOrderItems orderItems: [CancelledOrderItem]) async {
        await removeCancelledOrderItems(orderItems)
    }
}
