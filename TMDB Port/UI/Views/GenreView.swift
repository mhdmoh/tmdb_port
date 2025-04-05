//
//  GenreView.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 05..
//

import UIKit

class GenreView: UIView {
    var genre: Genre
    var label: UILabel!
    var padding: CGFloat = 8
    
    init(genre: Genre) {
        self.genre = genre
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(){
        backgroundColor = UIColor(resource: .gray)
        layer.cornerRadius = 12
        layer.masksToBounds = true
        
        setupLabel()
    }
    
    private func setupLabel() {
        label = UILabel()
        label.text = genre.name
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2 * padding),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2 * padding),
            label.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
        ])
    }
}
