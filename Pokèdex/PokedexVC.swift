//
//  PokedexVC.swift
//  Pokèdex
//
//  Created by Kyle Aquino on 6/23/18.
//  Copyright © 2018 Kyle Aquino. All rights reserved.
//

import UIKit
import AVFoundation

class PokedexVC: UIViewController {

    // ATTENTION! : MAKE HIGHER QUALITY POKEDEX EXPORTS
    var pokemon: Pokemon?
    
    var topCover = UIImageView(image: #imageLiteral(resourceName: "Top Cover"))
    var topCoverTopAnchor: NSLayoutConstraint?
    
    var bottomCover = UIImageView(image: #imageLiteral(resourceName: "Bottom Cover"))
    var bottomCoverBottomAnchor: NSLayoutConstraint?
    
    var inside = UIImageView(image: #imageLiteral(resourceName: "inside"))
    var insideScreenCover = UIView(frame: CGRect(x: 0, y: 0, width: 232, height: 186))
    var pokemonImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 75.32, height: 75.0))
    
    var nameLabel = UILabel()
    var idLabel = UILabel()
    var flavorLabel = UILabel()
    
    lazy var synth = AVSpeechSynthesizer()
    
    
    var pokedexIsOpen = false
    
    
    override func loadView() {
        super.loadView()
        layoutPokedex()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closePokedex)))
    }
    
    func layoutPokedex() {
        view.addSubview(inside)
        view.addSubview(pokemonImageView)
        view.addSubview(nameLabel)
        view.addSubview(idLabel)
        view.addSubview(flavorLabel)
        view.addSubview(insideScreenCover)
        view.addSubview(topCover)
        view.addSubview(bottomCover)
        
        pokemonImageView.backgroundColor = .clear
        insideScreenCover.backgroundColor = #colorLiteral(red: 0.1592961252, green: 0.1581234038, blue: 0.1601980627, alpha: 1)
        
        topCover.translatesAutoresizingMaskIntoConstraints = false
        bottomCover.translatesAutoresizingMaskIntoConstraints = false
        inside.translatesAutoresizingMaskIntoConstraints = false
        insideScreenCover.translatesAutoresizingMaskIntoConstraints = false
        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        flavorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            inside.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inside.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            inside.widthAnchor.constraint(equalToConstant: 276),
            inside.heightAnchor.constraint(equalToConstant: 386),
            insideScreenCover.centerXAnchor.constraint(equalTo: inside.centerXAnchor),
            insideScreenCover.centerYAnchor.constraint(equalTo: inside.centerYAnchor),
            insideScreenCover.widthAnchor.constraint(equalToConstant: 232),
            insideScreenCover.heightAnchor.constraint(equalToConstant: 186),
            pokemonImageView.topAnchor.constraint(equalTo: insideScreenCover.topAnchor, constant: 12),
            pokemonImageView.leftAnchor.constraint(equalTo: insideScreenCover.leftAnchor, constant: 12.05),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 75.32),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 75)
            ])
        
//        pokemonImageView.image = #imageLiteral(resourceName: "pikachu")
        
        NSLayoutConstraint.activate([
            idLabel.leftAnchor.constraint(equalTo: pokemonImageView.rightAnchor, constant: 12),
            idLabel.rightAnchor.constraint(equalTo: insideScreenCover.rightAnchor, constant: -12),
            idLabel.topAnchor.constraint(equalTo: pokemonImageView.topAnchor),
            idLabel.heightAnchor.constraint(equalToConstant: 25),
            
            nameLabel.leftAnchor.constraint(equalTo: idLabel.leftAnchor),
            nameLabel.rightAnchor.constraint(equalTo: idLabel.rightAnchor),
            nameLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 12),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            flavorLabel.leftAnchor.constraint(equalTo: pokemonImageView.leftAnchor),
            flavorLabel.rightAnchor.constraint(equalTo: idLabel.rightAnchor),
            flavorLabel.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: 12),
            flavorLabel.bottomAnchor.constraint(equalTo: insideScreenCover.bottomAnchor, constant: -12)
            ])
        
        idLabel.textAlignment = .center
        nameLabel.textAlignment = .center
        flavorLabel.textAlignment = .left
        
        idLabel.clipsToBounds = false
        nameLabel.clipsToBounds = false
        flavorLabel.clipsToBounds = false
        
        idLabel.font = UIFont(name: "Sun-Moon", size: 20)
        nameLabel.font = UIFont(name: "Sun-Moon", size: 14)
        flavorLabel.font = UIFont(name: "Geneva", size: 12)
        
// Data used for testing
//        idLabel.text = "#25"
//        nameLabel.text = "Pikachu"
//        flavorLabel.text = "It stores electricity in the electric sacs on its cheeks. When it releases pent-up energy in a burst, the electric power is equal to a lightning bolt."
        
        flavorLabel.numberOfLines = 0
        flavorLabel.adjustsFontForContentSizeCategory = true
        flavorLabel.adjustsFontSizeToFitWidth = true
        nameLabel.adjustsFontSizeToFitWidth = true
        
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
    
    func loadData() {
        if pokemon != nil {
            nameLabel.text = pokemon!.name
            idLabel.text = "#\(pokemon!.id)"
            flavorLabel.text = pokemon!.flavorText!
            pokemonImageView.image = pokemon!.image!
        }
    }
    
    func speakFlavorText(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = 0.45
        synth.speak(utterance)
    }
    
    @objc func openPokedex() {
        view.layoutIfNeeded()
        topCoverTopAnchor?.constant = -90
        bottomCoverBottomAnchor?.constant = 90
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
            self.insideScreenCover.alpha = 0
        }
        pokedexIsOpen = true
        speakFlavorText(pokemon!.flavorText!)
        
    }
    
    @objc func closePokedex() {
        synth.stopSpeaking(at: .immediate)
        topCoverTopAnchor?.constant = 0
        bottomCoverBottomAnchor?.constant = 0
        UIView.animate(withDuration: 1, animations: {
            self.view.layoutIfNeeded()
            self.insideScreenCover.alpha = 1
        }) { (done) in
            self.dismiss(animated: true, completion: nil)
        }
    }

}
