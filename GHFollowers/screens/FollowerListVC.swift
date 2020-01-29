//
//  FollowerListVCViewController.swift
//  GHFollowers
//
//  Created by jesper kristiansen on 1/7/20.
//  Copyright © 2020 jesper kristiansen. All rights reserved.
//

import UIKit

protocol FollowerListVCDelegate: class {
    func didRequestFollowers(for username: String)
}

class FollowerListVC: UIViewController {
    
    enum Section {
        case main
    }
    
    public var username: String!
    private var collectionView: UICollectionView!;
    private var page = 1;
    private var hasMoreFollowers = true;
    // must be hash-able, enums are hashable
    private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    private var followers: [Follower] = []
    private var filteredFollowers: [Follower]? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
        configureSearchController()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    private func getFollowers(username: String, page: Int) {
        // https://seanallen.teachable.com/courses/681906/lectures/13465658
        // https://www.jbssolutions.com/garbage-collection-net-vs-arc-swift/
        // self is being 'captured' for the closure, therefore we need ot make it weak
        showLoadingView()
        NetworkManager.intance.getFollowers(for: username, page: page) { [weak self] result in
            // unwrap self
            guard let self = self else { return }
            self.dismissLoadingView()

            switch result {
            case .success(let followers):
                if followers.count < 100 {
                    self.hasMoreFollowers = false
                }
                DispatchQueue.main.async {
                    self.updateData(followers: followers)
                }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff happend", message: error.rawValue, buttonTitle: "Ok")
                
            }
        }
    }
    private func configure() {
        view.backgroundColor = .systemBackground;
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToFavoritesTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(view: view))
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
    }
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    private func configureSearchController() {
        let searchConteroller = UISearchController()
        searchConteroller.searchResultsUpdater = self;
        searchConteroller.searchBar.placeholder = "Search for username"
        searchConteroller.searchBar.delegate = self;
        // if not disabled then tap on filted item is not working
        searchConteroller.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchConteroller
    }
    
    private func updateData(followers: [Follower]) {
        self.followers.append(contentsOf: followers)
        if self.followers.isEmpty {
            let message = "This user doesn't have any followers 😀"
//            DispatchQueue.main.async {
                self.showEmptyStateView(with: message/*, in: self.view*/)
//            }
            return
        }
        updateList(followers: self.followers)
    }
    private func updateList(followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    @objc func addToFavoritesTapped() {
        showLoadingView()
        NetworkManager.intance.getUserInfo(for: username) { [weak self ]result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self](error) in
                    guard let self = self else { return }
                    guard let error = error else {
                        self.presentGFAlertOnMainThread(title: "Success", message: "You have successfully favorited this user 🎉", buttonTitle: "Ok")
                        return;
                    }
                    self.presentGFAlertOnMainThread(title: "Opps", message: error.rawValue, buttonTitle: "Ok")
                }
                break
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
 
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeList: [Follower] = filteredFollowers != nil ? filteredFollowers! : followers
        let destVC = UserInfoVC()
        destVC.user = activeList[indexPath.item]
        destVC.delegate = self
        // add nav controller to ge hte done button to dismiss the modal view
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}
extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard var filter = searchController.searchBar.text else { return; }
        filter = filter.lowercased()
        if filter.isEmpty {
            filteredFollowers = nil
            updateList(followers: self.followers)
        } else {
            filteredFollowers = followers.filter { follower in follower.login.lowercased().contains(filter) }
            updateList(followers: filteredFollowers!)
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredFollowers = nil
        updateList(followers: self.followers)
    }
}

extension FollowerListVC: FollowerListVCDelegate {
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollowers?.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(username: username, page: 1)
    }
    

}
