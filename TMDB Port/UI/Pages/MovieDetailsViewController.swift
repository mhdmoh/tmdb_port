//
//  MovieDetailsViewController.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 09..
//

import UIKit

class MovieDetailsViewController: UIViewController {
    let movie: Media
    var coordinator: Coordinator?
    
    // MARK: - Views
    private lazy var navBar: DetailsNavBar = {
        let navBar = DetailsNavBar(title: movie.title ?? "Movie")
        navBar.coordinator = coordinator
        navBar.translatesAutoresizingMaskIntoConstraints = false
        return navBar
    }()
    
    private lazy var detailsHeader: MediaDetailsHeaderView = {
        var view = MediaDetailsHeaderView(media: movie)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    init(movie: Media) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Setup
    private func setupView() {
        view.addSubview(navBar)
        view.addSubview(detailsHeader)

        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 120),

            detailsHeader.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            detailsHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailsHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailsHeader.widthAnchor.constraint(equalTo: view.widthAnchor),
            detailsHeader.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
}
