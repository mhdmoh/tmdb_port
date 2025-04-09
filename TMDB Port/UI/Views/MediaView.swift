//
//  MediaView.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 09..
//

import UIKit
import Kingfisher

class MediaView: UIView {
    let media: Media
    
    // Views
    private let posterView: UIImageView = {
        var view = UIImageView()
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .accent
        return view
    }()
    
    private let titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    init(media: Media) {
        self.media = media
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        addSubview(posterView)
        addSubview(titleLabel)
        
        titleLabel.text = media.title ?? media.name ?? ""
        
        NSLayoutConstraint.activate([
            posterView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            posterView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8),
            posterView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            
            titleLabel.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: posterView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: posterView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        displayActorImage()
    }
    
    // Image Display
    func displayActorImage() {
        posterView.kf.indicatorType = .activity
        let pngSerializer = FormatIndicatedCacheSerializer.png
        
        if let posterPath = media.posterPath, !posterPath.isEmpty,
           let url = URL(string: MConstants.posterUrl.rawValue + posterPath) {
            posterView.kf.setImage(with: url, options: [.cacheSerializer(pngSerializer)])
            posterView.backgroundColor = .clear
        } else {
            posterView.image = UIImage(resource: .no)
            posterView.contentMode = .scaleAspectFit
            posterView.backgroundColor = .clear
        }
    }
}

final class MediaCell: UICollectionViewCell {
    var mediaView: MediaView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Configure the cell with a media item
    func configure(with media: Media) {
        mediaView?.removeFromSuperview()
        let view = MediaView(media: media)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        mediaView = view

        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
