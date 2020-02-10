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

//    codeScanner.cameraPosition(.front)
//    codeScanner?.showOverlayView = false
    codeScanner?.focusView?.scanLineBorder(with: .green, lineWidth: 4)
//    codeScanner?.focusView?.scanLineBorder(with: CGRect(x: 0, y: 0, width: 200, height: 200), color: .white, lineWidth: 5)

    codeScanner?.startScanning()
//    codeScanner.startScanning()
//    codeScanner.focusView?.scanLineImage(corner: <#T##UIImage?#>)

//    codeScanner.removeOverlay()
//    codeScanner.focusView.scanLineBorder(with: .green, lienWidth: 4)

//    codeScanner.focusView?.scanLineImage(corner: UIImage(named: "FocusType_1"))

//    codeScanner.focusView.scanLineImage(leftTop: UIImage(name'd: "ScanQR1_16x16_"), rightTop: UIImage(named: "ScanQR2_16x16_"), leftBottom: UIImage(named: "ScanQR3_16x16_"), rightBottom: UIImage(named: "ScanQR4_16x16_"))
//    codeScanner.focusView.scanLineImage(corner: UIImage(named: "FocusType_1"))

//        focusView.scanLineBorder(with: .green, lienWidth: 4)
    //    focusView.scanLineImage(corner: UIImage(named: "focus"))
    //    focusView.scanLineImage(leftTop: UIImage(named: "ScanQR1_16x16_"), rightTop: UIImage(named: "ScanQR2_16x16_"), leftBottom: UIImage(named: "ScanQR3_16x16_"), rightBottom: UIImage(named: "ScanQR4_16x16_"))

  }
}

extension ViewController: CodeScannerDelegate {
  func codeScanner(_ codeScanner: CodeScanner, didOutput value: String?, bounds: CGRect?, scannerType: ScannerType) {

    if value != nil {
//      codeScanner.stopScanning()
      codeScanner.focusView?.scanLineBorder(with: bounds ?? .zero, color: .white, lineWidth: 5)
      UIView.animate(withDuration: 0.75, animations: {
        self.view.layoutIfNeeded()
      }, completion: { _ in
//        UIView.animate(withDuration: 1.0, delay: 0, options: [], animations: {},
//                       completion: { _ in
//          codeScanner.stopScanning()
//        })
      })
    }
  }
}
