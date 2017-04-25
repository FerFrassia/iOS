//
//  LoginViewController.swift
//  Quiero Mas
//
//  Created by Fernando N. Frassia on 4/21/17.
//  Copyright © 2017 Fernando N. Frassia. All rights reserved.
//

import UIKit
import AVFoundation

class LoginViewController: UIViewController {
    
    var avPlayer: AVPlayer!
    var avPlayerLayer: AVPlayerLayer!
    var paused: Bool = false
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var forgotView: UIView!
    @IBOutlet weak var dasanTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let theUrl = NSURL(fileURLWithPath: Bundle.main.path(forResource: "video-background_1200x720", ofType: "mp4")!)
        
        avPlayer = AVPlayer(url: theUrl as URL)
        
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        avPlayer.actionAtItemEnd = .none
        
        avPlayerLayer.frame = view.layer.frame
        
        view.layer.insertSublayer(avPlayerLayer, at: 0)
        
        NotificationCenter.default.addObserver(self,
        selector: #selector(playerItemDidReachEnd(notification:)),
        name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
        object: avPlayer.currentItem)
        
        adjustDasanConstraint()
    }
    
    func adjustDasanConstraint() {
        if DeviceType.IS_IPHONE_6P {
            dasanTopConstraint.constant = 300
        }
        
        if DeviceType.IS_IPHONE_6 {
            dasanTopConstraint.constant = 230
        }
        
        if DeviceType.IS_IPHONE_5 {
            dasanTopConstraint.constant = 140
        }
    }

    func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: kCMTimeZero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        avPlayer.play()
        paused = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        avPlayer.pause()
        paused = true
    }
    
    func showLoginView() {
        loginView.isHidden = false
        emailView.isHidden = true
        forgotView.isHidden = true
    }
    
    func showEmailView() {
        loginView.isHidden = true
        emailView.isHidden = false
        forgotView.isHidden = true
    }
    
    func showForgotView() {
        loginView.isHidden = true
        emailView.isHidden = true
        forgotView.isHidden = false
    }
    
    
    //MARK: - IBAction
    @IBAction func showEmailAction(_ sender: Any) {
        showEmailView()
    }
    
    
    @IBAction func forgotPasswordAction(_ sender: Any) {
        showForgotView()
    }
    
    enum UIUserInterfaceIdiom : Int
    {
        case Unspecified
        case Phone
        case Pad
    }
    
    struct ScreenSize
    {
        static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
    struct DeviceType
    {
        static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
        static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
        static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
        static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    }
    
    

}
