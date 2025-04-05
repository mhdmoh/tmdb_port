//
//  FavoritesCoordinator 2.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 05..
//

import UIKit

class ProfileCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ProfileViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
