//
//  CameraVC.swift
//  Pokèdex
//
//  Created by Kyle Aquino on 6/18/18.
//  Copyright © 2018 Kyle Aquino. All rights reserved.
//

import UIKit
import AVFoundation

class CameraVC: UIViewController, UIGestureRecognizerDelegate {

    let captureSession = AVCaptureSession()
    let previewView = CameraView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didMove(toParent parent: UIViewController?) {
        configureCamera()
        setupView()
    }
    
    
    private func configureCamera() {
        captureSession.beginConfiguration()
        // Setup Camera Device
        let videoDevice = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera,
                                                  for: .video, position: .unspecified)
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!), captureSession.canAddInput(videoDeviceInput) else { return }
        captureSession.addInput(videoDeviceInput)
        
        // Photo Outputs
        let photoOutput = AVCapturePhotoOutput()
        guard captureSession.canAddOutput(photoOutput) else { return }
        captureSession.sessionPreset = .hd1920x1080
        captureSession.addOutput(photoOutput)
        
        captureSession.commitConfiguration()
        
        // Set Preview
        previewView.videoPreviewLayer.session = self.captureSession
        captureSession.startRunning()
        
    }
    
    private func setupView() {
        previewView.frame = self.view.frame
        self.view.addSubview(previewView)
        
        // Setup Tap Recognizer
        let tap = UITapGestureRecognizer(target: self, action: #selector(capturePhoto))
        tap.delegate = self
        previewView.addGestureRecognizer(tap)
    }
    
    @objc func capturePhoto() {
        if let output = captureSession.outputs.first as? AVCapturePhotoOutput {
            
            let settings = AVCapturePhotoSettings()
            settings.flashMode = .off
            
            output.capturePhoto(with: settings, delegate: self)
        }
    }
}

extension CameraVC: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let data = photo.fileDataRepresentation() {
            let capturedImage = UIImage(data: data)!
            if let parent = self.parent as? MainVC {
                parent.updateImage(image: capturedImage)
            }
        }
    }
}
