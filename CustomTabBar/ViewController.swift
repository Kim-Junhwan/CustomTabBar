//
//  ViewController.swift
//  CustomTabBar
//
//  Created by JunHwan Kim on 2023/03/26.
//

import UIKit

class ViewController: CustomTabBarViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Load ViewController")
        view.backgroundColor = .white
        setMenuBarView()
        setPageView()
    }
    
    func setMenuBarView() {
        view.addSubview(menuBar)
        NSLayoutConstraint.activate([
            menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    func setPageView() {
        view.addSubview(pageView)
        NSLayoutConstraint.activate([
            pageView.topAnchor.constraint(equalTo: menuBar.bottomAnchor),
            pageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
