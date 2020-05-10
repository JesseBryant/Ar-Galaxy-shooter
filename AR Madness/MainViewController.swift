//
//  MainViewController.swift
//  Shoot N' Guns
//
//  Created by Rameez Hasan on 25/04/2020.
//  Copyright © 2020 Jesse Bryant. All rights reserved.
//

import UIKit
import CoreMedia
import MobileCoreServices
import GameKit
import SwiftSpinner

class MainViewController: UIViewController {
    
    @IBOutlet weak var videoPreview: UIView!
    // MARK: - AV Property
    var videoCapture: VideoCapture!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.authenticateUser()
        self.setUpCamera()
    }
    
}

extension MainViewController {
    func authenticateUser() {
        let player = GKLocalPlayer.local
        
        player.authenticateHandler = { vc, error in
            guard error == nil else {
                
//                let defaults = UserDefaults.standard
                // self.sceneView.scene.rootNode.removeAllAudioPlayers()
//                if let gameScore = defaults.value(forKey: "scoreL"){
//                    let score = gameScore as! Int
//                    self.scoreLabel.text = "Score: \(String(score))"
//                }
                print(error?.localizedDescription ?? "")
                return
            }
            if let vc = vc {
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    func setUpCamera() {
        videoCapture = VideoCapture()
//        videoCapture.delegate = self
        videoCapture.fps = 30
        videoCapture.setUp(sessionPreset: .hd1280x720) { success in
            
            if success {
                // add preview view on the layer
                if let previewLayer = self.videoCapture.previewLayer {
                    self.videoPreview.layer.addSublayer(previewLayer)
                    self.resizePreviewLayer()
                }
                
                // start video preview when setup is done
                self.videoCapture.start()
            }
        }
    }
    func resizePreviewLayer() {
        videoCapture.previewLayer?.frame = videoPreview.bounds
    }
}

extension MainViewController {
    @IBAction func didTapStart() {
//        DispatchQueue.main.async {
//            SwiftSpinner.show("Connecting to AR Camera...")
//        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GameVC")
        vc.modalPresentationStyle = .fullScreen
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            DispatchQueue.main.async {
            self.present(vc, animated: true, completion: nil)
        }
    }
    @IBAction func TopPlayers(_ sender: Any) {
        let vc = GKGameCenterViewController()
           vc.gameCenterDelegate = self
           vc.viewState = .leaderboards
           vc.leaderboardIdentifier = "Jescom.whatever.ARJesBrA.Scores"
           present(vc, animated: true, completion: nil)
    }
}

extension UIView {
    
    @IBInspectable var cornerRadius: Double {
         get {
           return Double(self.layer.cornerRadius)
         }set {
           self.layer.cornerRadius = CGFloat(newValue)
         }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
          return self.layer.borderWidth
        }set {
          self.layer.borderWidth = CGFloat(newValue)
        }
    }
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        } set {
            self.layer.borderColor = newValue.cgColor
        }
    }

    @IBInspectable var shadowColor: UIColor? {
        get {
           return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
           self.layer.shadowColor = newValue?.cgColor
        }
    }
    @IBInspectable var shadowOpacity: Float {
        get {
           return self.layer.shadowOpacity
        }
        set {
           self.layer.shadowOpacity = newValue
       }
    }
}

extension MainViewController: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
