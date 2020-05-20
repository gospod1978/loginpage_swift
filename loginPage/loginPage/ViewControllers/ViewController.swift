//
//  ViewController.swift
//  loginPage
//
//  Created by Mihail Gospodinov on 18/05/2020.
//  Copyright © 2020 Mihail Gospodinov. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    var videoPlayer:AVPlayer?
    
    var videoPlayerLayer:AVPlayerLayer?
    
    @IBOutlet weak var singUp: UIButton!
    
    @IBOutlet weak var login: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }

    override func viewWillAppear(_ animated: Bool) {
        // setupp video
        setUpVideo()
    }
    
    func setUpElements() {
          Utilities.styleFilledButton(singUp)
          Utilities.styleFilledButton(login)
      }
    
    func setUpVideo() {
        //get the path to result
        let bundelPath = Bundle.main.path(forResource: "loginbg", ofType: "mp4")
        
        guard bundelPath != nil else {
            return
        }
        //get url from it
        let url = URL(fileURLWithPath: bundelPath!)
        
        //create video player item
        let item = AVPlayerItem(url: url)
        
        // create the player
        videoPlayer = AVPlayer(playerItem: item)
        
        //create layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        //adjyst the size and frame
        videoPlayerLayer?.frame = CGRect(x:
            -self.view.frame.size.width*1.5, y: 0, width:
            self.view.frame.size.width*4, height:
            self.view.frame.size.height/2)
        //ako mahna /2 stava na cql ekran
        
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
//        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
//
//        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        
        //add it the view
        videoPlayer?.playImmediately(atRate: 0.3)
    }

}

