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
    var currentType: TrendingViewModel.TrendingType = .movies
    
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
        getData()
    }
    
    private func getData() {
        Task {
            await vm.getTrending(of: currentType)
        }
    }
    
    private func setupTypeControl() {
        view.addSubview(typeControl)
        typeControl.delegate = AnyCustomSegmentedControlsDelegate(self)
        NSLayoutConstraint.activate([
            typeControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            typeControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            typeControl.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}

extension TrendingListViewController: CustomSegmentedControlsDelegate {
    func customSegmentedControls(_ segmentedControls: CustomSegmentedControlsView<TrendingViewModel.TrendingType>, didSelectOption option: TrendingViewModel.TrendingType) {
        print("Selected option \(option.rawValue)")
        currentType = option
        getData()
    }
}
