//
//  UIViewControllerExtension.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 9/8/21.
//

import UIKit

var vSpinner: UIView?

extension UIViewController {
    func showSpinner(onView: UIView) {
        if vSpinner == nil {
            let spinnerView = UIView.init(frame: onView.bounds)
            spinnerView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
            let activityIndicatorView = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
            activityIndicatorView.startAnimating()
            activityIndicatorView.center = spinnerView.center
            
            DispatchQueue.main.async {
                let keyWindow = UIApplication.shared.connectedScenes
                        .filter({$0.activationState == .foregroundActive})
                        .map({$0 as? UIWindowScene})
                        .compactMap({$0})
                        .first?.windows
                        .filter({$0.isKeyWindow}).first
                
                guard let currentWindow = keyWindow else { return }
                spinnerView.addSubview(activityIndicatorView)
                currentWindow.addSubview(spinnerView)
            }
            
            vSpinner = spinnerView
        }
    }
    
    func hideSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
