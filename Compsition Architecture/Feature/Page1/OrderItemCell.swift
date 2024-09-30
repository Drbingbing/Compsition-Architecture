//
//  OrderItemCell.swift
//  Compsition Architecture
//
//  Created by BingBing on 2024/9/27.
//

import UIKit
import BaseToolbox

final class OrderItemCell: UICollectionViewCell {
    
    private var insets = UIEdgeInsets(h: 12, v: 8)
    private var spacingBetweenNameAndQuantity: CGFloat = 10
    
    lazy var nameLabel = UILabel()
    lazy var quantityLabel = UILabel()
    
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
        nameLabel.sizeToFit()
        nameLabel.frame.origin = bounds.topLeft.translate(insets.left, dy: insets.top)
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
}
