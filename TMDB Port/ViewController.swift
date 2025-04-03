//
//  ViewController.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 03..
//

import UIKit

class ViewController: UIViewController {
    var currentPage: BottomBarPage = .home
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let bottomToolbar = BottomToolbar(currentPage: currentPage)
        bottomToolbar.delegate = self
        view.addSubview(bottomToolbar)
        
        NSLayoutConstraint.activate([
            bottomToolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bottomToolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bottomToolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
}

extension ViewController: BottomToolbarDelegate {
    func bottomToolbar(_ toolbar: BottomToolbar, didSelectPage page: BottomBarPage) {
        self.currentPage = page
        print("the new current page is \(currentPage)")
    }
}
