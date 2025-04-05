//
//  MainNavBar.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 05..
//

import UIKit

class MainNavBar: UIView {
    let logoView: UIView = {
        let image = UIImage(resource: .logoLong)
        var view = UIView()
        view.layer.contents = image.cgImage
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayout() {
        backgroundColor = .accent
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 120).isActive = true

        addSubview(logoView)
        NSLayoutConstraint.activate([
            logoView.heightAnchor.constraint(equalToConstant: 24),
            logoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            logoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            logoView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
        ])
    }
}
