//
//  ViewController.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 03..
//

import UIKit

class ViewController: UIViewController {
    var currentPage: BottomBarPage = .home
    let navBar: MainNavBar = {
        var view = MainNavBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupBottomBar()
        setUpNavBar()
    }
    
    private func setupBottomBar() {
        let bottomToolbar = BottomToolbar(currentPage: currentPage)
        bottomToolbar.delegate = self
        view.addSubview(bottomToolbar)
        NSLayoutConstraint.activate([
            bottomToolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            bottomToolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            bottomToolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
    private func setUpNavBar(){
        view.addSubview(navBar)
        NSLayoutConstraint.activate([
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.topAnchor.constraint(equalTo: view.topAnchor),
        ])
    }
}

extension ViewController: BottomToolbarDelegate {
    func bottomToolbar(_ toolbar: BottomToolbar, didSelectPage page: BottomBarPage) {
        self.currentPage = page
        print("the new current page is \(currentPage)")
    }
}
