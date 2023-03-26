//
//  CustomTabBarCollectionViewCell.swift
//  CustomTabBar
//
//  Created by JunHwan Kim on 2023/03/26.
//

import UIKit

class MenubarCell: UICollectionViewCell {
    static let reusableIdentifier = "MenuBarCell"
    
    lazy var itemTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            self.itemTitle.font = isSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 16)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(itemTitle)
        NSLayoutConstraint.activate([
            itemTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            itemTitle.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
