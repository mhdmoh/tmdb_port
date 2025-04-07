//
//  TrendingListViewController.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 07..
//

import UIKit
import Swinject

class TrendingListViewController: UIViewController {
    private var vm: TrendingViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewMode()
    }
    
    private func setupViewMode(){
        vm = TrendingViewModel(service: Container.sharedContainer.resolve(TrendingServiceProtocol.self)!)
        Task {
            await vm.getTrending(of: .movies)
        }
    }
}
