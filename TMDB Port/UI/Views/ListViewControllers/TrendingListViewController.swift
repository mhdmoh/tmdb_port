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
    
    let typeControl: CustomSegmentedControlsView = {
        let view = CustomSegmentedControlsView<TrendingViewModel.TrendingType>(label: "Trending", option: .movies)
        view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewMode()
        setupTypeControl()
    }
    
    private func setupViewMode(){
        view.backgroundColor = .systemBackground
        vm = TrendingViewModel(service: Container.sharedContainer.resolve(TrendingServiceProtocol.self)!)
        Task {
            await vm.getTrending(of: .movies)
        }
    }
    
    private func setupTypeControl() {
        view.addSubview(typeControl)
        NSLayoutConstraint.activate([
            typeControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            typeControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            typeControl.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
}
