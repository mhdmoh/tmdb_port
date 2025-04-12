//
//  TrendingListViewController.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 07..
//

import UIKit
import Swinject

protocol TrendingListViewControllerDelegate: AnyObject {
    func didSelectMovie(_ movie: Media)
    func didSelectTVShow(_ tvShow: Media)
    func didSelectPerson(_ person: Person)
}

class TrendingListViewController: UIViewController {
    private var vm: TrendingViewModel!
    var currentType: TrendingViewModel.TrendingType = .movies
    weak var delegate: TrendingListViewControllerDelegate?

    private let typeControl: CustomSegmentedControlsView = {
        let view = CustomSegmentedControlsView<TrendingViewModel.TrendingType>(label: "Trending", option: .movies)
        view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ActorCell.self, forCellWithReuseIdentifier: "ActorCell")
        collectionView.register(MediaCell.self, forCellWithReuseIdentifier: "MediaCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewMode()
        setupTypeControl()
        setupCollectionView()
    }
    
    private func setupViewMode(){
        view.backgroundColor = .systemBackground
        vm = TrendingViewModel(service: Container.sharedContainer.resolve(TrendingServiceProtocol.self)!)
        getData()
    }
    
    private func getData() {
        Task {
            await vm.getTrending(of: currentType)
            self.collectionView.reloadData()
        }
    }
    
    private func setupTypeControl() {
        view.addSubview(typeControl)
        typeControl.delegate = self
        NSLayoutConstraint.activate([
            typeControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            typeControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            typeControl.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: typeControl.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 200)
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

extension TrendingListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.itemCount(from: currentType)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch currentType {
        case .movies, .shows:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCell", for: indexPath) as! MediaCell
            cell.configure(with: vm.media[indexPath.item])
            return cell
        case .people:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActorCell", for: indexPath) as! ActorCell
            cell.configure(with: vm.people[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 96, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch currentType {
        case .movies:
            let movie = vm.media[indexPath.item]
            delegate?.didSelectMovie(movie)
        case .shows:
            let show = vm.media[indexPath.item]
            delegate?.didSelectTVShow(show)
        case .people:
            let person = vm.people[indexPath.item]
            delegate?.didSelectPerson(person)
        }
    }
}
