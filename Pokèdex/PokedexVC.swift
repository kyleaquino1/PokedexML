//
//  PokedexVC.swift
//  Pokèdex
//
//  Created by Kyle Aquino on 6/23/18.
//  Copyright © 2018 Kyle Aquino. All rights reserved.
//

import UIKit

class PokedexVC: UIViewController {

    // ATTENTION! : MAKE HIGHER QUALITY POKEDEX EXPORTS
    
    var topCover = UIImageView(image: #imageLiteral(resourceName: "Top Cover"))
    var topCoverTopAnchor: NSLayoutConstraint?
    
    var bottomCover = UIImageView(image: #imageLiteral(resourceName: "Bottom Cover"))
    var bottomCoverBottomAnchor: NSLayoutConstraint?
    
    var inside = UIImageView(image: #imageLiteral(resourceName: "inside"))
    var insideScreenCover = UIView(frame: CGRect(x: 0, y: 0, width: 232, height: 186))
    
    var pokedexIsOpen = false
    
    override func loadView() {
        super.loadView()
        layoutPokedex()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openPokedex)))
    }
    
    func layoutPokedex() {
        view.addSubview(inside)
        view.addSubview(insideScreenCover)
        view.addSubview(topCover)
        view.addSubview(bottomCover)
        
        insideScreenCover.backgroundColor = #colorLiteral(red: 0.1592961252, green: 0.1581234038, blue: 0.1601980627, alpha: 1)
        
        topCover.translatesAutoresizingMaskIntoConstraints = false
        bottomCover.translatesAutoresizingMaskIntoConstraints = false
        inside.translatesAutoresizingMaskIntoConstraints = false
        insideScreenCover.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        NSLayoutConstraint.activate([
            inside.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inside.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            inside.widthAnchor.constraint(equalToConstant: 276),
            inside.heightAnchor.constraint(equalToConstant: 386),
            insideScreenCover.centerXAnchor.constraint(equalTo: inside.centerXAnchor),
            insideScreenCover.centerYAnchor.constraint(equalTo: inside.centerYAnchor),
            insideScreenCover.widthAnchor.constraint(equalToConstant: 232),
            insideScreenCover.heightAnchor.constraint(equalToConstant: 186),
            ])
        
        topCoverTopAnchor = topCover.topAnchor.constraint(equalTo: inside.topAnchor)
        bottomCoverBottomAnchor = bottomCover.bottomAnchor.constraint(equalTo: inside.bottomAnchor)
        
        NSLayoutConstraint.activate([
            topCover.centerXAnchor.constraint(equalTo: inside.centerXAnchor),
            topCoverTopAnchor!,
            topCover.widthAnchor.constraint(equalToConstant: 319),
            topCover.heightAnchor.constraint(equalToConstant: 167),
            bottomCover.centerXAnchor.constraint(equalTo: inside.centerXAnchor),
            bottomCoverBottomAnchor!,
            bottomCover.widthAnchor.constraint(equalToConstant: 319),
            bottomCover.heightAnchor.constraint(equalToConstant: 167)
            ])
    }
    
    @objc func openPokedex() {
        view.layoutIfNeeded()
        if !pokedexIsOpen {
            topCoverTopAnchor?.constant = -90
            bottomCoverBottomAnchor?.constant = 90
            UIView.animate(withDuration: 1) {
                self.view.layoutIfNeeded()
                self.insideScreenCover.alpha = 0
            }
            pokedexIsOpen = true
        } else {
            topCoverTopAnchor?.constant = 0
            bottomCoverBottomAnchor?.constant = 0
            UIView.animate(withDuration: 1) {
                self.view.layoutIfNeeded()
                self.insideScreenCover.alpha = 1
            }
            pokedexIsOpen = false
        }
    }

}
