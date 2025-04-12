//
//  DetailsNavBar.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 09..
//

import UIKit

class DetailsNavBar: UIView {
    let title: String
    weak var coordinator: Coordinator?
    
    // Views
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title3).bold()
        label.textColor = .white
        return label
    }()
    
    private let backBtn: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(weight: .bold)
        button.setImage(UIImage(systemName: "arrow.left", withConfiguration: config), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        return button
    }()
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(titleLabel)
        titleLabel.text = title
        
        addSubview(backBtn)
        backBtn.addTarget(self, action: #selector(onBackClicked(_:)), for: .touchUpInside)
        
        backgroundColor = .accent
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        NSLayoutConstraint.activate([
            backBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            backBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            backBtn.widthAnchor.constraint(equalToConstant: 40),
            backBtn.heightAnchor.constraint(equalToConstant: 40),
            
            titleLabel.leadingAnchor.constraint(equalTo: backBtn.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80),
            titleLabel.topAnchor.constraint(equalTo: backBtn.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: backBtn.bottomAnchor),
        ])
    }
    
    @objc private func onBackClicked(_ sender: UIButton) {
        print("Clicked the back btn")
        coordinator?.popView()
    }
}
