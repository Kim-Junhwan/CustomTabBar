//
//  CustomTabBarViewController.swift
//  CustomTabBar
//
//  Created by JunHwan Kim on 2023/03/26.
//

import UIKit

class CustomTabBarViewController: UIViewController {
    
    lazy var menuBar: CustomMenuBar = {
       let menuBar = CustomMenuBar()
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        return menuBar
    }()
    
    lazy var pageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    public var viewControllers: [UIViewController] = [] {
        didSet {
            setMenuBarItems(viewControllers)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        menuBar.delegate = self
        selectStartIndex(row: 0)
    }
    
    private func selectStartIndex(row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        menuBar.menuBarCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .left)
        didSelect(indexNum: 0)
    }
    
    private func setMenuBarItems(_ viewControllers: [UIViewController]) {
        var tabItems: [UITabBarItem] = []
        viewControllers.forEach { vc in
            
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            tabItems.append(vc.tabBarItem)
        }
        menuBar.setItems(tabBarItems: tabItems)
    }
    
    
}

extension CustomTabBarViewController: CustomMenuBarDelegate {
    
    func didSelect(indexNum: Int) {
        let selectViewController = viewControllers[indexNum]
        if !checkIncludeViewController(vc: selectViewController) {
            addChild(selectViewController)
            pageView.addSubview(selectViewController.view)
            configureConstraintsForContainedView(containedView: selectViewController.view)
            selectViewController.didMove(toParent: self)
        }
        hiddenSubViews()
        pageView.subviews.first { $0.isEqual(selectViewController.view) }?.isHidden = false
    }
    
    private func configureConstraintsForContainedView(containedView: UIView) {
        NSLayoutConstraint.activate([
            containedView.topAnchor.constraint(equalTo: pageView.topAnchor),
            containedView.leadingAnchor.constraint(equalTo: pageView.leadingAnchor),
            containedView.trailingAnchor.constraint(equalTo: pageView.trailingAnchor),
            containedView.bottomAnchor.constraint(equalTo: pageView.bottomAnchor)
        ])
    }
    
    private func checkIncludeViewController(vc: UIViewController) -> Bool {
        if pageView.subviews.contains(where: { $0.isEqual(vc.view) }) {
            return true
        } else {
            return false
        }
    }
    
    private func hiddenSubViews() {
        pageView.subviews.forEach { subView in
            subView.isHidden = true
        }
    }
    
}
