//
//  HomeViewController.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 05..
//

import UIKit

class HomeViewController: UIViewController {
    public var coordinator: HomeCoordinator?
    private var genreVC: GenreListViewController!
    private var trendingVC: TrendingListViewController!
    
    let navBar: MainNavBar = {
        var view = MainNavBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()

        genreVC = makeGenreListViewController()
        embedGenreList()
        
        trendingVC = makeTrendingListViewController()
        embedTrendingList()
        
    }
    
    private func makeGenreListViewController() -> GenreListViewController {
        let genreVC = GenreListViewController()
        return genreVC
    }
    
    private func makeTrendingListViewController() -> TrendingListViewController {
        let trendingVC = TrendingListViewController()
        return trendingVC
    }

    private func embedTrendingList() {
        addChild(trendingVC)
        view.addSubview(trendingVC.view)
        trendingVC.didMove(toParent: self)
        
        trendingVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            trendingVC.view.topAnchor.constraint(equalTo: genreVC.view.bottomAnchor, constant: 32),
            trendingVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trendingVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            trendingVC.view.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func embedGenreList() {
        addChild(genreVC)
        view.addSubview(genreVC.view)
        genreVC.didMove(toParent: self)

        genreVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            genreVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            genreVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            genreVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            genreVC.view.heightAnchor.constraint(equalToConstant: 70)
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
