//
//  ActorView.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 08..
//

import UIKit
import Kingfisher

class ActorView: UIView {
    let actor: Person
    
    // Views
    private let actorName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let actorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 40
        imageView.layer.borderColor = UIColor(resource: .gradientStart).cgColor
        imageView.layer.borderWidth = 1
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .accent
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    // Initializer
    init(actor: Person) {
        self.actor = actor
        super.init(frame: .zero)
        setupLayout()
        displayActorImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Layout Setup
    private func setupLayout() {
        addSubview(actorImage)
        addSubview(actorName)
        
        actorName.text = actor.name
        
        NSLayoutConstraint.activate([
            actorImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            actorImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            actorImage.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.2),
            
            actorName.topAnchor.constraint(equalTo: actorImage.bottomAnchor, constant: 8),
            actorName.leadingAnchor.constraint(equalTo: actorImage.leadingAnchor),
            actorName.trailingAnchor.constraint(equalTo: actorImage.trailingAnchor),
            actorName.bottomAnchor.constraint(equalTo: bottomAnchor),
            actorName.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // Image Display
    func displayActorImage() {
        actorImage.kf.indicatorType = .activity
        let pngSerializer = FormatIndicatedCacheSerializer.png
        
        if let profilePath = actor.profilePath, !profilePath.isEmpty,
           let url = URL(string: MConstants.posterUrl.rawValue + profilePath) {
            actorImage.kf.setImage(with: url, options: [.cacheSerializer(pngSerializer)])
            actorImage.backgroundColor = .clear
        } else {
            actorImage.image = UIImage(resource: .no)
            actorImage.contentMode = .scaleAspectFit
            actorImage.backgroundColor = .clear
        }
    }
}

class ActorCell: UICollectionViewCell {
    private var actorView: ActorView?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Configure the cell with an actor
    func configure(with actor: Person) {
        actorView?.removeFromSuperview()
        let view = ActorView(actor: actor)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        actorView = view

        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
