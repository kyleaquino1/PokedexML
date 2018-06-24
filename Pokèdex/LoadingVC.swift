//
//  LoadingVC.swift
//  Pokèdex
//
//  Created by Kyle Aquino on 6/23/18.
//  Copyright © 2018 Kyle Aquino. All rights reserved.
//

import UIKit

class LoadingVC: UIViewController {
    private lazy var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    private var pokeballActivity = CustomActivityIndicatorView(image: #imageLiteral(resourceName: "pokeball"))
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        pokeballActivity.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pokeballActivity)
//        view.addSubview(activityIndicator)
        
//        NSLayoutConstraint.activate([
//            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//            ])
        
        NSLayoutConstraint.activate([
            pokeballActivity.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -(#imageLiteral(resourceName: "pokeball").size.width / 2)),
            pokeballActivity.centerYAnchor.constraint(equalTo: view.centerYAnchor,  constant: -(#imageLiteral(resourceName: "pokeball").size.height / 2))
            ])
        
    }
    

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // We use a 0.5 second delay to not show an activity indicator
        // in case our data loads very quickly.
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            self?.pokeballActivity.startAnimating()
        }
    }
}
