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

    override func viewDidLoad() {
        super.viewDidLoad()
authenticateUser()
        // Do any additional setup after loading the view.
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
        performSegue(withIdentifier: "homeToGameSegue", sender: self)
    }
    
    
    @IBAction func TopPlayers(_ sender: Any) {
        let vc = GKGameCenterViewController()
           vc.gameCenterDelegate = self
           vc.viewState = .leaderboards
           vc.leaderboardIdentifier = "com.whatever.ARJesBrA.Scores"
           present(vc, animated: true, completion: nil)
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension HomeViewController: GKGameCenterControllerDelegate {

  func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
    gameCenterViewController.dismiss(animated: true, completion: nil)
  }

}
