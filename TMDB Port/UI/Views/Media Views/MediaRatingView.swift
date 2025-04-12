//
//  MediaRatingView.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 12..
//

import UIKit

class MediaRatingView: UIView {
    let rating: Double
    
    // Views
    private let starView: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(systemName: "star")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .orange
        return view
    }()
    
    private lazy var rate: UILabel = {
        var view = UILabel()
        view.text = String(rating)
        view.textColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(rating: Double) {
        self.rating = rating
        super.init(frame: .zero)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(rate)
        addSubview(starView)
        
        NSLayoutConstraint.activate([
            rate.leadingAnchor.constraint(equalTo: leadingAnchor),
            rate.topAnchor.constraint(equalTo: topAnchor),
            
            starView.leadingAnchor.constraint(equalTo: rate.trailingAnchor),
            starView.widthAnchor.constraint(equalToConstant: 20),
            starView.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
