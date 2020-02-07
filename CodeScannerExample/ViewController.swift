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

  @IBOutlet weak var scanView: UIView!

  var codeScanner: CodeScanner?

  override func viewDidLoad() {
    super.viewDidLoad()

    codeScanner = CodeScanner(scanView, scannerType: .qrCode)

//    codeScanner.overlayView?.focusView!.scanLineBorder(with: UIColor.green, lienWidth: 2)
    codeScanner?.startScanning()

  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }

  
  @IBAction func scan(_ sender: UIButton) {

  }


}

