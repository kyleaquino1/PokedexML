//
//  MainVC.swift
//  Pokèdex
//
//  Created by Kyle Aquino on 6/18/18.
//  Copyright © 2018 Kyle Aquino. All rights reserved.
//

import UIKit
import AVFoundation

class MainVC: UIViewController {

    let cameraController = CameraVC()
    lazy var loadVC = LoadingVC()
    lazy var synth = AVSpeechSynthesizer()
    lazy var noPokemonLabel = UILabel()
    var classifier: ClassificationController!
    var cameraView: UIView!
    var imageView: UIImageView!
    let pokemonController = PokemonController()
    var pokemonFound: Pokemon?
    lazy var pokedex = PokedexVC()
   
    
    override func viewDidLoad() {
        print("\(view.frame.width), \(view.frame.height)")
        super.viewDidLoad()
        classifier = ClassificationController(delegate: self)
        addCamera()
        addImagePreview()
        addNoPokemonLabel()
        NotificationCenter.default.addObserver(self, selector: #selector(openPokedex), name: NSNotification.Name.presentPokemon, object: nil)
    }
    
    
    @objc func openPokedex(notification: Notification) {
        let pokemonController = notification.object as! PokemonController
        pokemonFound?.flavorText = pokemonController.flavorText
        if pokemonController.pokemonImage != nil {
            pokemonFound?.image = pokemonController.pokemonImage!
        }
        pokedex.pokemon = pokemonFound
        print("Loaded Pokemon! \(pokemonFound)")
        loadVC.remove()
        pokedex.loadData()
        pokedex.openPokedex()
    }
    
    func presentPokedex() {
        pokedex.modalPresentationStyle = .overCurrentContext
        self.present(pokedex, animated: true, completion: nil)
    }
    
    private func addCamera() {
        cameraView = UIView()
        self.view.addSubview(cameraView)
        cameraView.backgroundColor = .white
        cameraView.frame = self.view.frame
        cameraView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        cameraView.topAnchor.constraint(equalTo: self.view.topAnchor),
        cameraView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
        cameraView.heightAnchor.constraint(equalTo: self.view.heightAnchor)])
        
        self.addChild(cameraController)
        cameraController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        cameraView.addSubview(cameraController.view)
        cameraController.didMove(toParent: self)
    }
    
    private func addImagePreview() {
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 50))
        imageView.backgroundColor = .gray
        imageView.layer.opacity = 0.50
        self.cameraView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: cameraView.leftAnchor, constant: 16),
            imageView.bottomAnchor.constraint(equalTo: cameraView.bottomAnchor, constant: -16),
            imageView.widthAnchor.constraint(equalToConstant: 72),
            imageView.heightAnchor.constraint(equalToConstant: 128)])
    }
    
    func updateImage(image: UIImage) {
        self.imageView.image = image
        evaluateImage(image)
    }
    
    private func evaluateImage(_ image: UIImage) {
        classifier.updateClassifications(for: image)
    }
    
    func speakText(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = 0.4
        synth.speak(utterance)
    }
    
    private func addNoPokemonLabel() {
        noPokemonLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noPokemonLabel)
        noPokemonLabel.isHidden = true
        noPokemonLabel.text = "NO POKEMON DETECTED"
        noPokemonLabel.textColor = .black
        noPokemonLabel.numberOfLines = 1
        noPokemonLabel.sizeToFit()
        noPokemonLabel.font = UIFont(name: "Helvetica-nue", size: 24)
        noPokemonLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            noPokemonLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noPokemonLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noPokemonLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            noPokemonLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 12)
            ])
    }



}

extension MainVC: ClassificationControllerDelegate {
    func didFinishClassification(_ classification: (String, Float)) {
        print("Finished Classification \(classification.0) \(classification.1)")
        if classification.1 > 0.60 {
//            add(loadVC)
            presentPokedex()
            pokedex.add(loadVC)
            noPokemonLabel.isHidden = true
            for pokemon in PokemonType.allCases {
                if classification.0 == pokemon.rawValue {
                    let foundPokemon = Pokemon(name: pokemon.rawValue, id: pokemon.id)
                    print("name: \(foundPokemon.name) id: \(foundPokemon.id)")
                    pokemonController.getPokemonData(for: foundPokemon)
                    //foundPokemon.flavorText = flavorText
                    self.pokemonFound = foundPokemon
                }
            }
        } else {
            noPokemonLabel.isHidden = false
        }
    }
}
