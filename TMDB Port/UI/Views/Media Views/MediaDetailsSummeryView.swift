//
//  MediaDetailsSummeryView.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 10..
//

import UIKit

class MediaDetailsSummeryView: UIView {
    let media: Media
    
    // Views
    private lazy var title: UILabel = {
        var view = UILabel()
        view.lineBreakMode = .byWordWrapping
        view.numberOfLines = 2
        view.font = UIFont.preferredFont(forTextStyle: .body).bold()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = media.title
        return view
    }()
    
    private lazy var summery: UILabel = {
        var view = UILabel()
        view.lineBreakMode = .byWordWrapping
        view.numberOfLines = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = media.overview
        return view
    }()
    
    private lazy var languageView: MediaLanguageView = {
        var view = MediaLanguageView(language: media.originalLanguage)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var ratingView: MediaRatingView = {
        var view = MediaRatingView(rating: media.voteAverage)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(movie: Media) {
        self.media = movie
        super.init(frame: .zero)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(title)
        addSubview(summery)
        addSubview(languageView)
        addSubview(ratingView)
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            title.topAnchor.constraint(equalTo: topAnchor),
            
            summery.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
            summery.trailingAnchor.constraint(equalTo: trailingAnchor),
            summery.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            languageView.topAnchor.constraint(equalTo: summery.bottomAnchor, constant: 16),
            languageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            ratingView.leadingAnchor.constraint(equalTo: languageView.trailingAnchor, constant: 8),
            ratingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ratingView.topAnchor.constraint(equalTo: summery.bottomAnchor, constant: 20)
        ])
    }
}
