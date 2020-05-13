//
//  HomeViewController.swift
//  AR Madness
//
// Created by Jesse Bryant on 4/15/20.
//  Copyright © 2020 Jesse Bryant. All rights reserved.
//

import UIKit
import GameKit
class HomeViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    var score = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
authenticateUser()
        // Do any additional setup after loading the view.
        
        self.scoreLabel.text = "Last Score: \(0)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        authenticateUser()
        //let defaults = UserDefaults.standard
//        // self.sceneView.scene.rootNode.removeAllAudioPlayers()
//        if let gameScore = defaults.value(forKey: "scoreL"){
//            let score = gameScore as! Int
//            scoreLabel.text = "Score: \(String(score))"
//        }
    }
    private func authenticateUser() {
      let player = GKLocalPlayer.local

      player.authenticateHandler = { vc, error in
        guard error == nil else {
            
            let defaults = UserDefaults.standard
                   // self.sceneView.scene.rootNode.removeAllAudioPlayers()
                   if let gameScore = defaults.value(forKey: "scoreL"){
                       let score = gameScore as! Int
                    self.scoreLabel.text = "Score: \(String(score))"
                   }
          print(error?.localizedDescription ?? "")
          return
        }

        if let vc = vc {
          self.present(vc, animated: true, completion: nil)
        }
      }

    }
    @IBAction func onPlayButton(_ sender: Any) {
        //        performSegue(withIdentifier: "homeToGameSegue", sender: self)
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainVC")
        vc.modalPresentationStyle = .fullScreen
        delegate.window?.rootViewController = vc
    }
    
    
    @IBAction func TopPlayers(_ sender: Any) {
        let vc = GKGameCenterViewController()
           vc.gameCenterDelegate = self
        vc.viewState = .leaderboards
        //Jescom.whatever.ARJesBrA.Scores
           vc.leaderboardIdentifier = "Jescom.whatever.ARJesBrA.Scores"
           present(vc, animated: true, completion: nil)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension HomeViewController: GKGameCenterControllerDelegate {
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
}
