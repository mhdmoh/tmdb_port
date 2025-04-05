//
//  HomeViewController.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 05..
//

import UIKit

class HomeViewController: UIViewController {
    public var coordinator: HomeCoordinator?
    
    let navBar: MainNavBar = {
        var view = MainNavBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
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
