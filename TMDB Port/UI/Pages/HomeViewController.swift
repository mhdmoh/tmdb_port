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

        let genreVC = makeGenreListViewController()
        embedGenreList(genreVC)
    }
    
    private func makeGenreListViewController() -> GenreListViewController {
        let genreVC = GenreListViewController()
        genreVC.genres = [
            Genre(id: 1, name: "Action"),
            Genre(id: 2, name: "Drama"),
            Genre(id: 3, name: "Comedy"),
            Genre(id: 4, name: "Horror")
        ]
        return genreVC
    }

    private func embedGenreList(_ genreVC: GenreListViewController) {
        addChild(genreVC)
        view.addSubview(genreVC.view)
        genreVC.didMove(toParent: self)

        genreVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            genreVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            genreVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            genreVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            genreVC.view.heightAnchor.constraint(equalToConstant: 100)
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
