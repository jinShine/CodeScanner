//
//  FocusView.swift
//  CodeScanner
//
//  Created by Seungjin on 06/02/2020.
//  Copyright © 2020 jinnify. All rights reserved.
//

import UIKit

public class FocusView: UIImageView {
  
  //MARK:- Outlets
  
  private let leftTopLayer = CAShapeLayer()
  private let rightTopLayer = CAShapeLayer()
  private let leftBottomLayer = CAShapeLayer()
  private let rightBottomLayer = CAShapeLayer()
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

//MARK:- Methods
extension FocusView {
  
  // Line Draw with UIBezierPath
  public func scanLineBorder(color: UIColor, lineWidth: CGFloat) {
    leftTopLayer.removeFromSuperlayer()
    rightTopLayer.removeFromSuperlayer()
    leftBottomLayer.removeFromSuperlayer()
    rightBottomLayer.removeFromSuperlayer()
    
    let leftTopBezierPath = UIBezierPath()
    leftTopBezierPath.move(to: CGPoint(x: bounds.minX + 15, y: bounds.minY - 2))
    leftTopBezierPath.addLine(to: CGPoint(x: bounds.minX - 2, y: bounds.minY - 2))
    leftTopBezierPath.addLine(to: CGPoint(x: bounds.minX - 2, y: bounds.minY + 15))
    leftTopLayer.path = leftTopBezierPath.cgPath
    leftTopLayer.lineWidth = lineWidth
    leftTopLayer.strokeColor = color.cgColor
    leftTopLayer.fillColor = UIColor.clear.cgColor
    layer.addSublayer(leftTopLayer)
    
    let rightTopBezierPath = UIBezierPath()
    rightTopBezierPath.move(to: CGPoint(x: bounds.maxX - 15, y: bounds.minY - 2))
    rightTopBezierPath.addLine(to: CGPoint(x: bounds.maxX + 2, y: bounds.minY - 2))
    rightTopBezierPath.addLine(to: CGPoint(x: bounds.maxX + 2, y: bounds.minY + 15))
    rightTopLayer.path = rightTopBezierPath.cgPath
    rightTopLayer.lineWidth = lineWidth
    rightTopLayer.strokeColor = color.cgColor
    rightTopLayer.fillColor = UIColor.clear.cgColor
    layer.addSublayer(rightTopLayer)
    
    let leftBottomBezierPath = UIBezierPath()
    leftBottomBezierPath.move(to: CGPoint(x: bounds.minX + 15, y: bounds.maxY + 2))
    leftBottomBezierPath.addLine(to: CGPoint(x: bounds.minX - 2, y: bounds.maxY + 2))
    leftBottomBezierPath.addLine(to: CGPoint(x: bounds.minX - 2, y: bounds.maxY - 15))
    leftBottomLayer.path = leftBottomBezierPath.cgPath
    leftBottomLayer.lineWidth = lineWidth
    leftBottomLayer.strokeColor = color.cgColor
    leftBottomLayer.fillColor = UIColor.clear.cgColor
    layer.addSublayer(leftBottomLayer)
    
    let rightBottomBezierPath = UIBezierPath()
    rightBottomBezierPath.move(to: CGPoint(x: bounds.maxX + 2, y: bounds.maxY - 15))
    rightBottomBezierPath.addLine(to: CGPoint(x: bounds.maxX + 2, y: bounds.maxY + 2))
    rightBottomBezierPath.addLine(to: CGPoint(x: bounds.maxX - 15, y: bounds.maxY + 2))
    rightBottomLayer.path = rightBottomBezierPath.cgPath
    rightBottomLayer.lineWidth = lineWidth
    rightBottomLayer.strokeColor = color.cgColor
    rightBottomLayer.fillColor = UIColor.clear.cgColor
    layer.addSublayer(rightBottomLayer)
  }
  
  // Image of each corner of FocusView
  public func scanLineImage(leftTop: UIImage?,
                            rightTop: UIImage?,
                            leftBottom: UIImage?,
                            rightBottom: UIImage?) {
    
    
    let leftTopImageView = UIImageView(frame: CGRect(x: -5, y: -5, width: 20, height: 20))
    leftTopImageView.image = leftTop
    leftTopImageView.backgroundColor = .clear
    addSubview(leftTopImageView)
    
    let rightopImageView = UIImageView(frame: CGRect(x: bounds.width - 15, y: -5, width: 20, height: 20))
    rightopImageView.image = rightTop
    rightopImageView.backgroundColor = UIColor.clear
    addSubview(rightopImageView)
    
    let rightBottomImageView = UIImageView(frame: CGRect(x: bounds.width - 15, y: bounds.height - 15, width: 20, height: 20))
    rightBottomImageView.image = rightBottom
    rightBottomImageView.backgroundColor = UIColor.clear
    addSubview(rightBottomImageView)
    
    let leftBottomImageView = UIImageView(frame: CGRect(x: -5, y: bounds.height - 15, width: 20, height: 20))
    leftBottomImageView.image = leftBottom
    leftBottomImageView.backgroundColor = UIColor.clear
    addSubview(leftBottomImageView)
    
  }
  
  // Image of FocusView
  public func scanLineImage(corner: UIImage?) {
    let focusFrame = CGRect(x: -5, y: -5, width: self.bounds.width + 10, height: self.bounds.height + 10)
    let cornerImageView = UIImageView(frame: focusFrame)
    cornerImageView.image = corner
    cornerImageView.contentMode = .scaleToFill
    cornerImageView.backgroundColor = UIColor.clear
    self.addSubview(cornerImageView)
    self.bringSubviewToFront(cornerImageView)
  }
}

