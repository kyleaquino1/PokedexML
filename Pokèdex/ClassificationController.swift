//
//  ClassificationController.swift
//  Pokèdex
//
//  Created by Kyle Aquino on 6/18/18.
//  Copyright © 2018 Kyle Aquino. All rights reserved.
//

import UIKit
import CoreML
import Vision
import ImageIO

class ClassificationController {

    let delegate: ClassificationControllerDelegate!
    
    init(delegate: ClassificationControllerDelegate) {
        self.delegate = delegate
    }
    
    lazy var classificationRequest: VNCoreMLRequest = {
        do {
            // Use the generated swift file from CoreML of Pokemon Classifier
            let model = try VNCoreMLModel(for: PokemonClassifier().model)
            
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                self?.processClassifications(for: request, error: error)
            })
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to Load Pokemon ML Model: \(error)")
        }
    }()
    
    
    func updateClassifications(for image: UIImage) {

        print("Classifying")
        
        //let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))!
        let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))
        guard let ciImage = CIImage(image: image) else { fatalError("Unable to create \(CIImage.self) from \(image).") }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation!)
            do {
                try handler.perform([self.classificationRequest])
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
    }

    
    func processClassifications(for request: VNRequest, error: Error?) {
        
        DispatchQueue.main.async {
            guard let results = request.results else {
                print("UNABLE TO CLASSIFY IMAGE \n \(error!.localizedDescription)")
                return
            }
            
            let classifications = results as! [VNClassificationObservation]
            
            if classifications.isEmpty {
                print("NOTHING RECOGNIZED")
            } else {
                let topClassifications = classifications.prefix(2)
                let descriptions = topClassifications.map { classification in
                    return String(format: "  (%.2f) %@", classification.confidence, classification.identifier)
                }
                let description = (classifications.first!.identifier, classifications.first!.confidence)
                print("Classification: \(descriptions.joined(separator: "\n"))")
                self.delegate.didFinishClassification(description)
            }
        }
    }
}

protocol ClassificationControllerDelegate {
    func didFinishClassification(_ classification: (String, Float))
}
