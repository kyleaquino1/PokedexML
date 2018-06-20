//
//  MainVC.swift
//  Pokèdex
//
//  Created by Kyle Aquino on 6/18/18.
//  Copyright © 2018 Kyle Aquino. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    let cameraController = CameraVC()
    var classifier: ClassificationController!
    var cameraView: UIView!
    var imageView: UIImageView!
    let pokemonController = PokemonController()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        classifier = ClassificationController(delegate: self)
        addCamera()
        addImagePreview()
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
        imageView.layer.opacity = 0.20
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



}

extension MainVC: ClassificationControllerDelegate {
    func didFinishClassification(_ classification: (String, Float)) {
        print("Finished Classification \(classification.0) \(classification.1)")
        if classification.1 > 0.60 {
            for pokemon in PokemonType.allCases {
                if classification.0 == pokemon.rawValue {
                    let foundPokemon = Pokemon(name: pokemon.rawValue, id: pokemon.id)
                    print("name: \(foundPokemon.name) id: \(foundPokemon.id)")
                    pokemonController.requestPokemon(url: foundPokemon.descURL)
                }
            }
        }
    }
}
