//
//  ViewController.swift
//  PagerSample
//
//  Created by Fernando N. Frassia on 1/22/17.
//  Copyright © 2017 Fernando N. Frassia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var scrollIndicator: UIView!
    @IBOutlet weak var horizontalScroll: UIScrollView!
    
    @IBOutlet weak var indicatorLeading: NSLayoutConstraint!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UIScrollView Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let stoppingX = self.view.frame.width/2
            if scrollView.contentOffset.x < stoppingX {
                UIView.animate(withDuration: 0.1, delay: 0,
                               options: [],
                               animations: {
                                self.scrollIndicator.frame.origin.x = scrollView.contentOffset.x
                }, completion: nil)
            } else {
                UIView.animate(withDuration: 0.1, delay: 0,
                               options: [],
                               animations: {
                                self.scrollIndicator.frame.origin.x = stoppingX
                }, completion: nil)
            }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == 0 {
            setLeftSelected()
        } else {
            setRightSelected()
        }
    }
    
    func setLeftSelected() {
        leftButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        rightButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        indicatorLeading.constant = 0
    }
    
    func setRightSelected() {
        rightButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        leftButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        indicatorLeading.constant = self.view.frame.width/2
    }


    @IBAction func leftAction(_ sender: Any) {
        var x = self.view.frame.width
        while x > 0 {
            x = x - 20
            horizontalScroll.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        }
        horizontalScroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        setLeftSelected()
    }
    
    
    @IBAction func rightAction(_ sender: Any) {
        var x = CGFloat(0)
        while x < self.view.frame.width {
            x = x + 20
            horizontalScroll.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        }
        horizontalScroll.setContentOffset(CGPoint(x: self.view.frame.width, y: 0), animated: true)
        setRightSelected()
    }
    
    
    
}

