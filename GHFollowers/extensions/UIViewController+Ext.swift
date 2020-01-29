//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by jesper kristiansen on 1/7/20.
//  Copyright © 2020 jesper kristiansen. All rights reserved.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView!

extension UIViewController {
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alert = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle )
            alert.modalPresentationStyle = .overFullScreen
            alert.modalTransitionStyle = .crossDissolve;
            self.present(alert, animated: true)
        }
    }
    
    func presentSafariView(withUrl: URL) {
        let safariVC = SFSafariViewController(url: withUrl)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0;
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false;
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        guard let _ = containerView else { return }
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func showEmptyStateView(with message: String, in view: UIView? = nil) {
        DispatchQueue.main.async {
            let emptyStateView = GFEmptyStateView(message: message)
            emptyStateView.frame = view != nil ? view!.bounds : self.view.bounds
            self.view.addSubview(emptyStateView)
        }
    }
}
