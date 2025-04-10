//
//  SceneDelegate.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 03..
//

import UIKit
import Swinject

extension Container {
    static let sharedContainer: Container = {
        var container = Container()
        container.register(APIClientProtocol.self) { resolver in
            return APIClient()
        }
        
        container.register(GenreDSProtocol.self) { resolver in
            return GenresDS(client: resolver.resolve(APIClientProtocol.self)!, endpoints: GenreEndpoints())
        }
        
        container.register(GenreRepoProtocol.self) { resolver in
            return GenreRepo(remoteDS: resolver.resolve(GenreDSProtocol.self)!)
        }
        
        container.register(GenreServiceProtocol.self) { resolver in
            return GenreService(repo: resolver.resolve(GenreRepoProtocol.self)!)
        }
        
        container.register(TrendingDSProtocol.self) { resolver in
            return TrendingDS(client: resolver.resolve(APIClientProtocol.self)!, endpoint: TrendingEndpoints())
        }
        
        container.register(TrendingRepoProtocol.self) { resolver in
            return TrendingRepo(remoteDS: resolver.resolve(TrendingDSProtocol.self)!)
        }
        
        container.register(TrendingServiceProtocol.self) { resolver in
            return TrendingService(repo: resolver.resolve(TrendingRepoProtocol.self)!)
        }
        
        return container
    }()
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        let navigationController = UINavigationController()
        coordinator = MainCoordinator(navigationController: navigationController)
        coordinator?.start()
        
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

