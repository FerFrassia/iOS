//
//  ViewController.swift
//  notTinder
//
//  Created by Fernando N. Frassia on 5/13/18.
//  Copyright © 2018 Fernando N. Frassia. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {

    @IBOutlet weak var picView: UIView!
    @IBOutlet weak var picImg: UIImageView!
    @IBOutlet weak var thumbsView: UIImageView!
    
    var divisor: CGFloat!
    var candidateQueue = Queue<Candidate>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picImg.layer.cornerRadius = 5
        divisor = (view.frame.width/2)/0.61
        
        loadInitialCandidates()
        loadFirstCandidate()
    }
    
    
    @IBAction func panPic(_ sender: UIPanGestureRecognizer) {
        let pic = sender.view!
        let point = sender.translation(in: view)
        let xFromCenter = pic.center.x - view.center.x
        pic.center = CGPoint(x: view.center.x + point.x, y: view.center.y)
        
        var angle = xFromCenter/divisor
        angle = min(angle, 0.5)
        angle = max(angle, -0.5)
        pic.transform = CGAffineTransform(rotationAngle: angle)
        
        if sender.state == UIGestureRecognizerState.ended {
           resetPic()
        } else {
            if pic.center.x > view.center.x {
                thumbsView.image = UIImage(named: "thumbsUp")
                thumbsView.tintColor = .green
            } else {
                thumbsView.image = UIImage(named: "thumbsDown")
                thumbsView.tintColor = .magenta
            }
            thumbsView.alpha = abs(xFromCenter) / view.center.x
        }
    }
    
    func resetPic() {
        UIView.animate(withDuration: 0.2) {
            self.picView.center = self.view.center
            self.thumbsView.alpha = 0
            self.picView.transform = .identity
        }
    }
    
    func loadInitialCandidates() {
        for i in 0...6 {
            var c = Candidate(likesYou: false, img: UIImage(named: "girl\(i)"))
            if (i == 2) {
                c.likesYou = true
            }
            candidateQueue.enqueue(c)
        }
    }
    
    func loadFirstCandidate() {
        if let firstCandidate = candidateQueue.peekNext() {
            picImg.image = firstCandidate.img
        }
    }
    
    func nextCandidate() {
        candidateQueue.deque()
        picImg.image = candidateQueue.peekNext()?.img
    }
    
    func presentMatch() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func dislikeAction(_ sender: Any) {
        nextCandidate()
    }
    
    
    @IBAction func likeAction(_ sender: Any) {
        if let candidate = candidateQueue.peekNext() {
            if candidate.likesYou {
                presentMatch()
            } else {
                tryNext()
            }
        }
    }
    
    func tryNext() {
        if candidateQueue.amount() > 1 {
            nextCandidate()
        }
    }
    
    
}

