//
//  HomeCoordinator.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 05..
//

import UIKit

class HomeCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HomeViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
