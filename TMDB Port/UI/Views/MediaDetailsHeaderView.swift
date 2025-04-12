//
//  MediaDetailsHeaderView.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 12..
//

import UIKit

class MediaDetailsHeaderView: UIView {
    let media: Media
    
    // MARK: - Views
    private lazy var movieBackdrop: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()
    
    private lazy var moviePoster: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .accent
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var summeryView: MediaDetailsSummeryView = {
        let view = MediaDetailsSummeryView(movie: media)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(media: Media) {
        self.media = media
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupView() {
        addSubview(movieBackdrop)
        addSubview(moviePoster)
        addSubview(summeryView)

        setupImages()
        setupConstraints()
    }
    
    private func setupImages() {
        movieBackdrop.loadImage(imagePath: media.backdropPath)
        moviePoster.loadImage(imagePath: media.posterPath)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            movieBackdrop.topAnchor.constraint(equalTo: topAnchor),
            movieBackdrop.widthAnchor.constraint(equalTo: widthAnchor),
            movieBackdrop.centerXAnchor .constraint(equalTo: centerXAnchor),
            movieBackdrop.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),

            moviePoster.topAnchor.constraint(equalTo: movieBackdrop.bottomAnchor, constant: -32),
            moviePoster.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            moviePoster.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            moviePoster.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),

            summeryView.topAnchor.constraint(equalTo: movieBackdrop.bottomAnchor, constant: 16),
            summeryView.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 12),
            summeryView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            summeryView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
