//
//  CustomMenuBar.swift
//  CustomTabBar
//
//  Created by JunHwan Kim on 2023/03/26.
//

import UIKit

protocol CustomMenuBarDelegate: AnyObject {
    func didSelect(indexNum: Int)
}

class CustomMenuBar: UIView {
    
    weak var delegate: CustomMenuBarDelegate?
    
    private enum Metric {
        static let indicatorViewHeight = 2.0
    }
    
    lazy var menuBarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 30, height: 30)
        layout.minimumLineSpacing = 0.0
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    lazy var indicatorMarkView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        
        return view
    }()
    
    private lazy var indicatorMarkViewLeadingConstraint: NSLayoutConstraint = {
        return indicatorMarkView.leadingAnchor.constraint(equalTo: menuBarCollectionView.leadingAnchor)
    }()
    
    private lazy var indicatorMarkViewWidthConstraint: NSLayoutConstraint = {
        return indicatorMarkView.widthAnchor.constraint(equalTo: menuBarCollectionView.widthAnchor, multiplier:  1/CGFloat(items.count))
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setMenuBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var items: [UITabBarItem] = []
    
    private func setMenuBar() {
        addSubview(menuBarCollectionView)
        menuBarCollectionView.register(MenubarCell.self, forCellWithReuseIdentifier: MenubarCell.reusableIdentifier)
        menuBarCollectionView.delegate = self
        menuBarCollectionView.dataSource = self
        NSLayoutConstraint.activate([
            menuBarCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            menuBarCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            menuBarCollectionView.topAnchor.constraint(equalTo: topAnchor),
            menuBarCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Metric.indicatorViewHeight)
        ])
    }
    
    private func setIndicatorMarkView() {
        addSubview(indicatorMarkView)
        NSLayoutConstraint.activate([
            indicatorMarkView.topAnchor.constraint(equalTo: menuBarCollectionView.bottomAnchor),
            indicatorMarkView.heightAnchor.constraint(equalToConstant: Metric.indicatorViewHeight),
            indicatorMarkViewLeadingConstraint,
            indicatorMarkViewWidthConstraint
        ])
    }
    
    public func setItems(tabBarItems: [UITabBarItem]) {
        self.items = tabBarItems
        setIndicatorMarkView()
        menuBarCollectionView.reloadData()
    }
    
}

extension CustomMenuBar: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenubarCell.reusableIdentifier, for: indexPath) as? MenubarCell else { return MenubarCell() }
        cell.itemTitle.text = items[indexPath.row].title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        cell.isSelected = true
        UIView.animate(withDuration: 0.3) {
            self.indicatorMarkViewLeadingConstraint.constant = cell.frame.origin.x
            self.layoutIfNeeded()
        }
        delegate?.didSelect(indexNum: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        cell.isSelected = false
    }
}

extension CustomMenuBar: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        return CGSize(width: width/CGFloat(items.count), height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
