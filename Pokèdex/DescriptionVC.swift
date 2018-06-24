//
//  DescriptionVC.swift
//  Pokèdex
//
//  Created by Kyle Aquino on 6/21/18.
//  Copyright © 2018 Kyle Aquino. All rights reserved.
//

import UIKit
import AVFoundation

class DescriptionVC: UIViewController, UIGestureRecognizerDelegate {

    var imageView: UIImageView!
    var flavorTextLabel: UILabel!
    var nameLabel: UILabel!
    var idLabel: UILabel!
    var holderView: UIView!
    var pokemon: Pokemon?
    lazy var synth = AVSpeechSynthesizer()
    lazy var utterance = AVSpeechUtterance(string: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.utterance = AVSpeechUtterance(string: pokemon!.flavorText!)
        utterance.rate = 0.4
        view.backgroundColor = .clear
        view.isOpaque = false
        setupView()
        synth.speak(utterance)
    }
    
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.load(url: pokemon.imgURL)
        flavorTextLabel = UILabel()
        nameLabel = UILabel()
        idLabel = UILabel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        pokemon = nil
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        holderView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height - 70))
        view.addSubview(holderView)
        holderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            holderView.widthAnchor.constraint(equalToConstant: view.frame.width - 64),
            holderView.heightAnchor.constraint(equalToConstant: view.frame.height - 150),
            holderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            holderView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
       
        holderView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        holderView.isOpaque = true
        holderView.layer.opacity = 1.0
        holderView.layer.cornerRadius = 5.0
        holderView.layer.shadowOpacity = 0.70
        holderView.layer.shadowOffset = CGSize(width: 5, height: 5)
        holderView.layer.shadowColor = UIColor.black.cgColor
        
        
        
        holderView.addSubview(imageView)
        holderView.addSubview(flavorTextLabel)
        holderView.addSubview(nameLabel)
        holderView.addSubview(idLabel)
        setupImageView()
        setupFlavorTextView()
        setupNameAndIdView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeView))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    @objc func closeView() {
        synth.stopSpeaking(at: .immediate)
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.leadingAnchor.constraint(equalTo: holderView.leadingAnchor, constant: 16),
            imageView.topAnchor.constraint(equalTo: holderView.topAnchor, constant: 16)
            ])
        
    }
    
    private func setupFlavorTextView() {
        flavorTextLabel.translatesAutoresizingMaskIntoConstraints = false
        flavorTextLabel.text = pokemon!.flavorText!
        flavorTextLabel.textColor = .black
        flavorTextLabel.numberOfLines = 0
        flavorTextLabel.sizeToFit()
        flavorTextLabel.font = UIFont(name: "Helvetica-nue", size: 15)
        flavorTextLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            flavorTextLabel.leadingAnchor.constraint(equalTo: holderView.leadingAnchor, constant: 16),
            flavorTextLabel.trailingAnchor.constraint(equalTo: holderView.trailingAnchor, constant: -16),
            flavorTextLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16)
            ])
        
    }
    
    private func setupNameAndIdView() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.text = "Name: \(pokemon!.name)"
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0
        nameLabel.sizeToFit()
        nameLabel.font = UIFont(name: "Helvetica-nue", size: 18)
        nameLabel.textAlignment = .left
        
        idLabel.text = "ID: \(pokemon!.id)"
        idLabel.textColor = .black
        idLabel.numberOfLines = 0
        idLabel.sizeToFit()
        idLabel.font = UIFont(name: "Helvetica-nue", size: 15)
        idLabel.textAlignment = .left
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
            idLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            idLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12)
            
            ])
        
    }
    
}

