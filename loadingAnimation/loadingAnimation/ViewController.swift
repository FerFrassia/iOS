//
//  ViewController.swift
//  loadingAnimation
//
//  Created by Fernando N. Frassia on 5/11/18.
//  Copyright © 2018 Fernando N. Frassia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textLabel: CountingLabel!
    
    var circleLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTrackLayer()
        loadCircleLayer()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateStroke)))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textLabel.count(fromValue: 0, to: 100, withDuration: 4, andAnimationType: .Linear, andCounterType: .Int)
        animateStroke()
    }
    
    func loadTrackLayer() {
        var trackLayer = CAShapeLayer()
        createCircle(withLayer: &trackLayer)
        designStroke(withLayer: &trackLayer, withColor: UIColor.darkGray.withAlphaComponent(0.5), animated: false)
        view.layer.addSublayer(trackLayer)
    }
    
    func loadCircleLayer() {
        createCircle(withLayer: &circleLayer)
        designStroke(withLayer: &circleLayer, withColor: UIColor.red, animated: true)
        view.layer.addSublayer(circleLayer)
    }
    
    @objc private func animateStroke() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 5
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        circleLayer.add(basicAnimation, forKey: "basic")
    }
    
    func createCircle(withLayer layer: inout CAShapeLayer) {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 100, startAngle: -CGFloat.pi/2, endAngle: 2*CGFloat.pi, clockwise: true)
        layer.path = circularPath.cgPath
    }
    
    func designStroke(withLayer layer: inout CAShapeLayer, withColor color: UIColor, animated: Bool) {
        layer.strokeColor = color.cgColor
        layer.lineWidth = 10
        layer.strokeEnd = animated ? 0 : 1
        layer.lineCap = kCALineCapRound
        layer.fillColor = UIColor.clear.cgColor
    }


}

