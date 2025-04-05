//
//  BottomToolbar.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 03..
//

import UIKit
import SwiftUI

protocol BottomToolbarDelegate: AnyObject {
    func bottomToolbar(_ toolbar: BottomToolbar, didSelectPage page: BottomBarPage)
}

enum BottomBarPage: CaseIterable {
    case home
    case favorite
    case search
    case profile
}

extension BottomBarPage {
    var icon: ImageResource {
        switch self {
        case .home:
            return .home
        case .favorite:
            return .star
        case .search:
            return .search
        case .profile:
            return .user
        }
    }
}

class BottomToolbar: UIView {
    private var currentPage: BottomBarPage
    weak var delegate: BottomToolbarDelegate?
    
    

    private var selectedBackground: UIView = {
        var view = UIView()
        view.backgroundColor = .accent
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(currentPage: BottomBarPage) {
        self.currentPage = currentPage
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        self.currentPage = .home
        super.init(coder: coder)
        setupView()
    }
    
    func getBarItem(for page: BottomBarPage) -> UIImage {
        var image = UIImage(resource: page.icon).withRenderingMode(.alwaysOriginal)
        image = image.withTintColor(.white)
        return image
    }
    
    private func setupView() {
        layer.cornerRadius = 30
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        let d = (name: "asd", age: 24)
        print(d.1)
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 60)
        ])
        
        configureGradientLayer()
        setupBackgroundAndTabs()
    }

    private func configureGradientLayer() {
        DispatchQueue.main.async {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [UIColor.gradientStart.cgColor,UIColor.gradientMid.cgColor, UIColor.gradientEnd.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
            gradientLayer.frame = self.bounds
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    }

    private func setupBackgroundAndTabs() {
        addBackground()
        setupTabs()
    }
    
    private func addBackground() {
        addSubview(selectedBackground)
        let index = BottomBarPage.allCases.firstIndex(of: currentPage) ?? 0
        let position = CGFloat(index) * (frame.width - 48) / 4

        NSLayoutConstraint.activate([
            selectedBackground.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 38 + position),
            selectedBackground.heightAnchor.constraint(equalToConstant: 50),
            selectedBackground.widthAnchor.constraint(equalToConstant: 50),
            selectedBackground.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    private func setupTabs() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let homeButton = UIButton()
        homeButton.setImage(getBarItem(for: .home), for: .normal)
        homeButton.accessibilityIdentifier = "home"

        let searchButton = UIButton()
        searchButton.setImage(getBarItem(for: .search), for: .normal)
        searchButton.accessibilityIdentifier = "search"

        let favoritesButton = UIButton()
        favoritesButton.setImage(getBarItem(for: .favorite), for: .normal)
        favoritesButton.accessibilityIdentifier = "favorite"

        let profileButton = UIButton()
        profileButton.setImage(getBarItem(for: .profile), for: .normal)
        profileButton.accessibilityIdentifier = "profile"

        homeButton.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
        searchButton.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
        favoritesButton.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)

        stackView.addArrangedSubview(homeButton)
        stackView.addArrangedSubview(favoritesButton)
        stackView.addArrangedSubview(searchButton)
        stackView.addArrangedSubview(profileButton)

        addSubview(stackView)

        // Add square aspect ratio constraints to each button
        [homeButton, searchButton, favoritesButton, profileButton].forEach { button in
            button.widthAnchor.constraint(equalTo: button.heightAnchor).isActive = true
        }

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 48),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -48),
            stackView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc private func tabButtonTapped(_ sender: UIButton) {
        guard let title = sender.accessibilityIdentifier else { return }
        
        let selectedPage: BottomBarPage
        switch title {
        case "home":
            selectedPage = .home
        case "favorite":
            selectedPage = .favorite
        case "search":
            selectedPage = .search
        case "profile":
            selectedPage = .profile
        default:
            return
        }
        
        // Call delegate method to notify about the page change
        delegate?.bottomToolbar(self, didSelectPage: selectedPage)
        
        // Animate the background to the new position
        let index = BottomBarPage.allCases.firstIndex(of: selectedPage) ?? 0
        let position = CGFloat(index) * (frame.width - 48 ) / 4
        UIView.animate(withDuration: 0.3) {
            self.selectedBackground.center.x =  38 + 25 + position
        }
        
        // Update the currentPage
        currentPage = selectedPage
    }
}
