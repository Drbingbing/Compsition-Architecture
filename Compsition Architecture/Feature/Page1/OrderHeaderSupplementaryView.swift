//
//  OrderHeaderSupplementaryView.swift
//  Compsition Architecture
//
//  Created by BingBing on 2024/9/27.
//

import UIKit
import BaseToolbox

final class OrderHeaderSupplementaryView: UICollectionReusableView {
    static let reuseIdentifier = "title-supplementary-reuse-identifier"
    
    let label = UILabel().then { $0.font = .boldSystemFont(ofSize: 14) }
    let insets = UIEdgeInsets(h: 12, v: 8)

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds.inset(by: insets)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        label.sizeThatFits(size).inset(by: -insets)
    }
}
