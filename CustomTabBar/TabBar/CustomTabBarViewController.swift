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
        menuBar.setItems(tabBarItems: [UITabBarItem(title: "일번", image: nil, tag: 0), UITabBarItem(title: "이번", image: nil, tag: 1), UITabBarItem(title: "삼번", image: nil, tag: 2)])
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
        print("Load CustomTabBarController")
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
            pageView.addSubview(selectViewController.view)
            configureConstraintsForContainedView(containedView: selectViewController.view)
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
