//
//  MediaLanguageView.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 12..
//

import UIKit

class MediaLanguageView: UIView {
    let language: String
    
    // Views
    private lazy var languageLabel: UILabel = {
        var view = UILabel()
        view.text = language
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let background: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(resource: .backgroundGray)
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    init(language: String) {
        self.language = language
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(background)
        addSubview(languageLabel)
        
        
        DispatchQueue.main.async {
            self.widthAnchor.constraint(equalToConstant: self.languageLabel.frame.width + 16).isActive = true
            self.heightAnchor.constraint(equalToConstant: self.languageLabel.frame.height + 4).isActive = true

            NSLayoutConstraint.activate([
                self.background.widthAnchor.constraint(equalTo: self.widthAnchor),
                self.background.heightAnchor.constraint(equalTo: self.heightAnchor),
                self.languageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                self.languageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            ])
        }
    }
}
