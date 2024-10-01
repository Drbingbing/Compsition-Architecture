//
//  OrderItemCell.swift
//  Compsition Architecture
//
//  Created by BingBing on 2024/9/27.
//

import UIKit
import BaseToolbox
import SwiftRichString

final class OrderItemCell: UICollectionViewCell {
    
    private var insets = UIEdgeInsets(h: 12, v: 8)
    private var spacingBetweenNameAndQuantity: CGFloat = 10
    
    lazy var nameLabel = UILabel()
    lazy var quantityLabel = UILabel().then { $0.textColor = .red }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nameLabel)
        addSubview(quantityLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let nameSize = nameLabel.sizeThatFits(bounds.size)
        nameLabel.frame = CGRect(x: bounds.minX + insets.left, y: bounds.leftCenter.y - nameSize.height / 2, width: nameSize.width, height: nameSize.height)
        let size = quantityLabel.sizeThatFits(bounds.size)
        quantityLabel.frame = CGRect(center: bounds.rightCenter.translate(-insets.right - size.width, dy: 0), size: size)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let topBottomMargin = insets.top + insets.bottom
        let leftRightMargin = insets.left + insets.right
        var height: CGFloat = 0
        var width: CGFloat = 0
        
        let nameSize = nameLabel.sizeThatFits(size)
        width += nameSize.width
        height += nameSize.height
        
        width += spacingBetweenNameAndQuantity
        
        let quantitySize = quantityLabel.sizeThatFits(size)
        width += quantitySize.width
        
        return CGSize(width: width + leftRightMargin, height: height + topBottomMargin)
    }
    
    func populate(orderItem: OrderItem) {
        let name = orderItem.name.set(style: Style { $0.font = Font.boldSystemFont(ofSize: 14) })
        let state = if case let .finished(completeDate) = orderItem.state {
            "Completed at\(completeDate)".set(style: Style {
                $0.font = Font.boldSystemFont(ofSize: 12)
                $0.color = Color.systemYellow
            })
        } else { AttributedString(string: "") }
        
        nameLabel.attributedText = name + " " + state
        
        quantityLabel.text = "\(orderItem.quantity)"
    }
}
