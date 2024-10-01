//
//  ViewController.swift
//  Compsition Architecture
//
//  Created by BingBing on 2024/9/19.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    static let sectionHeaderElementKind = "section-header-element-kind"
    
    private let appState = AppState()
    
    private lazy var collectionView = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(44)),
            elementKind: ViewController.sectionHeaderElementKind,
            alignment: .top)
        sectionHeader.pinToVisibleBounds = true
        sectionHeader.zIndex = 2
        section.boundarySupplementaryItems = [sectionHeader]

        let layout = UICollectionViewCompositionalLayout(section: section)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<Order, OrderItem> = {
        let headerRegistration = UICollectionView.SupplementaryRegistration<OrderHeaderSupplementaryView>(elementKind: ViewController.sectionHeaderElementKind) { [weak self] supplementaryView, string, indexPath in
            guard let self else { return }
            if appState.allOrders.isEmpty { return }
            let order = appState.allOrders[indexPath.section]
            supplementaryView.label.text = order.tag
        }
        
        let cellRegistration = UICollectionView.CellRegistration<OrderItemCell, OrderItem> { cell, indexPath, orderItem in
            cell.populate(orderItem: orderItem)
        }
        
        let dataSource = UICollectionViewDiffableDataSource<Order, OrderItem>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        dataSource.supplementaryViewProvider = { [weak self] view, kind, indexPath in
            guard let self else { return nil }
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
        
        return dataSource
    }()
    
    private var subsripction: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        
        appState.$allOrders
            .sink { [weak self] orders in
                guard let self else { return }
                var snapshot = NSDiffableDataSourceSnapshot<Order, OrderItem>()
                for order in orders {
                    snapshot.appendSections([order])
                    snapshot.appendItems(order.items, toSection: order)
                }
                self.dataSource.apply(snapshot, animatingDifferences: true)
            }
            .store(in: &subsripction)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appState.mockOrders()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds.inset(by: view.safeAreaInsets)
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let order = appState.allOrders[indexPath.section]
        let item = order.items[indexPath.item]
        appState.markOrderItemAsCompleted(in: order.orderID, itemID: item.itemID)
    }
}
