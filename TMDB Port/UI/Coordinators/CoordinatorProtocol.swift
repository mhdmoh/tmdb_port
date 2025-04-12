//
//  CoordinatorProtocol.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 05..
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController { get set }
    
    func start()
}

protocol MainCoordinatorDelegate: AnyObject {
    func switchTab(to page: BottomBarPage)
}

extension Coordinator {
    func popView() {
        navigationController.popViewController(animated: true)
    }
}
