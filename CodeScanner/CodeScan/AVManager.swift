//
//  AVManager.swift
//  CodeScanner
//
//  Created by Seungjin on 06/02/2020.
//  Copyright © 2020 jinnify. All rights reserved.
//

import UIKit
import AVFoundation

class AVManager: NSObject {

  let captureSession = AVCaptureSession()
  var videoPreviewLayer: AVCaptureVideoPreviewLayer!
  var captureInput: AVCaptureDeviceInput!
  var captureOutput: AVCaptureMetadataOutput!
  var cameraPosition: AVCaptureDevice.Position = .back {
    didSet { refresh() }
  }
  var cameraFlashMode: AVCaptureDevice.FlashMode = .off {
    didSet { refresh() }
  }
  weak var delegate: CodeScannerDelegate?
  
  private var containerView: UIView
  private var scannerType: ScannerType

  var resultHandler: ((AVMetadataMachineReadableCodeObject?, CodeScannerError?) -> Void)?

  init(containerView: UIView, scannerType: ScannerType) {
    self.containerView = containerView
    self.scannerType = scannerType
    super.init()

    setupCamera()
    setupVideoPreviewLayer()
  }

  private func setupCamera() {
    cameraDevice {
      cameraInput(device: $0)
      cameraOutput()
    }
  }

  private func cameraDevice(completion: (AVCaptureDevice) -> Void) {
    guard
      let captureDevice = AVCaptureDevice.default(
        .builtInWideAngleCamera, for: .video, position: cameraPosition
      )
      else {
        print("Failed to get the camera device")
        resultHandler?(nil, CodeScannerError.notSupported)
        return
    }

    completion(captureDevice)
  }

  private func cameraInput(device: AVCaptureDevice) {
    do {
      captureInput = try AVCaptureDeviceInput(device: device)
      captureSession.addInput(captureInput)
    } catch {
      print("Failed to input CaptureSession")
      resultHandler?(nil, CodeScannerError.inputError)
    }
  }

  private func cameraOutput() {
    captureOutput = AVCaptureMetadataOutput()
    captureSession.addOutput(captureOutput)
    captureOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)

    switch scannerType {
    case .qrCode:
      captureOutput.metadataObjectTypes = [.qr]
    case .barCode:
      captureOutput.metadataObjectTypes = [
        .upce,
        .code39,
        .code39Mod43,
        .code93,
        .code128,
        .ean8,
        .ean13,
        .aztec,
        .pdf417,
        .itf14,
        .interleaved2of5,
        .dataMatrix
      ]
    }
  }

  private func setupVideoPreviewLayer() {
    videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
    videoPreviewLayer.frame = containerView.layer.bounds
  }

  private func removeAllInput() {
    if let inputs = captureSession.inputs as? [AVCaptureDeviceInput] {
      inputs.forEach { captureSession.removeInput($0) }
    }
  }

  private func removeAllOutput() {
    if let outputs = captureSession.outputs as? [AVCaptureMetadataOutput] {
      outputs.forEach { captureSession.removeOutput($0) }
    }
  }

  private func refresh() {
    removeAllInput()
    removeAllOutput()
    setupCamera()
  }

}

extension AVManager: AVCaptureMetadataOutputObjectsDelegate {

  func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
    if captureSession.isRunning {
      if let metadataObject = metadataObjects.first {
        guard let object =  metadataObject as? AVMetadataMachineReadableCodeObject else { return }
//        let result = videoPreviewLayer.transformedMetadataObject(for: object)
        resultHandler?(object, nil)
      }
    }
  }

}
