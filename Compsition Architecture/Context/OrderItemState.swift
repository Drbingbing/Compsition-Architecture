//
//  OrderState.swift
//  Compsition Architecture
//
//  Created by BingBing on 2024/9/30.
//
import Foundation

public enum OrderItemState: Sendable, Hashable {
    case finished(Date)
    case new
}
