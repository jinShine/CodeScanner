//
//  CodeScanner.swift
//  CodeScanner
//
//  Created by Seungjin on 06/02/2020.
//  Copyright © 2020 jinnify. All rights reserved.
//

import UIKit
import AVFoundation

public class CodeScanner: NSObject {

  weak var delegate: CodeScannerDelegate?
  
  public let containerView: UIView
  public var overlayView: OverlayView
  public var focusView: FocusView?
  public var showOverlayView: Bool = true {
    didSet {
      if !showOverlayView {
        removeOverlay()
      }
    }
  }

  private var avManager: AVManager
  private let scannerType: ScannerType

  public init(_ view: UIView, scannerType: ScannerType) {
    self.containerView = view
    self.scannerType = scannerType
    self.overlayView = OverlayView(frame: containerView.frame, scannerType: scannerType)
    self.avManager = AVManager(containerView: containerView, scannerType: scannerType)
    super.init()
    
    setupScanner()
  }

  private func setupScanner() {
    containerView.layer.addSublayer(avManager.videoPreviewLayer)
    containerView.addSubview(overlayView)
  }

  private func removeOverlay() {
    self.overlayView.removeFromSuperview()

    let size = focusSize(containerView, scannerType: scannerType)
//    let focusView = FocusView(frame: CGRect(
//      x: containerView.bounds.midX - (size.width / 2), y: containerView.bounds.midY - (size.height / 2), width: size.width, height: size.height)
//    )
    let focusView = FocusView(frame: CGRect(x: containerView.bounds.midX - (size.width / 2), y: containerView.bounds.midY - (size.height / 2), width: size.width, height: size.height))
    self.focusView = focusView
    containerView.addSubview(focusView)

    UIView.animate(withDuration: 0.7, delay: 0, options: [.repeat, .autoreverse], animations: {
      focusView.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
    }, completion: nil)
  }

  public func startScanning() {
    avManager.resultHandler = { [weak self] object, error in
      guard let self = self else { return }

      if error != nil  {
        print(error)
        //error delegate
        return
      }

      if let object = object {
        let transformedObject = self.avManager.videoPreviewLayer.transformedMetadataObject(for: object)
        self.delegate?.codeScanner(self, didOutput: object.stringValue, bounds: transformedObject?.bounds, scannerType: self.scannerType)
      }
    }
    avManager.captureSession.startRunning()
  }

  public func stopScanning() {
    avManager.captureSession.stopRunning()
  }

  public func cameraPosition(_ position: AVCaptureDevice.Position) {
    avManager.cameraPosition = position
  }

}
