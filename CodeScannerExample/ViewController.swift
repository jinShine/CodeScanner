//
//  ViewController.swift
//  CodeScannerExample
//
//  Created by Seungjin on 06/02/2020.
//  Copyright © 2020 jinnify. All rights reserved.
//

import UIKit
import CodeScanner

class ViewController: UIViewController {

  lazy var codeScanner = CodeScanner(self.view, scannerType: .qrCode)

  override func viewDidLoad() {
    super.viewDidLoad()

    codeScanner.overlayView?.focusView!.scanLineBorder(with: UIColor.green, lienWidth: 2)
//    codeScanner.focusView.scanLineBorder(with: .green, lienWidth: 2)
    codeScanner.avManager?.captureSession.startRunning()

  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }

  
  @IBAction func scan(_ sender: UIButton) {

  }


}

