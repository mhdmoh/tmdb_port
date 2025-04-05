//
//  MainCoordinator.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 05..
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    private var homeNavController: UINavigationController!
    private var favoritesNavController: UINavigationController!
    private var searchNavController: UINavigationController!
    private var profileNavController: UINavigationController!
    
    private weak var rootViewController: ViewController?
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        // Initialize navigation controllers and their coordinators
        childCoordinators = [
            HomeCoordinator(navigationController: UINavigationController()),
            FavoritesCoordinator(navigationController: UINavigationController()),
            SearchCoordinator(navigationController: UINavigationController()),
            ProfileCoordinator(navigationController: UINavigationController())
        ]
        
        // Extract and assign navigation controllers and coordinators
        homeNavController = childCoordinators[0].navigationController
        favoritesNavController = childCoordinators[1].navigationController
        searchNavController = childCoordinators[2].navigationController
        profileNavController = childCoordinators[3].navigationController
        
        // Start all coordinators
        childCoordinators.forEach { $0.start() }
        
        // Initialize root view controller and set its delegate
        let vc = ViewController()
        vc.delegate = self
        rootViewController = vc
        
        // Push the main container view controller
        navigationController.pushViewController(vc, animated: false)
        
        // Display the default tab
        vc.displayContentViewController(homeNavController)
    }
}

extension MainCoordinator: MainCoordinatorDelegate {
    func switchTab(to page: BottomBarPage) {
        guard let vc = rootViewController else { return }
        switch page {
        case .home:
            vc.displayContentViewController(homeNavController)
        case .favorite:
            vc.displayContentViewController(favoritesNavController)
        case .search:
            vc.displayContentViewController(searchNavController)
        case .profile:
            vc.displayContentViewController(profileNavController)
        }
    }
}
