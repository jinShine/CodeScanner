//
//  ViewController.swift
//  CodeScanner
//
//  Created by Seungjin on 10/02/2020.
//  Copyright © 2020 jinnify. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var codeView: UIView!

  var codeScanner: CodeScanner?

  override func viewDidLoad() {
    super.viewDidLoad()

    codeScanner = CodeScanner(codeView, scannerType: .qrCode)
    codeScanner?.delegate = self
    codeScanner?.showOverlayView = false
    
    
    // codeScanner.cameraPosition(.front)
    
     
    
    // codeScanner?.focusView?.scanLineImage(corner: UIImage(named: "FocusType_1"))
    
    // codeScanner?.focusView?.scanLineImage(leftTop: UIImage(named: "ScanQR1_16x16_"), rightTop: UIImage(named: "ScanQR2_16x16_"), leftBottom: UIImage(named: "ScanQR3_16x16_"), rightBottom: UIImage(named: "ScanQR4_16x16_"))

    // codeScanner.removeOverlay()
    
    // codeScanner?.stopScanning()
    print("codeViewFrame: ", codeView.frame)
    print("codeViewFrame: ", codeView.bounds)
    
    codeScanner?.startScanning()
    
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    codeScanner?.updateFrame()
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    print("viewDidAppear codeViewFrame: ", codeView.frame)
    print("viewDidAppear codeViewFrame: ", codeView.bounds)
  
    
    
//    codeScanner = CodeScanner(codeView, scannerType: .qrCode)
//    codeScanner?.delegate = self
//
//    codeScanner?.showOverlayView = false
//
//    codeScanner?.focusView?.scanLineBorder(with: .white, lineWidth: 3)
//
//    codeScanner?.startScanning()
  }
}

extension ViewController: CodeScannerDelegate {
  func codeScanner(_ codeScanner: CodeScanner, didOutput value: String?, bounds: CGRect?, scannerType: ScannerType) {

    if value != nil {
      guard
        let value = value,
        let bounds = bounds else { return }
      codeScanner.autoTrackingAnimation(bounds: bounds) { _ in
//        codeScanner.stopScanning()
      }
    }
  }
}
