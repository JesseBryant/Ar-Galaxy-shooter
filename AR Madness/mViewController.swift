//
//  mViewController.swift
//  AR Madness
//
// Created by Jesse Bryant on 4/15/20.
//  Copyright © 2020 Jesse Bryant. All rights reserved.
//

//import UIKit
//import SceneKit
//import ARKit
//class mViewController: UIViewController {
//    //  static let shared = mViewController()
//
//        var audioPlayer = AVAudioPlayer()
//
//
//       // private init() { } // private singleton init
////    init(coder decoder: NSCoder) {
////        super.init(coder: decoder)
////    }
//    
////    required init?(coder: NSCoder) {
////        fatalError("init(coder:) has not been implemented")
////    }
//    
//
//        func setup() {
//             do {
//                audioPlayer =  try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "mp3")!))
//                 audioPlayer.prepareToPlay()
//
//            } catch {
//               print (error)
//            }
//        }
//
//
//        func play() {
//            audioPlayer.play()
//        }
//
//        func stop() {
//            audioPlayer.stop()
//            audioPlayer.currentTime = 0 // I usually reset the song when I stop it. To pause it create another method and call the pause() method on the audioPlayer.
//            audioPlayer.prepareToPlay()
//        }
//    }
