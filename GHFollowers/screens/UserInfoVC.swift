//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by jesper kristiansen on 1/12/20.
//  Copyright © 2020 jesper kristiansen. All rights reserved.
//

import UIKit

protocol UserInfoVCDelegate: class {
    func didTapGithubProfile(for user: User)
    func didTapGithubFollowers(for user: User)
}

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView();
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    
    var user: Follower?
    weak var delegate: FollowerListVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissModal))
        navigationItem.rightBarButtonItem = doneButton
        
        NetworkManager.intance.getUserInfo(for: user!.login) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElements(with: user)
                }
                break
                
            case .failure(let error):
                print("error: \(error)")
                self.presentGFAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
                break
            }
        }
    }
    
    private func configureUIElements(with user: User) {
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self

        let followerItemVC = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.dateLabel.text = "GitHub since \(user.createdAt.convertoDisplayFormat())"
    }
    
    private func layoutUI() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(itemViewOne)
        itemViewOne.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(itemViewTwo)
        itemViewTwo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false

        let padding = CGFloat(20)
        let itemHeight = CGFloat(140)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),

            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),

            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),

            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds;
        childVC.didMove(toParent: self)
    }
    @objc func dismissModal(_ sender: UIViewController?) {
        dismiss(animated: true)
    }
}


extension UserInfoVC: UserInfoVCDelegate {
    func didTapGithubProfile(for user: User) {
        // show safari view controller
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The URL attached to this user is invalid", buttonTitle: "Ok")
            return
        }
        presentSafariView(withUrl: url)
    }
    
    func didTapGithubFollowers(for user: User) {
        // dismiss
        // tell follower list screen the new user
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No Followers", message: "This user has no followers ", buttonTitle: "Ok")
            return
        }
        if let delegate = self.delegate {
            delegate.didRequestFollowers(for: user.login)
            dismiss(animated: true)
        }
    }
}
