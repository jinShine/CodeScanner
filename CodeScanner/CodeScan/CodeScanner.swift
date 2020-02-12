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
  public var focusView: FocusView? {
    set { overlayView.focusView = newValue }
    get { return overlayView.focusView }
    
  }
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
    self.focusView = FocusView(frame: CGRect(
      x: containerView.center.x - (size.width / 2),
      y: containerView.center.y - (size.height / 2),
      width: size.width,
      height: size.height)
    )

    containerView.addSubview(self.focusView!)
    containerView.bringSubviewToFront(self.focusView!)
    
    bounceAnimation()
  }
  
  private func bounceAnimation() {
    UIView.animate(
      withDuration: 0.7,
      delay: 0,
      options: [.repeat, .autoreverse],
      animations: {
        self.focusView?.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
    }, completion: nil)
  }
  
  public func updateFrame() {
//    self.overlayView.removeFromSuperview()
//    self.focusView?.removeFromSuperview()

//    self.overlayView = OverlayView(frame: containerView.frame, scannerType: scannerType)
//    setupScanner()
//    self.avManager = AVManager(containerView: containerView, scannerType: scannerType)

    self.overlayView.frame = containerView.frame
//    self.overlayView.setupOverlayView()
//    self.overlayView.addMask()

    let size = focusSize(containerView, scannerType: scannerType)
    print("#1", self.focusView?.frame)
    self.focusView?.frame = CGRect(
    x: containerView.center.x - (size.width / 2),
    y: containerView.center.y - (size.height / 2),
    width: size.width,
    height: size.height)
    print("#2", self.focusView?.frame)
    overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    overlayView.mask(withRect: focusView!.frame, inverse: true)

    bounceAnimation()
//    self.overlayView.addMask()

//    self.focusView?.frame = CGRect(
//    x: containerView.center.x,
//    y: containerView.center.y,
//    width: 50,
//    height: 50)

//    self.focusView?.setNeedsDisplay()



//    self.focusView?.setNeedsLayout()
//    self.focusView?.layoutIfNeeded()

//    self.overlayView.frame = .zero
//    self.focusView?.removeFromSuperview()
//    setupScanner()

//    if !showOverlayView {
//      removeOverlay()
//    }
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
  
  public func autoTrackingAnimation(bounds: CGRect, completion: ((Bool) -> Void)?) {
    guard !showOverlayView else { return }


    UIView.animate(withDuration: 0.5, animations: { [weak self] in
      switch self?.scannerType {
      case .qrCode:
        self?.focusView?.frame = bounds
      case .barCode:
        self?.focusView?.frame = CGRect(x: bounds.minX, y: bounds.midY, width: bounds.width, height: bounds.width / 3)
      case .none: fatalError()
      }
    }, completion: completion)
  }
  
}
