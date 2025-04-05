//
//  ViewController.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 03..
//

import UIKit

class ViewController: UIViewController {
    var currentPage: BottomBarPage = .home
    weak var delegate: MainCoordinatorDelegate?
    private var currentNavController: UINavigationController?
    
    private var bottomToolbar: BottomToolbar!
    
    private var currentVC: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupBottomBar()
    }
    
    func displayContentViewController(_ navController: UINavigationController) {
        if let current = currentNavController {
            current.view.removeFromSuperview()
            current.removeFromParent()
        }

        addChild(navController)
        view.addSubview(navController.view)
        navController.view.frame = view.bounds
        navController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        navController.didMove(toParent: self)

        currentNavController = navController
        view.bringSubviewToFront(bottomToolbar)
    }
    
    private func setupBottomBar() {
        bottomToolbar = BottomToolbar(currentPage: currentPage)
        bottomToolbar.delegate = self
        view.addSubview(bottomToolbar)
        view.bringSubviewToFront(bottomToolbar)
        bottomToolbar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomToolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            bottomToolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            bottomToolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
}


extension ViewController: BottomToolbarDelegate {
    func bottomToolbar(_ toolbar: BottomToolbar, didSelectPage page: BottomBarPage) {
        delegate?.switchTab(to: page)
    }
}
