//
//  ViewController.swift
//  AR Madness
//

// Created by Jesse Bryant on 4/15/20.
//  Copyright © 2020 Jesse Bryant. All rights reserved.
//
//jj
//get a feel for game difficulty and level base difficulty..breakfast
//next color coat ships. 100
//space ships around a little more..
//more elaboratle explosion!!
//new lasor sounds
//add pop ups that gives instructions(eventually AFTER ads(reward ads!!)).. for levels and coin clamage or possibly in- app
//next level open if win and more important coins..that can unlock new levels or just in- app
//two new ideas for levels.... 1) have a little faster and maybe less ships
//repack code to Jesse Bryant
//have to it to where some ships shooting planet.. lke general and/or planet explode when out of time!
//Next marketing
//make some ships stronger(may not be possible dont want to make easer to destroy earth) just stronger blast..can destroy eash ship....show  meaning it take more shots!!!! prob big shps
//have it to where the blast can become stronger possibly.. if you kill certain amount of ships or the right one.*** as is game a little tough
//Must purchase nice blast and nice ship! 3d should be fine and a blaster
//change in color at right time..ie time running low maybe red or countdown...than red for earth explosion lke ghost AR app  each level
//8328579


//                                 1st mission
//when points get to a certain point like 40 means 1 left and 37 means 2 may be left
       //when game finish congrat them
       //kill certain ship and certain amount of points
       //when time run out
       // message when planet destroyed

//  gg.swift
//  Shoot N' Guns
//
//  Created by Jesse Bryant on 5/27/20.
//  Copyright © 2020 Jesse Bryant. All rights reserved.
//

import Foundation
import UIKit
import SceneKit
import ARKit
import StoreKit
import GameKit
//import GoogleMobileAds
import SwiftSpinner
import FBAudienceNetwork










//
//final class GameCenterHelper: NSObject {
//  typealias CompletionBlock = (Error?) -> Void
//    static let helper = GameCenterHelper()
//
//    // 2
//
//}










//import SpriteKit
enum BitMaskCategory: Int {
    case target  = 3
}

class ViewController: UIViewController, ARSCNViewDelegate, SCNPhysicsContactDelegate, SKPaymentTransactionObserver {
//    static let helper = GameCenterHelper()
//
//    // 2
   var viewController: UIViewController?
    
    @IBOutlet weak var bestScoreContainerView: UIView!
    @IBOutlet weak var crossButton: UIButton!
    @IBOutlet weak var coinsButton: UIButton!
    @IBOutlet weak var needTimeLabel: UILabel!
    @IBOutlet weak var buttonStackView: UIStackView!
    
    var isPlanetHit = false
    var it = false
     var isPlanetHitORneedTime = false
      var PoP = false
    var interstitial: FBInterstitialAd!
    var adShowFinish = false

    @IBOutlet weak var CoinBttn: UIButton!
    //MARK: - variables
    @IBOutlet var sceneView: ARSCNView!
    
    //used to display timer to player
    @IBOutlet weak var timerLabel: UILabel!
    
    //used to display score to player
    @IBOutlet weak var CNNN: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var Score: UILabel!
    
    //timeView
    @IBOutlet weak var BesLabel: UILabel!
    
    @IBOutlet weak var BestScore: UILabel!
    @IBOutlet weak var levelJB:UILabel!
    var Time = false
    
    @IBOutlet weak var ScView: UIStackView!
    @IBOutlet weak var timeView: UIStackView!
    @IBOutlet weak var targeee: UIImageView!
    
    @IBOutlet weak var retry: UIButton!
    //revve
    @IBOutlet weak var r: UIButton!
    var trackerNode: SCNNode?
    var foundSurface = false
    var AdsLoaded = false
    var tracking = true
    let defaultss = UserDefaults.standard
    var arrrrr : Int = 0
    var cc = 0
    let configuration = ARWorldTrackingConfiguration()
    let audioNode = SCNNode()
    let audioSource = SCNAudioSource(fileNamed: "Sleepy.mp3")!
    let productID = "786978678678678"
        var audioPlayer = AVAudioPlayer()
    //Sleepy.mp3
        func playingSoundWith(fileName: String) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: Bundle.main.url(forResource: fileName, withExtension: "mp3")!)
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    
var power = "banana"
    //score will be implenmented with leaderb
    var scoreL = 0
    var Coins = 0
     var CoinsAva = 0
    var Coinse = 0
    //Coins
    var target: SCNNode?
   var earN: SCNNode?
    var nodeArray : [SCNNode] = []
     var AllnodeArray : [SCNNode] = []
    var SSnodeArray : [SCNNode] = []
    var SecGroupNodeArray : [SCNNode] = []
     var EarGroupNodeArray : [SCNNode] = []
     var ThirdGroupNodeArray : [SCNNode] = []
      var name : [String] = ["1","1","1","2"]
    let leaderboardID = "Jescom.whatever.ARJesBrA.Scores"
    var score = GKScore()
//   messageLabel.isHidden = true
    //MARK: - buttons
    
    
    @IBAction func Restart(_ sender: Any) {
        self.shouldShowBestScoreContainerView(state: false)
        self.sceneView.scene.rootNode.enumerateChildNodes {  (node, stop) in
            node.removeFromParentNode()
        }
        self.play()
    }
    
    
    @IBAction func Revive(_ sender: Any) {
        self.shouldShowBestScoreContainerView(state: false)
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
        }
        self.play()
    }

    //MARK: - maths
    
    func getUserVector() -> (SCNVector3, SCNVector3) { // (direction, position)
        
        //change it from camara to earth
        //or better yet shoot position earth
        //if it hit explode(maybe 4 or 5 hits)
        //instead of it coming from camera view point comes from random spaceships everY so often!
        if let frame = self.sceneView.session.currentFrame {
            let mat = SCNMatrix4(frame.camera.transform) // 4x4 transform matrix describing camera in world space
            let dir = SCNVector3(-1 * mat.m31, -1 * mat.m32, -1 * mat.m33) // orientation of camera in world space
            let pos = SCNVector3(mat.m41, mat.m42, mat.m43) // location of camera in world space
            
            return (dir, pos)
        }
        return (SCNVector3(0, 0, -1), SCNVector3(0, 0, -0.2))
    }
    
    func ReportScore(with value: Int) {
       
        // take score
         
     
        // set value for score
        score.value = Int64(value)
        // push score to Game Center
        GKScore.report([score]) { (error) in
            // check for errors
            if error != nil {
                print("Score updating -- \(error!)")
            } else {
                  print("Score submitted Jes")
            }
        }
//full few glitch mmmn
    }
    //MARK: - view functions
    // let audioPlayer = SCNAudioPlayer(source: audioSource)
    override func viewDidLoad() {
        super.viewDidLoad()
        GKLocalPlayer.local.authenticateHandler = { gcAuthVC, error in
           if GKLocalPlayer.local.isAuthenticated {
             
                 //make sure they  sign
             print("Authenticated to Game Center!")
           } else if let vc = gcAuthVC {
             self.viewController?.present(vc, animated: true)
         //   GameCenterHelper.helper.viewController = self
           }
           else {
             print("Error authentication to GameCenter: " +
               "\(error?.localizedDescription ?? "none")")
           }
         }
        DispatchQueue.main.async {
              
                    self.sceneView.isHidden = true
                   SwiftSpinner.show("Connecting to AR Camera...")
                   self.InterstitialAd()
        
                      //   self.sceneView.isHidden = true
               }
               DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                  // if self.AdsLoaded{
                   self.sceneView.isHidden = false
                   self.ScView.isHidden = false
                   self.timeView.isHidden = false
                   self.targeee.isHidden = false
                   SwiftSpinner.hide()
                   self.reseB()
                   self.play()
                  // }
               }
               
               self.sceneView.delegate = self
               // let audioPlayer = SCNAudioPlayer(source: audioSource)
               // Show statistics such as fps and timing information
               //sceneView.showsStatistics = true
              //.com
               //set the physics delegate
               self.sceneView.scene.physicsWorld.contactDelegate = self
               
               SKPaymentQueue.default().add(self)
               // stopBackgroundMusic()
               // Set the view's delegate
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(sender:)))
               self.sceneView.addGestureRecognizer(gestureRecognizer)

             if let gameScore = self.defaultss.value(forKey: "Coins"){
                        self.Coins = gameScore as! Int
                        print("\(self.Coins) Jesse KKKK")
                            
                            //play()
                    }
                    
                    if let gameScoree = self.defaultss.value(forKey: "CoinsAva"){
                        self.CoinsAva = gameScoree as! Int
                        print("\(self.CoinsAva) Jesse Ava has uploaded")
                              
                              //play()
                      }
//        InterstitialAd()
//nice project fix issues with sound, much better fireball, less fade out.. memory leak fixed
//       self.sceneView.isHidden = true
        //treat ADs like mainly time tickit.. Coins should manly save planets
      
        
        // score = GKScore(leaderboardIdentifier: leaderboardID)
    
//        self.play()
    }
    
    // MARK: Jesss
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
             //without line below it want move
             self.sceneView.session.run(configuration)

        //nice project
    }
       func session(_ session: ARSession, didFailWithError error: Error) {
           // Present an error message to the user
           print("Session failed. Changing worldAlignment property.")
           print(error.localizedDescription)
//388957d754ee91a872e49a35233fc8b48c77a4c4
           if let arError = error as? ARError {
               switch arError.errorCode {
               case 102:
                   
                   configuration.worldAlignment = .gravity
                   restartSessionWithoutDelete()
               default:
                   restartSessionWithoutDelete()
               }
           }
       }
       func restartSessionWithoutDelete() {
           // Restart session with a different worldAlignment - prevents bug from crashing app
          
    DispatchQueue.main.async {
        self.sceneView.session.pause()
       self.sceneView.session.run(self.configuration, options: [
               .resetTracking,
               .removeExistingAnchors])
           }
       }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //stopBackgroundMusic()
        // Pause the view's session
        sceneView.session.pause()
       // stopBackgroundMusic()
    }
    func reseB(){
    view.addSubview(resetButton)
      resetButton.anchor(nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 12, rightConstant: 0, widthConstant: resetButtonWidth, heightConstant: resetButtonWidth)
      resetButton.anchorCenterXToSuperview()
    }
    // MARK: - timer
    
    //to store how many sceonds the game is played for
    var seconds = 60
    
    //timer
    var timer = Timer()
    
    //to keep track of whether the timer is on
    var isTimerRunning = false
    
    //to run the timer
    func runTimer() {
        //fixed timer bug
        if !timer.isValid {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
        }
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer){
        fireMissile(type: power)
       
    }
    
    
    let resetButtonWidth = ScreenSize.width * 0.1
    lazy var resetButton: UIButton = {
      var button = UIButton(type: .system)
      button.setImage(#imageLiteral(resourceName: "ResetButton").withRenderingMode(.alwaysTemplate), for: .normal)
      button.tintColor = UIColor(white: 1.0, alpha: 0.7)
      button.layer.cornerRadius = resetButtonWidth * 0.5
      button.layer.masksToBounds = true
      button.addTarget(self, action: #selector(handleResetButtonTapped), for: .touchUpInside)
      button.layer.zPosition = 1
      button.imageView?.contentMode = .scaleAspectFill
      return button
    }()
    
    @objc func handleResetButtonTapped() {
       print("Tapped on reset button")
       resetScene()
     }
    func resetScene() {
      sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
                       node.removeFromParentNode()
                   }
//      sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
//        if node.name == "node" {
//          node.removeFromParentNode()
//        }
//      }
        DispatchQueue.main.async {
                   self.shouldShowBestScoreContainerView(state: false)
                  self.resetTimer(time: 30)
                   self.runTimer()
               }
                   self.PoP = false
                 //  if isPlanetHit{
                           DispatchQueue.main.async {
                           self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
                           node.removeFromParentNode()
                               }
                               self.play()
                            //can refresh app AND it refresh if ad wont close
                           }
//                   } else {
//                     DispatchQueue.main.async {
//                       self.playBackgroundMusic()
//                   }
//
//                   }
                   isPlanetHit = false
         adShowFinish = false
             // self.runTimer()
        print("adShowFinish = false")
     //   sceneView.setNeedsDisplay
        self.view.setNeedsDisplay()
      //  play()
        
        //viewDidLoad()
        //set var = false ...ads
      sceneView.session.run(configuration, options: [.removeExistingAnchors, .resetTracking])
    }
    
    func PlayInstructions() {
        
        //        messageLabel.isHidden = false
        //        [self performSelector:@selector(hiddenLabel) withObject:nil afterDelay:3];
        self.messageLabel.isHidden = false
        self.messageLabel.text = "Shoot all the spaceships. Do not shoot planets"
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: { [weak self] in
            guard let self = self else {return}
            self.messageLabel.isHidden = true
        })
    }
    func PlayInstructionsLight() {
           
           //        messageLabel.isHidden = false Quick time Player
           //        [self performSelector:@selector(hiddenLabel) withObject:nil afterDelay:3];
           self.messageLabel.isHidden = false
           self.messageLabel.text = "Place the device in an area where there is ligh"
           DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: { [weak self] in
               guard let self = self else {return}
               self.messageLabel.isHidden = true
           })
       }
    
    //decrements seconds by 1, updates the timerLabel and calls gameOver if seconds is 0
    @objc func updateTimer() {
       if PoP == false {
        if seconds == 0  {
            timer.invalidate()
            //believe this issue because this the only place that calls  gameOver()
            NeedMoreTime()
           // gameOver()
        }else {
            seconds -= 1
            timerLabel.text = "\(seconds)"
        }
        }
    }
    
    //resets the timer
    func resetTimer(time: Int){
        timer.invalidate()
        seconds = time
        timerLabel.text = "\(seconds)"
    }
    
    func InterstitialAd(){
         autoreleasepool {
          interstitial = FBInterstitialAd(placementID: "229174575034368_230531631565329")
       // interstitial = FBInterstitialAd.
          interstitial.delegate = self
          interstitial.load()
        }
      }
    
    // MARK: - game over
    
    func gameOver(){
        //        earth"
        //        earthParent.name = "earthParent
        if let gameScore = defaultss.value(forKey: "scoreL"){
           let _ = gameScore as! Int
            if Coins > 90 {
                //  print("\(score):score >90 welcome to level 2")
            } else{
                // print("\(score): score <90 still on level 1")
            }
            //                //scoreLabel.text = "Score: \(String(score))"
        }
        
        
        //   scoreL += score
        //store the score in UserDefaults
      
        defaultss.set(Coins, forKey: "Coins")
        //        scoreL += score
        //  defaults.set(scoreL, forKey: "scoreL")
        // let arrrrr = scoreJJ + fscre
         arrrrr = scoreL
        defaultss.set(arrrrr, forKey: "scoreL")
        //go back to the Home View Controller
        // removeAud
        //stopBackgroundMusic()
        self.dismiss(animated: true, completion: nil)
        stopBackgroundMus()
    }
    func BeatLevel() {
//        if adShowFinish == false {
        stopBackgroundMus()
        self.messageLabel.isHidden = false
        timer.invalidate()
        
        // timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
        let currentScore = self.scoreL
       // var h = 0
//           if h == CoinsAva  {
//                timer.invalidate()
//                //believe this issue because this the only place that calls  gameOver()
//               // NeedMoreTime()
//               // gameOver()
//            }else {
//                h += 1
//                timerLabel.text = "\(seconds)"
//           self.messageLabel.text = "SCORE: \(currentScore) \n\(h) Coins"
//            }
//
        
//
//        //resets the timer
//        func resetTimer(time: Int){
//            timer.invalidate()
//            seconds = time
//            timerLabel.text = "\(seconds)"
//        }
//
        
       // self.messageLabel.text = "Score: \(Int(self.scoreLabel.text!))"
        if let currentScore = self.scoreLabel.text {
        self.messageLabel.text = "SCORE: \(currentScore) \nCOINS: \(CoinsAva)"
        }
        // if let gameScore = defaults.value(forKey: "Coins"){
        // Coins = gameScore as! Int CoinsAva
        print("\(Coins) Jesse Coins")
         print("\(CoinsAva) Jesse KKKK")
        self.BesLabel.text = ("+")
        self.BestScore.text  = "\(CoinsAva) coins"
        //        self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
        //                                  node.removeFromParentNode()
        //                              }
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: { [weak self] in
//                   guard let self = self else {return}
//                   self.messageLabel.isHidden = true
//               })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {[weak self] in
             guard let self = self else {return}
            self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
                node.removeFromParentNode()
            }
    
            
            //   scoreL += score
          //  let fscre = self.scoreL
            //store the score in UserDefaults
            self.defaultss.set(self.Coins, forKey: "Coins")
            self.defaultss.set(self.CoinsAva, forKey: "CoinsAva")
            
            //        scoreL += score
            //  defaults.set(scoreL, forKey: "scoreL")CoinsAva
            
            
            
            //After in app purchases make this 0..so we can keep
            //up with best score
            self.arrrrr = currentScore
           
            self.defaultss.set(self.arrrrr, forKey: "scoreL")
            self.ReportScore(with: self.arrrrr)
            //go back to the Home View Controller
            // removeAud
            //stopBackgroundMusic()
            // self.dismiss(animated: true, completion: nil)
            //self.stopBackgroundMus()
            self.messageLabel.isHidden = true
//            self.BestScore.isHidden = true
//            self.BestScore.isHidden = true
            self.BesLabel.isHidden = true
            self.resetTimer(time: 60)
                                    self.ReportScore(with: self.scoreL)
            
            self.play()
        })
//        } else {
//            resetScene()
//        }
    }
    func shouldShowBestScoreContainerView(state: Bool) {
       if SKPaymentQueue.canMakePayments() {
        
          if self.CoinsAva >= 20 {
        if state {
            PoP = true
            //  let fafa = Coins
        let fafa =  CoinsAva
//            CoinsAvaa = CoinsAva
            //besss
          //have coins and correct best score

            if GKLocalPlayer.local.isAuthenticated {

                // Initialize the leaderboard for the current local player
                var gkLeaderboard = GKLeaderboard(players: [GKLocalPlayer.local])
                gkLeaderboard.identifier = leaderboardID
                gkLeaderboard.timeScope = GKLeaderboard.TimeScope.allTime
                gkLeaderboard.range = NSMakeRange(1, 1)
                // Load the scores
                gkLeaderboard.loadScores(completionHandler: { (scores, error) -> Void in

                    // Get current score
                    //added code
                    let scoreee : GKScore = gkLeaderboard.localPlayerScore!

                    let rank : NSInteger = scoreee.rank
                    
                    var currentScore: Int64 = 0
                    if error == nil, let scores = scores {
                        if (scores.count) > 0 {
                            currentScore = (scores[0] ).value
                            let bestScore = currentScore
                             print("\(bestScore) besss")
                            if let currentScore = Int(self.scoreLabel.text!) {
                                        if currentScore > bestScore {
                                         
                                            DispatchQueue.main.async {
                                            self.BestScore.text = "BEST: \(bestScore) \n\nRANK: \(rank)"
                                            print("\(fafa) fafa test")
                                                 print("\(rank) rank test")
                                            self.CNNN.text = "COINS: \(abs(fafa))"
                                            }
                                            UserDefaults.standard.set(currentScore, forKey: "BestScore")
                                            UserDefaults.standard.synchronize()
                                        } else {
                                            DispatchQueue.main.async {
                                            self.BestScore.text = "BEST: \(bestScore) \n\nRANK: \(rank)"
                                             self.CNNN.text = "COINS: \(abs(fafa))"
                                                print("\(rank) rank test")
                                            }
                                        }
                                        
                                    }
                            //We also want to show the best score of the user on the main screen
//                            if self.language.contains("it"){
//                                self.labelBestScore.text = "Miglior Punteggio: " + String(currentScore)
//                                self.bestScore = Int(currentScore)
////                            }else{
//                                self.labelBestScore.text = "Your Best Score: " + String(currentScore)
//                                self.bestScore = Int(currentScore)
//                            }
                            print("Jesse bestScore",currentScore)
                        }
                    }

                })
            }
            }
            
            
            
          //  let bestScore = UserDefaults.standard.integer(forKey: "BestScore")
//            print("\(bestScore) besss")
           // let currentScore = Int(self.scoreLabel.text!)
        
          
        self.bestScoreContainerView.isHidden = !state
        self.coinsButton.isHidden = !state
        self.crossButton.isHidden = !state
        self.buttonStackView.isHidden = !state
        }
        else {
                   //self.needTimeLabel.text = "not enough coins"
            if state {
                        PoP = true
                        //  let fafa = Coins
                    let fafa =  CoinsAva
                    //    CoinsAvaa = CoinsAva
                        //besss
                      //have coins and correct best score

                        if GKLocalPlayer.local.isAuthenticated {

                            // Initialize the leaderboard for the current local player
                            var gkLeaderboard = GKLeaderboard(players: [GKLocalPlayer.local])
                            gkLeaderboard.identifier = leaderboardID
                            gkLeaderboard.timeScope = GKLeaderboard.TimeScope.allTime
                            gkLeaderboard.range = NSMakeRange(1, 1)
                            
                       
                            // Load the scores
                            gkLeaderboard.loadScores(completionHandler: { (scores, error) -> Void in
                                        let scoreee : GKScore = gkLeaderboard.localPlayerScore!

                                                                                 let rank : NSInteger = scoreee.rank
                                // Get current score
                                var currentScore: Int64 = 0
                                if error == nil, let scores = scores {
                                    if (scores.count) > 0 {
                                        currentScore = (scores[0] ).value
                                        let bestScore = currentScore
                                         print("\(bestScore) besss")
                                        if let currentScore = Int(self.scoreLabel.text!) {
                                                    if currentScore > bestScore {
                                                      
                                                        DispatchQueue.main.async {
                                                        self.BestScore.text = "BEST: \(bestScore) \n\nRANK: \(rank)"
                                                        print("\(fafa) fafa test")
                                                        self.CNNN.text = "COINS: \(abs(fafa))"
                                                        }
                                                        UserDefaults.standard.set(currentScore, forKey: "BestScore")
                                                        UserDefaults.standard.synchronize()
                                                    } else {
                                                        DispatchQueue.main.async {
                                                             self.BestScore.text = "BEST: \(bestScore) \n\nRANK: \(rank)"
                                                      
                                                         self.CNNN.text = "COINS: \(abs(fafa))"
                                                            self.needTimeLabel.text = "not enough coins"
                                                            self.CoinBttn.setTitle("Buy", for: .normal)
                                                        }
                                                    }
                                                    
                                                }
                                        //We also want to show the best score of the user on the main screen
            //                            if self.language.contains("it"){
            //                                self.labelBestScore.text = "Miglior Punteggio: " + String(currentScore)
            //                                self.bestScore = Int(currentScore)
            ////                            }else{
            //                                self.labelBestScore.text = "Your Best Score: " + String(currentScore)
            //                                self.bestScore = Int(currentScore)
            //                            }
                                        print("Jesse bestScore",currentScore)
                                    }
                                }

                            })
                        }
                        }
                        
                        
                        
                      //  let bestScore = UserDefaults.standard.integer(forKey: "BestScore")
            //            print("\(bestScore) besss")
                       // let currentScore = Int(self.scoreLabel.text!)
                    
                      
                    self.bestScoreContainerView.isHidden = !state
                    self.coinsButton.isHidden = !state
                    self.crossButton.isHidden = !state
                    self.buttonStackView.isHidden = !state
               }
        
        
        
        
        
    }
        else{
              if state {
                        PoP = true
                        //  let fafa = Coins
                    let fafa =  CoinsAva
                        //besss
                      //have coins and correct best score

                        if GKLocalPlayer.local.isAuthenticated {

                            // Initialize the leaderboard for the current local player
                            var gkLeaderboard = GKLeaderboard(players: [GKLocalPlayer.local])
                            gkLeaderboard.identifier = leaderboardID
                            gkLeaderboard.timeScope = GKLeaderboard.TimeScope.allTime

                            // Load the scores
                            gkLeaderboard.loadScores(completionHandler: { (scores, error) -> Void in

                                // Get current score
                                var currentScore: Int64 = 0
                                if error == nil, let scores = scores {
                                    if (scores.count) > 0 {
                                        currentScore = (scores[0] ).value
                                        let bestScore = currentScore
                                         print("\(bestScore) besss")
                                        if let currentScore = Int(self.scoreLabel.text!) {
                                                    if currentScore > bestScore {
                                                      
                                                        DispatchQueue.main.async {
                                                        self.BestScore.text = "BEST: \(currentScore)"
                                                        print("\(fafa) fafa test")
                                                        self.CNNN.text = "COINS: \(abs(fafa))"
                                                        }
                                                        UserDefaults.standard.set(currentScore, forKey: "BestScore")
                                                        UserDefaults.standard.synchronize()
                                                    } else {
                                                        DispatchQueue.main.async {
                                                        self.BestScore.text = "BEST: \(bestScore)"
                                                         self.CNNN.text = "COINS: \(abs(fafa))"
                                                        }
                                                    }
                                                    
                                                }
                                        //We also want to show the best score of the user on the main screen
            //                            if self.language.contains("it"){
            //                                self.labelBestScore.text = "Miglior Punteggio: " + String(currentScore)
            //                                self.bestScore = Int(currentScore)
            ////                            }else{
            //                                self.labelBestScore.text = "Your Best Score: " + String(currentScore)
            //                                self.bestScore = Int(currentScore)
            //                            }
                                        print("Jesse bestScore",currentScore)
                                    }
                                }

                            })
                        }
                        
                        
                        
                        
                      //  let bestScore = UserDefaults.standard.integer(forKey: "BestScore")
            //            print("\(bestScore) besss")
                       // let currentScore = Int(self.scoreLabel.text!)
                    
                    }
                    self.bestScoreContainerView.isHidden = !state
                    self.coinsButton.isHidden = !state
                    self.crossButton.isHidden = !state
                    self.buttonStackView.isHidden = !state
        }
        
    }
    func NeedMoreTime(){
        //only if PoP = false meaning no PoP up available so no double pop ups
       // if !PoP {
        self.resetButton.isHidden = false
        self.needTimeLabel.text = "Need more time"
        self.isPlanetHit = false
        
        self.shouldShowBestScoreContainerView(state: true)
       // }
       
    }
    
    @IBAction func didTapCross() {
        self.shouldShowBestScoreContainerView(state: false)
        PoP = false
        self.Coins = 0
      //  self.CoinsAva = 0
//            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: { [weak self] in
//        //                   guard let self = self else {return}
//        //                   self.messageLabel.isHidden = true
//        //               })
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
           // stopBackgroundMus()
            //Music end sometimes here
        }
        self.scoreLabel.text = "0"
        self.scoreL = 0
        self.levelJB.text = "Level 1"
        self.resetTimer(time: 30)
        
        power = "banana"
        //  sceneView.backgroundColor = UIColor.red
     self.Coins = 0
                             print("\(self.Coins) Coins after")
                            // if let gameScore = self.defaultss.value(forKey: "Coins")
                             defaultss.set(self.Coins, forKey: "Coins")
           defaultss.set(self.CoinsAva, forKey: "CoinsAva")
                             //        scoreL += score
                             //  defaults.set(scoreL, forKey: "scoreL")
                              arrrrr = self.scoreL
                          
                             defaultss.set(arrrrr, forKey: "scoreL")
                            self.ReportScore(with: arrrrr)
        sceneView.scene.rootNode.removeAllAudioPlayers()
        messageLabel.isHidden = true
        levelJB.text = "level 1"
        //addTargetNodes()
          self.resetButton.isHidden = false
        FsaddTargetNodes()
        PlayInstructions()
        //play background music
       // playBackgroundMusic()
        //  addTargetNodesJupitar()
        //start tinmer
        runTimer()
        print("\(Coins): still on level 1")
    }
    @IBAction func didTapInterestial() {
         PoP = true
//        self.stopBackgroundMus()
//        interstitial.show(fromRootViewController: self)
        self.resetButton.isHidden = false
        DispatchQueue.main.async {
    //interstitial.show(fromRootViewController: self)
            // autoreleasepool {
            self.stopBackgroundMus()
            //self.interstitial.
            // autoreleasepool {
            
            self.interstitial.show(fromRootViewController: self)
            
            self.adShowFinish = true
        self.shouldShowBestScoreContainerView(state: false)
           //  self.sceneView.isHidden = true
           //  SwiftSpinner.show("Loading...")
        }
      //  }

    }
    //fixed bug that cause pop up EVEN after I tap ad button
    @IBAction func didTapCoins() {
       DispatchQueue.main.async { [weak self] in
         guard let self = self else {return}
              self.shouldShowBestScoreContainerView(state: false)
          self.PoP = false
              }
              if self.isPlanetHit {
                  
                  if self.CoinsAva >= 20 {
                      //timer fixed
                      //not working because coins = 0 in real physical world
                      //will need restart here cuz planet gone
                      print("\(self.CoinsAva) Coins")
                      self.CoinsAva = self.CoinsAva - 20
                      print("\(self.CoinsAva) Coins after")
                    
                      defaultss.set(self.CoinsAva, forKey: "CoinsAva")
                      //        scoreL += score
                      //  defaults.set(scoreL, forKey: "scoreL")
                       arrrrr = self.scoreL
                    
                      defaultss.set(arrrrr, forKey: "scoreL")
                     self.ReportScore(with: arrrrr)
                      //since planet got hit restart with **Correct** points
                      DispatchQueue.main.async { [weak self] in
                        guard let self = self else {return}
                      self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
                          node.removeFromParentNode()
                          
                      }
                          self.resetButton.isHidden = false
                          self.play()
                          self.resetTimer(time: 45)
                                         self.runTimer()
                      }
                      
                      
                      // let fscre = self.scoreL
                      //store the score in UserDefaults and leaderboard
                      
                  } else {
                    
                    if SKPaymentQueue.canMakePayments() {
                 
                      //need pop up letting user know
                      self.buyPremiumQuotes()
                      
                      //done in ph world too
                     //  self.ReportScore(with: arrrrr)
                      self.Coins = 0
                      DispatchQueue.main.async {[weak self] in
                        guard let self = self else {return}
                      self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
                          node.removeFromParentNode()
                      }
                      }
                     // if purchaseGood {
                    //  self.play()
                   //   }
                     } else {
                        var refreshAlert = UIAlertController(title: "Coins", message: "You dont have enough coins", preferredStyle: UIAlertController.Style.alert)

                        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                            DispatchQueue.main.async {
                                                                    self.Coins = 0
                                                                    self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
                                                                        node.removeFromParentNode()
                                                                    }
                                                  self.play()
                                              }
                          print("Handle Ok logic here")
                          }))

                        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                          print("Handle Cancel Logic here")
                          }))

                        present(refreshAlert, animated: true, completion: nil)
                    }
                    
                  }
                  
              } else {
                  if self.CoinsAva >= 20 {
                      //not working because coins = 0 in real physical world
                      //will need restart here cuz planet gone
                      self.shouldShowBestScoreContainerView(state: false)
                      print("\(self.Coins) Coins")
                      self.CoinsAva = self.CoinsAva - 20
                      print("\(self.CoinsAva) Coins after")
                    
                      defaultss.set(self.CoinsAva, forKey: "CoinsAva")
                      //        scoreL += score
                      //  defaults.set(scoreL, forKey: "scoreL")
                       arrrrr = self.scoreL
                   
                      defaultss.set(arrrrr, forKey: "scoreL")
                      self.ReportScore(with: arrrrr)
                      //since planet got hit restart with **Correct** points
                      //                    self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
                      //                                              node.removeFromParentNode()
                      //                                          }
                      //                    self.play()
                      // timer
                      //self.seconds = 90
                      //need to make sre messgae go wi
                      self.resetTimer(time: 45)
                      self.runTimer()
                    //  self.play()
                      // let fscre = self.scoreL
                      //store the score in UserDefaults and leaderboard
                      
                  } else {
                    
                      
                      //magic for in app purchases
                      //j
                      //All project
                      // timer.invalidate()
                      
                     if SKPaymentQueue.canMakePayments() {
                        self.Time = true
                      self.buyPremiumQuotes()
                      
                      //done in ph world too
                      self.Coins = 0
                      self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
                          node.removeFromParentNode()
                      }
                    //  if purchaseGood {
                      // timer.invalidate()
                     // self.play()
                     // }
                  }
                      else {
                        var refreshAlert = UIAlertController(title: "Coins", message: "You dont have enough coins", preferredStyle: UIAlertController.Style.alert)

                        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                            //done in ph world too
                             DispatchQueue.main.async {
                                              self.Coins = 0
                                              self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
                                                  node.removeFromParentNode()
                                              }
                            self.play()
                        }
                          print("Handle Ok logic here")
                          }))

                        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                          print("Handle Cancel Logic here")
                          }))

                        present(refreshAlert, animated: true, completion: nil)
                    }
                    
                }
              }
    }
    
    func PlanetHit() {
        
        //create new timer that restart level if You dont watch ad in time
        timer.invalidate()
        self.needTimeLabel.text = "You shot a planet"
        self.isPlanetHit = true
        self.resetButton.isHidden = true
        self.shouldShowBestScoreContainerView(state: true)
        
        
    }
    //C
    // MARK: - In-App Purchase Methods
    
    func buyPremiumQuotes() {
       // self.sceneView.isHidden = true
          SwiftSpinner.show("Loading...")
        if SKPaymentQueue.canMakePayments() {
            // if they cant say not enogh coins
            //Can make payments
//              DispatchQueue.main.async {
//            self.sceneView.isHidden = false
//            SwiftSpinner.hide()
//            }
           let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productID
            self.sceneView.isHidden = false
            SwiftSpinner.hide()
            SKPaymentQueue.default().add(paymentRequest)
            
            
        } else {
            //Can't make payments
          
            print("User can't make payments")

             
        }
    }
    //
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
 
       for transaction in transactions {
       // self.sceneView.isHidden = true
        let h = transaction.payment.productIdentifier
                             //  SwiftSpinner.show("Connecting to AR Camera...")
                   if transaction.transactionState == .purchased {
                       //if product key is for 1.99 call showPremiumQuotes( self.resetTimer(time: 45)
                                         //self.runTimer()
                                         //  self.resetButton.isHidden = false
                                           //self.play() ect product key  will be saved once hit table did sele
                       //User payment successful
                       print("Transaction successful! \(h)")
                     //  self.sceneView.isHidden = false
                    //  SwiftSpinner.hide()
                       showPremiumQuotes()
                    self.CoinBttn.setTitle("20 coins", for: .normal)
                        // self.play()
                
                    self.resetTimer(time: 45)
                    self.runTimer()
                    //  self.resetButton.isHidden = false
                    
                      self.play()
                       //nice version
                       SKPaymentQueue.default().finishTransaction(transaction)
                       
                   } else if transaction.transactionState == .failed {
                    //   self.sceneView.isHidden = false
                                        //    SwiftSpinner.hide()
                       //Payment failed
                    self.CoinsAva = 0
                           self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
                               node.removeFromParentNode()
                              // stopBackgroundMus()
                               //Music end sometimes here
                           }
//                    self.sceneView.isHidden = false
//                                                   SwiftSpinner.hide()
                           self.scoreLabel.text = "0"
                           self.scoreL = 0
                           self.levelJB.text = "Level 1"
                           self.resetTimer(time: 30)
                           
                           power = "banana"
                           //  sceneView.backgroundColor = UIColor.red
                           sceneView.scene.rootNode.removeAllAudioPlayers()
                           messageLabel.isHidden = true
                           levelJB.text = "level 1"
                           //addTargetNodes()
                    self.sceneView.isHidden = false
                                                                      SwiftSpinner.hide()
                           FsaddTargetNodes()
                           PlayInstructions()
                           //play background music
                         //  playBackgroundMusic()
                           //  addTargetNodesJupitar()
                           //start tinmer
                           runTimer()
                           print("\(Coins): still on level 1")
                       if let error = transaction.error {
                           let errorDescription = error.localizedDescription
                        self.CoinBttn.setTitle("20 coins", for: .normal)
                           print("Transaction failed due to error: \(errorDescription)")
                       }
                     //  self.play()
                        SKPaymentQueue.default().finishTransaction(transaction)
                       
                   } else if transaction.transactionState == .restored {
                       
                       showPremiumQuotes()
                       
                       print("Transaction restored")
                       
                       navigationItem.setRightBarButton(nil, animated: true)
                       
                       SKPaymentQueue.default().finishTransaction(transaction)
                   }
               }
    }
  
    //got it where it only let make paymen if canmake work other wise you get
    //alerted that you dont have enough, if you 0 buy appear 
    func showPremiumQuotes() {
        //NEXT
        //next Ar capabili
        //master waves
        //finish in app menu
        //test test test( for perfec(lke bes games) and monetize
        //APPLE approval test
        // vid and screenshot
        
        UserDefaults.standard.set(true, forKey: productID)
        
        //   quotesToShow.append(contentsOf: premiumQuotes)
        // tableView.reloadData()
        //self.Coins = Coins + 10
        //in app works... Transaction successful!
        //need to sub or add less cuz it goes too next level
        //well do add 5 for now.. for 1.99 look at other games in app purchases
        self.CoinsAva+=600
        //defaultss.set(self.Coins, forKey: "Coins")
        defaultss.set(self.CoinsAva, forKey: "CoinsAva")
        print("\(self.CoinsAva) Coins")
        //        self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
        //                                  node.removeFromParentNode()
        //                              }
        //next make sure message correspond to score probably be better to have wave that lead to next level. increase game play and help better solve issue of not having to shoot every ship. help with points because unless score met ill just keep redoing level(on average 2) and message label = wave 4 ect...or can keep simple but risk consistency...Ar shoot sim to first but even session..My solution=== reward right amount of points crete large range fr levels. Make sure with the way points rewarded user cant skip levels --leaderboard/ach ---dope ui --- bugs --approval req/doc
        //
        if Time {
            self.resetTimer(time: 45)
            self.runTimer()
        } else {
//            self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
//                node.removeFromParentNode()
//            }
//            //make sure cancel ends game and every scenerio
//            self.resetTimer(time: 45)
//
//            self.play()
        }
        
        Time = false
        
    }
    func PlanetHitMoon() {
        self.messageLabel.isHidden = false
        self.messageLabel.text = "You shot the moon"
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: { [weak self] in
            
            guard let self = self else {return}
            self.PlanetHit()
                //                //scoreLabel.text = "Score: \(String(score))"
            })
            
            

        
        
        
    }
       
    
    
    func play() {
        self.sceneView.isHidden = false
                                                       SwiftSpinner.hide()
          self.resetButton.isHidden = false
        autoreleasepool {
            
            // resetTimer()
            //this will eventually use gold!!rewarded for next level instead of score
            //more gold they spend could go down..
            print("\(self.Coins) Coins")
            self.scoreL = 0
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                
                self.scoreLabel.text = String(self.scoreL)
            }
            // self.scoreLabel = self.scoreL
            //print("\(self.Coins) Coins after")
            //  let defaults = UserDefaults.standard
            
            if 11...25 ~= Coins {
                power = "banana"
                messageLabel.isHidden = true
                levelJB.text = "level 2"
                
                SecaddTargetNodes()
                //            addTargetNodesJupitar()
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {return}
                    self.sceneView.scene.rootNode.removeAllAudioPlayers()
                }
               // PlayInstructions()
                //play background music
                //                            stopBackgroundMusic()
//                playBackgroundMusic()
                // addTargetNodesFive()
                //addTargetNodesSixVenus()
                // addTargetNodesNeptune()
                // addTargetNodesSaturn()
                //h()
                //  addTargetNodesFour()
                // addTargetNodesJupitar()
                //start tinmer
                runTimer()
                print("\(Coinse): welcome to level Coinse 2")
                print("\(Coins): welcome to level 2")
            } else if 26...36 ~= Coins{
                power = "banana"
                //  sceneView.backgroundColor = UIColor.red
                messageLabel.isHidden = true
                levelJB.text = "level 3"
                addTargetNodes()
                //FsaddTargetNodes()
                // FsaddTargetNodes()
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {return}
                    self.sceneView.scene.rootNode.removeAllAudioPlayers()
                }
              //  PlayInstructions()
                //play background music
              //  playBackgroundMusic()
                
                //start tinmer
                runTimer()
                print("\(Coins): welcome to level 3 jess")
                print("\(Coinse): welcome to level 3 Coinse jess")
                
            }
                //score update properly, coin almost done
            else if 37...47 ~= Coins{
                power = "banana"
                //  sceneView.backgroundColor = UIColor.red
                
                messageLabel.isHidden = true
                levelJB.text = "level 4"
                addTargetNodesFour()
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {return}
                    self.sceneView.scene.rootNode.removeAllAudioPlayers()
                }
               // PlayInstructions()
                //play background music
              //  playBackgroundMusic()
                
                //start
                runTimer()
                print("\(Coins): welcome to level 4 jess")
                print("\(Coinse): welcome to level 4 Coinse jess")
                
            }
            //nexxxxx
            else if 48...55 ~= Coins{
                power = "banana"
                //  sceneView.backgroundColor = UIColor.red
                messageLabel.isHidden = true
                levelJB.text = "level 5"
                
                //Will need to add other nodes give a more real effect. For smaller ships
                addTargetNodesFive()
                //FsaddTargetNodes()
                // FsaddTargetNodes()
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {return}
                    self.sceneView.scene.rootNode.removeAllAudioPlayers()
                  //  self.PlayInstructions()
                    //play background music
                 //   self.playBackgroundMusic()
                }
//                PlayInstructions()
//                //play background music
//                playBackgroundMusic()
                // playingSoundWith
                //start tinmer
                runTimer()
                print("\(Coins): welcome to level 5 jess")
                print("\(Coinse): welcome to level 5 Coinse jess")
                //
            } else if 55...78 ~= Coins{
                power = "banana"
                //  sceneView.backgroundColor = UIColor.red
                messageLabel.isHidden = true
                levelJB.text = "level 6"
                addTargetNodesSixVenus()
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {return}
                    self.sceneView.scene.rootNode.removeAllAudioPlayers()
                  //  self.PlayInstructions()
                                 //play background music
                  //  self.playBackgroundMusic()
                }
                
                
                //Will need to add other nodes give a more real effect. For smaller ships
                
                //FsaddTargetNodes()
                // FsaddTargetNodes()
                //PlayInstructions()
                //play background music
                //playBackgroundMusic()
                
                //start tinmer
                runTimer()
                print("\(Coins): welcome to level 6 jess")
                print("\(Coinse): welcome to level 6 Coinse jess")
                
            }
                
                //addTargetNodesSaturn()
            else if 79...93 ~= Coins{
                power = "banana"
                messageLabel.isHidden = true
                levelJB.text = "level 7"
                
                //Will need to add other nodes give a more real effect. For smaller ships
               
                addTargetNodesNeptune()
              
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {return}
                    self.sceneView.scene.rootNode.removeAllAudioPlayers()
                  //  self.PlayInstructions()
                                  //play background music
                   // self.playBackgroundMusic()
                }
                
                //  sceneView.backgroundColor = UIColor.red
                
                //addTargetNodesSaturn()
                //FsaddTargetNodes()
                // FsaddTargetNodes()
//                PlayInstructions()
//                //play background music
//                playBackgroundMusic()
                
                //start tinmer
                runTimer()
                print("\(Coins): welcome to level 7 jess")
                print("\(Coinse): welcome to level 7 jess Coinse")
                
            } else if 94...50000 ~= Coins{
                
                power = "banana"
                messageLabel.isHidden = true
                levelJB.text = "level 8"
                
                
                addTargetNodesJupitar()
               // fix crash(fireball) and level 4, level 7, Play instructions play once
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {return}
                    self.sceneView.scene.rootNode.removeAllAudioPlayers()
                   // self.PlayInstructions()
                                  //play background music
                 //   self.playBackgroundMusic()
                }
                //  sceneView.backgroundColor = UIColor.red
                
                // FsaddTargetNodes()
//                PlayInstructions()
//                //play background music
//                playBackgroundMusic()
                
                //start tinmer
                runTimer()
                print("\(Coins): welcome to level 8 jess")
                print("\(Coinse): welcome to level 8 Coinse jess")
                
            }
                
                
                
            else {
                power = "banana"
                //  sceneView.backgroundColor = UIColor.red
                messageLabel.isHidden = true
                levelJB.text = "level 1"
               //addTargetNodesJupitar()
               FsaddTargetNodes()
               //  addTargetNodesFour()
         //addTargetNodesNeptune()
                //addTargetNodesFive()
                //addTargetNodesSixVenus()
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {return}
                    self.sceneView.scene.rootNode.removeAllAudioPlayers()
                }
                //background music fine! ad much better, 20 per mess up
                PlayInstructions()
                //play background music
             //   playBackgroundMusic()
                //  addTargetNodesJupitar()
                //start tinmer
                runTimer()
                print("\(Coins): still on level 1")
                
            }
        }
        //  stopBackgroundMusic()
    }
    
    // MARK: - missiles & targets
    
    //creates banana or axe node and 'fires' it
    var mnode = SCNNode()
    var mnodeDirection = SCNVector3()
    func fireMissile(type : String){
            //create node
        //Finish last level, new music and new ships. Dope
            mnode = createMissile(type: type)
   
            let (direction, position) = self.getUserVector()
            mnode.position = position
            switch type {
            case "banana":
                mnodeDirection  = SCNVector3(direction.x*40,direction.y*40,direction.z*40)
                mnode.physicsBody?.applyForce(mnodeDirection, at: SCNVector3(0.1,0,0), asImpulse: true)
                playSound(sound: "JBsmartsound", format: "mp3")
                
                //this stronger make a lot easier this should be temporary and rewarded after a certain level
                //or destroying enemy ship/s JBsmartsound.mp3
            case "axe":
                mnodeDirection  = SCNVector3(direction.x*40,direction.y*40,direction.z*40)
                mnode.physicsBody?.applyForce(SCNVector3(direction.x,direction.y,direction.z), at: SCNVector3(0,0,0.1), asImpulse: true)
                playSound(sound: "JBsmartsound", format: "mp3")
            default:
                mnodeDirection = direction
                mnode.physicsBody?.applyForce(mnodeDirection , asImpulse: true)
            }
            
            //move node
            //add node to scene
            sceneView.scene.rootNode.addChildNode(mnode)
        }
        
    //creates nodes

    var fireBall = SCNNode(geometry: SCNSphere(radius: 0.15))
    func createMissile(type : String)->SCNNode{
          //  fireBall.physicsBody = .dynamic()
           // fireBall.physicsBody?.mass = 0.5
            //add particles
       //   DispatchQueue.main.async {
            self.fireBall.addParticleSystem(SCNParticleSystem(named: "Fire.scnp", inDirectory: nil)!)
     //   }
            //right size fireball  devarslan@icloud.com
 
         //   let disapear = SCNAction.fadeOut(duration: 0.3)
         //   fireBall.runAction(.sequence([.wait(duration: 3) ,disapear]))
            //better blasts
 

        
              switch type {
              case "banana":
//                  let scene = SCNScene(named: "art.scnassets/missile.dae")
//                  node = (scene?.rootNode.childNode(withName: "missile", recursively: true)!)!
//                  node.scale = SCNVector3(0.2,0.2,0.2)
              //  node .geometry?.firstMaterial?.diffuse.contents = UIColor.red
                let disapear = SCNAction.fadeOut(duration: 0.1)
                fireBall.runAction(.sequence([.wait(duration: 0.5) ,disapear]))
                  fireBall.name = "bathtub"
                //  node.name = "banana"
              case "axe":
                
//                  let scene = SCNScene(named: "art.scnassets/missile.dae")
//                  node = (scene?.rootNode.childNode(withName: "missile", recursively: true)!)!
//                  node.scale = SCNVector3(0.2,0.2,0.2)
              //  node .geometry?.firstMaterial?.diffuse.contents = UIColor.blue
              //    node.name = "bathtub"
           //     fireBall.addParticleSystem(SCNParticleSystem(named: "fire.scnp", inDirectory: nil)!)
                 fireBall.name = "bathtub"
              default:
                 // node = SCNNode()
                
                fireBall = SCNNode()
              }
              
              //the physics body governs how the object interacts with other objects and its environment
//              node.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
//              node.physicsBody?.isAffectedByGravity = false
//
//              //these bitmasks used to define "collisions" with other objects
//              node.physicsBody?.categoryBitMask = CollisionCategory.missileCategory.rawValue
//              node.physicsBody?.collisionBitMask = CollisionCategory.targetCategory.rawValue
            fireBall.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
            fireBall.physicsBody?.isAffectedByGravity = false
            
            //these bitmasks used to define "collisions" with other objects
            fireBall.physicsBody?.categoryBitMask = CollisionCategory.missileCategory.rawValue
            fireBall.physicsBody?.collisionBitMask = CollisionCategory.targetCategory.rawValue
             // return node
                    return fireBall
          }
    
    //Adds 100 objects to the scene, spins them, and places them at random positions around the player.
    func addTargetNodes(){
           playBackgroundMusic()
        //2nd phase
        //when points get to a certain point like 40 means 1 left and 37 means 2 may be left
        //when game finish congrat them
        //kill certain ship and certain amount of points
        //when time run out
        //next take code from here appl to brd version
        
        //**immediate goals**
        //save won games in default
        //make blue lke small ships so it be so easy and more black and white
        //reward coins
        //add new level. (next one blue ships but a lil faster)
                                    let venusParent = SCNNode()
                                //  let msun = SCNNode(geometry: SCNSphere(radius: 0.15))
          let earthParent = SCNNode()
        let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.2 ,0 , 0))
     //   venusParent
         earth.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                            earth.physicsBody?.isAffectedByGravity = false
         earthParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                            earthParent.physicsBody?.isAffectedByGravity = false

        AllnodeArray.removeAll()
        EarGroupNodeArray.removeAll()
        
        
       // venusParent
        venusParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                  venusParent.physicsBody?.isAffectedByGravity = false
            venusParent.position = SCNVector3(0,0,-1)
         
        // venusParent.name = "earth"
//         earth.addChildNode(Shoonode)
        //8328579
        earN = earthParent
          earth.name = "earthQJ"
         earthParent.name = "earthQJ"
                                  earth.position = SCNVector3(0,0,-1)
                                   earthParent.position = SCNVector3(0,0,-1)
        earth.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
        earth.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
        earthParent.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
        earthParent.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
        venusParent.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
             venusParent.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
      //  let frame = self.sceneView.session.currentFrame
      //  let frame = self.sceneView.
        // let mat = SCNMatrix4(frame.camera.transform)
                for index in 0...2 {
                    autoreleasepool {
                    //need to create an array of nodes..each time you shoot check name and if it right one remove 5 reg nodes and the one hit make sure it explode. Make strings var make  this func shorter
                    //make node array empty in the end of the game func
                    //decent increase number of ships still seem a bit easy but that might be fine
                        //waves look better for first 4 levels
                    var Shoonode = SCNNode()
                    //make it to where it dont kill so many
                //var ShoonodeSec = SCNNode()
                    // var ShoonodeCloserEarP = SCNNode()
//                     let earthParent = SCNNode()
                                  var ssShoonode = SCNNode()
                                var ssThShoonode = SCNNode()
                                var FourthShoonode = SCNNode()
//frts one!!!
                    let SpaceShscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                            ssShoonode = (SpaceShscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                             ssShoonode.scale = SCNVector3(0.02,0.02,0.02)
                  //  ssShoonode.
                    ssShoonode.name = "shark"
                    //second one
                    
                    let Spacehscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                            ssThShoonode = (Spacehscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                             ssThShoonode.scale = SCNVector3(0.02,0.02,0.02)
                    ssThShoonode.name = "shark"
                    // third one
                    
                    let SpacehFscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                               FourthShoonode = (SpacehFscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                FourthShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                       FourthShoonode.name = "shark"
                    

                        let moonParent = SCNNode()
      
                   if (index > 1) && (index % 2 == 0) {
                    //this good for a level 2.. speed of red shps and white hard to finish in 30 sec
                   // red
//                                  let scene = SCNScene(named: "art.scnassets/spaceARcopy.scn")
//                                 Shoonode = (scene?.rootNode.childNode(withName: "SS1redcopy", recursively: true)!)!
//                                  Shoonode.scale = SCNVector3(0.03,0.03,0.03)
//                                 Shoonode.name = "shark"
                    
                    
                   let scene = SCNScene(named: "art.scnassets/spaceGreen.scn")
                                                            Shoonode = (scene?.rootNode.childNode(withName: "spaceGreenn", recursively: true)!)!
                                                  Shoonode.scale = SCNVector3(0.03,0.03,0.03)
                                                 Shoonode.name = "shark"
                              }else{
                   // blue
//                                  let scene = SCNScene(named: "art.scnassets/SS1copy.scn")
//                                  FourthShoonode = (scene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
//                                   FourthShoonode.scale = SCNVector3(0.03,0.03,0.03)
//                                   FourthShoonode.name = "shark"
                   let scene = SCNScene(named: "art.scnassets/missilecopy.scn")
                                                    Shoonode = (scene?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
                                                     Shoonode.scale = SCNVector3(0.03,0.03,0.03)
                                                     Shoonode.name = "shark"
                              }
                    
                   
                    Shoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                       Shoonode.physicsBody?.isAffectedByGravity = false
                  //  ShoonodeSec.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                       //ShoonodeSec.physicsBody?.isAffectedByGravity = false
                    ssThShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                          ssThShoonode.physicsBody?.isAffectedByGravity = false
                                       ssShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                         ssShoonode.physicsBody?.isAffectedByGravity = false
                    FourthShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                           FourthShoonode.physicsBody?.isAffectedByGravity = false

               //    venusParent.addChildNode(Shoonode)
                    earth.addChildNode(Shoonode)
                        earth.addChildNode(ssShoonode)
                                        earth.addChildNode(ssThShoonode)
                                        earth.addChildNode(FourthShoonode)
//                     earth.name = "earth"
//                    earthParent.name = "earthParent"
                  //  earth.addChildNode(ShoonodeSec)
                    AllnodeArray.append(Shoonode)
                 //   nodeArray.append(ShoonodeSec)
                    AllnodeArray.append(FourthShoonode)
                   AllnodeArray.append(ssShoonode)
                    AllnodeArray.append(ssThShoonode)
                    EarGroupNodeArray.append(earth)
                    EarGroupNodeArray.append(earthParent)

                     //changed this one!!!
                        Shoonode.position = SCNVector3(randomFloat(min: 0.1, max: 0.9),randomFloat(min: -0.8, max: 0.9), randomFloat(min: 0.1, max: 0.5))
                                                                                                                          
                                                                                                                       
                                                                                                                       //changed this one!!!
                                                                           ssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.9), randomFloat(min: -0.8, max: 0.9))
                                                                                                                       
                                                                                                                       
                                                                                                              
                                                                           ssThShoonode.position = SCNVector3(randomFloat(min: 0.1, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                                                                               FourthShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                    
                    

                           moonParent.position = SCNVector3(0 ,0 , -1)
                   
                    Shoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                          Shoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                    //ShoonodeSec.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                           //ShoonodeSec.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                    //ssShoonode
                    ssShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                             ssShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                    ssThShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                               ssThShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                     FourthShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                        
                        
                        //
                                                                                                 FourthShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                    
                    // -0.8
                           self.sceneView.scene.rootNode.addChildNode(earth)
                           self.sceneView.scene.rootNode.addChildNode(earthParent)
                           self.sceneView.scene.rootNode.addChildNode(venusParent)

                           self.sceneView.scene.rootNode.addChildNode(Shoonode)
                    //self.sceneView.scene.rootNode.addChildNode(ShoonodeSec)
                    self.sceneView.scene.rootNode.addChildNode(ssShoonode)
                      self.sceneView.scene.rootNode.addChildNode(ssThShoonode)
                     self.sceneView.scene.rootNode.addChildNode(FourthShoonode)

   
                        let GreenSecRo = XRotation(time: 4)
                        let JRRotation = Rotation(time: 5)
//                           let SecRotation = XRotation(time: 300)
                 //     let SecRo = XRotation(time: 6)
                              let sunAction = Rotation(time: 20)
                          //  let earthParentRotation = Rotation(time: 10)
                   // let VRotation = Rotation(time: 6)
                          //  let venusParentRotation = XRotation(time: 20)
                         //   let earthRotation = Rotation(time: 20)
                            let moonRotation = Rotation(time: 6)
                    // decent rotations a bit to easy.. need to make harder to kill big blue and red--show blast hitting maybe with fire but instead ship dont disappear
                      //  make big ships spin as it Rotate
                    Shoonode.runAction(GreenSecRo)
//                  //  ShoonodeSec.runAction(SecRotation)
                   ssShoonode.runAction(GreenSecRo)
//                    //FourthShoonode
                   ssThShoonode.runAction(GreenSecRo)
                    FourthShoonode.runAction(GreenSecRo)
//                        ssThShoonode
                           earthParent.runAction(JRRotation)
                           venusParent.runAction(JRRotation)
                           moonParent.runAction(moonRotation)

                           
                           earth.runAction(sunAction)
                   // earthParent.addChildNode(venusParent)
                    venusParent.addChildNode(Shoonode)
                    
                    ////****** and ven name*/
                       //    earthParent.addChildNode(Shoonode)
                   // earthParent.addChildNode(ShoonodeSec)
                    earthParent.addChildNode(ssShoonode)
                  //  ssThShoonode.addChildNode(ssShoonode)
                    earthParent.addChildNode(ssThShoonode)
                    earthParent.addChildNode(FourthShoonode)
                           earthParent.addChildNode(moonParent)
//                    for n in SSnodeArray {
//                        print("\(n.name) jessss")
//                    }
                    }
                }
            }
    
    
    
    func addTargetNodesFour(){
           playBackgroundMusic()
        //Need message dont shoot moon.
        //if so planet and moon destroyed
                                        let venusParent = SCNNode()
                         //   let msun = SCNNode(geometry: SCNSphere(radius: 0.15))
              let earthParent = SCNNode()
         let moonParent = SCNNode()
        
            let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.2 ,0 , 0))
           let moonn = planet(geometry: SCNSphere(radius: 0.09), diffuse: #imageLiteral(resourceName: "moon Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0,0,-0.3))
         //   venusParent
             earth.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                earth.physicsBody?.isAffectedByGravity = false
        moonn.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
         moonn.physicsBody?.isAffectedByGravity = false
                                    //earth.physicsBody?.isAffectedByGravity = false
             earthParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                earthParent.physicsBody?.isAffectedByGravity = false

            AllnodeArray.removeAll()
            EarGroupNodeArray.removeAll()
            
            
           // venusParent
            venusParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                      venusParent.physicsBody?.isAffectedByGravity = false
                venusParent.position = SCNVector3(0,0,-1)
             
            // venusParent.name = "earth"
    //         earth.addChildNode(Shoonode)
            //
        
            earN = earthParent
              earth.name = "earthQJ"
             earthParent.name = "earthQJ"
        moonParent.name = "earthQJ"
        moonn.name = "earthQJ"
        venusParent.name = "earthQJ"
                                      earth.position = SCNVector3(0,0,-1)
                                       earthParent.position = SCNVector3(0,0,-1)
         moonParent.position = SCNVector3(0,0,-1)
        moonn.position = SCNVector3(0,0,-0.9)
        //moon.position = SCNVector3(0 ,0 , 1.2)
            earth.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
            earth.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
            earthParent.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
            earthParent.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
        moonn.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
        moonn.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
      //  moonParent.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
       // moonParent.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
            venusParent.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                 venusParent.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
          //  let frame = self.sceneView.session.currentFrame
          //  let frame = self.sceneView.
            // let mat = SCNMatrix4(frame.camera.transform)
                    for index in 0...2 {
                        autoreleasepool {
                        //need to create an array of nodes..each time you shoot check name and if it right one remove 5 reg nodes and the one hit make sure it explode. Make strings var make  this func shorter
                        //make node array empty in the end of the game func
                        //decent increase number of ships still seem a bit easy but that might be fine
                        var Shoonode = SCNNode()
                        //make it to where it dont kill so many
                    //var ShoonodeSec = SCNNode()
                        // var ShoonodeCloserEarP = SCNNode()
    //                     let earthParent = SCNNode()
                                      var ssShoonode = SCNNode()
                                    var ssThShoonode = SCNNode()
                                    var FourthShoonode = SCNNode()
    //frts one!!!
                        let SpaceShscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                ssShoonode = (SpaceShscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                 ssShoonode.scale = SCNVector3(0.02,0.02,0.02)
                      //  ssShoonode.
                        ssShoonode.name = "shark"
                        //second one
                        
                        let Spacehscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                ssThShoonode = (Spacehscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                 ssThShoonode.scale = SCNVector3(0.02,0.02,0.02)
                        ssThShoonode.name = "shark"
                        // third one
                        
                        let SpacehFscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                   FourthShoonode = (SpacehFscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                    FourthShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                           FourthShoonode.name = "shark"
                        

                           // let moonParent = SCNNode()
          
                       if (index > 1) && (index % 2 == 0) {
                        //this good for a level 2.. speed of red shps and white hard to finish in 30 sec
                       // red
    //                                  let scene = SCNScene(named: "art.scnassets/spaceARcopy.scn")
    //                                 Shoonode = (scene?.rootNode.childNode(withName: "SS1redcopy", recursively: true)!)!
    //                                  Shoonode.scale = SCNVector3(0.03,0.03,0.03)
    //                                 Shoonode.name = "shark"
                        
                   let scene = SCNScene(named: "art.scnassets/spaceGreen.scn")
                    Shoonode = (scene?.rootNode.childNode(withName: "spaceGreenn", recursively: true)!)!
                                                      Shoonode.scale = SCNVector3(0.03,0.03,0.03)
                                                     Shoonode.name = "shark"
                                  }else{
                       // blue
    //                                  let scene = SCNScene(named: "art.scnassets/SS1copy.scn")
    //                                  FourthShoonode = (scene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
    //                                   FourthShoonode.scale = SCNVector3(0.03,0.03,0.03)
    //                                   FourthShoonode.name = "shark"
                       let scene = SCNScene(named: "art.scnassets/missilecopy.scn")
                                                        Shoonode = (scene?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
                                                         Shoonode.scale = SCNVector3(0.03,0.03,0.03)
                                                         Shoonode.name = "shark"
                                  }
                        
                       
                        Shoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                           Shoonode.physicsBody?.isAffectedByGravity = false
                      //  ShoonodeSec.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                           //ShoonodeSec.physicsBody?.isAffectedByGravity = false
                       // Shoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                              //Shoonode.physicsBody?.isAffectedByGravity = false
                                           ssShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                             ssShoonode.physicsBody?.isAffectedByGravity = false
                        
                        ssThShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                ssThShoonode.physicsBody?.isAffectedByGravity = false
                        
                        
                        FourthShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                               FourthShoonode.physicsBody?.isAffectedByGravity = false

                   //    venusParent.addChildNode(Shoonode)
                        earth.addChildNode(Shoonode)
                            earth.addChildNode(ssShoonode)
                                            earth.addChildNode(ssThShoonode)
                                            earth.addChildNode(FourthShoonode)
    //                     earth.name = "earth"
    //                    earthParent.name = "earthParent"
                      //  earth.addChildNode(ShoonodeSec)
                        AllnodeArray.append(Shoonode)
                     //   nodeArray.append(ShoonodeSec)
                        AllnodeArray.append(FourthShoonode)
                       AllnodeArray.append(ssShoonode)
                       AllnodeArray.append(ssThShoonode)
                        EarGroupNodeArray.append(earth)
                        EarGroupNodeArray.append(earthParent)

//                Shoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.9),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.5))
//
//
//                                          //changed this one!!!
//                                          ssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.3), randomFloat(min: -0.8, max: 0.9))
//
//
//
//                                          ssThShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
//                                           FourthShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                        Shoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.9),randomFloat(min: -0.8, max: 0.9), randomFloat(min: 0.1, max: 0.5))
                                                                                                                             
                                                                                                                          
                                                                                                                          //changed this one!!!
                                                                              ssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.9), randomFloat(min: -0.8, max: 0.9))
                                                                                                                          
                                                                                                                          
                                                                                                                 
                                                                              ssThShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                                                                                  FourthShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                        

                               moonParent.position = SCNVector3(0 ,0 , -1)
                       
                        Shoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                              Shoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                        //ShoonodeSec.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                               //ShoonodeSec.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                        //ssShoonode
                        ssShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                 ssShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                        ssThShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                                   ssThShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                         FourthShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                                                     FourthShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                        
                        // -0.8
                               self.sceneView.scene.rootNode.addChildNode(earth)
                               self.sceneView.scene.rootNode.addChildNode(earthParent)
                        self.sceneView.scene.rootNode.addChildNode(moonParent)
                               self.sceneView.scene.rootNode.addChildNode(venusParent)

                               self.sceneView.scene.rootNode.addChildNode(Shoonode)
                        //self.sceneView.scene.rootNode.addChildNode(ShoonodeSec)
                        self.sceneView.scene.rootNode.addChildNode(ssShoonode)
                          self.sceneView.scene.rootNode.addChildNode(ssThShoonode)
                         self.sceneView.scene.rootNode.addChildNode(FourthShoonode)

       
                                    let GreenSecRo = XRotation(time: 4)
                                    let JRRotation = Rotation(time: 5)
                            //   let SecRotation = XRotation(time: 300)
                        //  let SecRo = XRotation(time: 6)
                                  let sunAction = Rotation(time: 20)
                              //  let earthParentRotation = Rotation(time: 10)
                        //let VRotation = Rotation(time: 6)
                              //  let venusParentRotation = XRotation(time: 20)
                            //    let earthRotation = Rotation(time: 30)
                                let moonRotation = Rotation(time: 18)
                        // decent rotations a bit to easy.. need to make harder to kill big blue and red--show blast hitting maybe with fire but instead ship dont disappear
                          //  make big ships spin as it Rotate
                        Shoonode.runAction(GreenSecRo)
    //                  //  ShoonodeSec.runAction(SecRotation)
                       ssShoonode.runAction(GreenSecRo)
    //                    //FourthShoonode
                       ssThShoonode.runAction(GreenSecRo)
                        FourthShoonode.runAction(GreenSecRo)
    //                        ssThShoonode
                               earthParent.runAction(JRRotation)
                               venusParent.runAction(JRRotation)
                               moonParent.runAction(moonRotation)

                               
                               earth.runAction(sunAction)
                        moonn.runAction(sunAction)
                       // earthParent.addChildNode(venusParent)
                        venusParent.addChildNode(Shoonode)
                        
                        ////****** and ven name*/
                           //    earthParent.addChildNode(Shoonode)
                       // earthParent.addChildNode(ShoonodeSec)
                        earthParent.addChildNode(ssShoonode)
                      //  ssThShoonode.addChildNode(ssShoonode)
                        earthParent.addChildNode(ssThShoonode)
                        earthParent.addChildNode(FourthShoonode)
                        moonParent.addChildNode(moonn)
                             //  earthParent.addChildNode(moonParent)
                      //  earth.addChildNode(moon)
                            // moonParent.addChildNode(moonn)
    //                    for n in SSnodeArray {
    //                        print("\(n.name) jessss")
    //                    }
                        }
            
                    }
                }
        
    func addTargetNodesFive(){
           playBackgroundMusic()
        
           //Need message dont shoot moon.
           //if so planet and moon destroyed
        //wrked on level 4 and 5(migh get rid of moon)
                                           let venusParent = SCNNode()
                                         let sun = SCNNode(geometry: SCNSphere(radius: 0.25))
        sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Sun diffuse")
               sun.position = SCNVector3(0,0,-1)
        sun.name = "earthQJ"
                 let earthParent = SCNNode()
            let moonParent = SCNNode()
           
               let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.8 ,0 , 0))
        let EarParent = SCNNode()
        EarParent.position = SCNVector3(0,0,-1)
              let moon = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "moon Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0,0,-0.3))
            //   venusParent
                earth.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                   earth.physicsBody?.isAffectedByGravity = false
        
        sun.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        sun.physicsBody?.isAffectedByGravity = false
        sun.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                  sun.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                earthParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                   earthParent.physicsBody?.isAffectedByGravity = false

               AllnodeArray.removeAll()
               EarGroupNodeArray.removeAll()
               
               
              // venusParent
               venusParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                         venusParent.physicsBody?.isAffectedByGravity = false
                   venusParent.position = SCNVector3(0,0,-1)
                
               // venusParent.name = "earth"
       //         earth.addChildNode(Shoonode)
               //8328579
               earN = earthParent
                 earth.name = "earthQJ"
                earthParent.name = "earthQJ"
        sun.name = "earthQJ"
        earth.position = SCNVector3(0,0,1.8)
        earthParent.position = SCNVector3(0,0,1.8)
            moonParent.position = SCNVector3(1.2 ,0 , 0)
               earth.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
               earth.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
               earthParent.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
               earthParent.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
               venusParent.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                    venusParent.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
             //  let frame = self.sceneView.session.currentFrame
             //  let frame = self.sceneView.
               // let mat = SCNMatrix4(frame.camera.transform)
        for index in 0...1 {
                        autoreleasepool {
                           var Shoonode = SCNNode()
                        var ShoonodeG = SCNNode()
                          
                                         var ssShoonode = SCNNode()
                                       var ssThShoonode = SCNNode()
                                       var FourthShoonode = SCNNode()
       //frts one!!!
                           let SpaceShscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                   ssShoonode = (SpaceShscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                    ssShoonode.scale = SCNVector3(0.02,0.02,0.02)
                         //  ssShoonode.
                           ssShoonode.name = "shark"
                           //second one
                           
                           let Spacehscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                   ssThShoonode = (Spacehscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                    ssThShoonode.scale = SCNVector3(0.02,0.02,0.02)
                           ssThShoonode.name = "shark"
                           // third one
                           
                           let SpacehFscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                      FourthShoonode = (SpacehFscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                       FourthShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                              FourthShoonode.name = "shark"
                           

                               let moonParent = SCNNode()
             
                          if (index > 1) && (index % 1 == 0) {
              
                           
                           
                              let scene = SCNScene(named: "art.scnassets/spaceGreen.scn")
                                                ShoonodeG = (scene?.rootNode.childNode(withName: "spaceGreenn", recursively: true)!)!
                                                         ShoonodeG.scale = SCNVector3(0.03,0.03,0.03)
                                                        ShoonodeG.name = "shark"
                                     }else{
        
                          let scene = SCNScene(named: "art.scnassets/missilecopy.scn")
                                                           Shoonode = (scene?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
                                                            Shoonode.scale = SCNVector3(0.03,0.03,0.03)
                                                            Shoonode.name = "shark"
                                     }
                           
                          
                           Shoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                              Shoonode.physicsBody?.isAffectedByGravity = false
                        ShoonodeG.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                 ShoonodeG.physicsBody?.isAffectedByGravity = false
                         //  ShoonodeSec.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                              //ShoonodeSec.physicsBody?.isAffectedByGravity = false
                           ssThShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                 ssThShoonode.physicsBody?.isAffectedByGravity = false
                        
                        
                        
                        
                        
                                              ssShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                ssShoonode.physicsBody?.isAffectedByGravity = false
                           FourthShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                  FourthShoonode.physicsBody?.isAffectedByGravity = false

                           AllnodeArray.append(Shoonode)
                        //   nodeArray.append(ShoonodeSec)
                           AllnodeArray.append(FourthShoonode)
                          AllnodeArray.append(ssShoonode)
                           AllnodeArray.append(ssThShoonode)
                           EarGroupNodeArray.append(earth)
                           EarGroupNodeArray.append(earthParent)
                        Shoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.9),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 1.0))
                                                                  
                                                               
                        ShoonodeG.position = SCNVector3(randomFloat(min: -0.8, max: 0.9),randomFloat(min: -0.8, max: 1.2), randomFloat(min: 0.1, max: 0.9))
                                                                                         
                        
                                                               //changed this one!!!
                        ssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.9), randomFloat(min: -0.8, max: 0.9))
                                                               
                                                               
                                                      
                    ssThShoonode.position = SCNVector3(randomFloat(min: 0.8, max: 0.3),randomFloat(min: -0.8, max: 0.7), randomFloat(min: 0.1, max: 0.9))
                FourthShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.7), randomFloat(min: 0.1, max: 0.9))
                                             
                           
                           

                                 // moonParent.position = SCNVector3(0 ,0 , -1) ssThShoonode
                          
                           Shoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                 Shoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                        ShoonodeG.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                        ShoonodeG.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                        
                        ssThShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                       ssThShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                           
                           ssShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                    ssShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                           ssThShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                                      ssThShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                            FourthShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                                                        FourthShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                           
                        
                                  self.sceneView.scene.rootNode.addChildNode(venusParent)

                                  self.sceneView.scene.rootNode.addChildNode(Shoonode)
                        self.sceneView.scene.rootNode.addChildNode(ShoonodeG)
                          
                        self.sceneView.scene.rootNode.addChildNode(EarParent)
                        self.sceneView.scene.rootNode.addChildNode(sun) //self.sceneView.scene.rootNode.addChildNode(ShoonodeSec)
                           self.sceneView.scene.rootNode.addChildNode(ssShoonode)
                             self.sceneView.scene.rootNode.addChildNode(ssThShoonode)
                            self.sceneView.scene.rootNode.addChildNode(FourthShoonode)

          

                                //  let SecRotation = XRotation(time: 300)
                         let GreenSecRo = XRotation(time: 4)
                              //let JRRotation = Rotation(time: 5)
                          //   let SecRo = XRotation(time: 6)
                                     let sunAction = Rotation(time: 15)
                                 //  let earthParentRotation = Rotation(time: 20)
                        
                        let JRotation = Rotation(time: 15)
                        let JRRotation = Rotation(time: 5)
                      //  let VJRotation = Rotation(time: 25)
                           let VRotation = Rotation(time: 6)
                        //           let venusParentRotation = XRotation(time: 20)
                      //             let earthRotation = Rotation(time: 30)
                                   let moonRotation = Rotation(time: 10)
                           // decent rotations a bit to easy.. need to make harder to kill big blue and red--show blast hitting maybe with fire but instead ship dont disappear
//                        let sunAction = Rotation(time: 20)
//                                               let earthParentRotation = Rotation(time: 10)
//                                       let VRotation = Rotation(time: 6)
                             //  make big ships spin as it Rotate
                        Shoonode.runAction(GreenSecRo)
                        ShoonodeG.runAction(GreenSecRo)
                          //                  //  ShoonodeSec.runAction(SecRotation)
                                             ssShoonode.runAction(GreenSecRo)
                          //                    //FourthShoonode
                                             ssThShoonode.runAction(GreenSecRo)
                                              FourthShoonode.runAction(GreenSecRo)
                         //  Shoonode.runAction(SecRo)
       //                  //  ShoonodeSec.runAction(SecRotation)
                        //  ssShoonode.runAction(SecRo)
                        EarParent.runAction(JRotation)
       //                    //FourthShoonode
                        //  ssThShoonode.runAction(SecRotation)
                        //   FourthShoonode.runAction(SecRotation)
       //                        ssThShoonode
                                  earthParent.runAction(JRRotation)
                                  venusParent.runAction(VRotation)
                                  moonParent.runAction(moonRotation)

                                  
                                  earth.runAction(JRRotation)
                        sun.runAction(sunAction)
                          // earthParent.addChildNode(venusParent)
//                           venusParent.addChildNode(Shoonode)
                            //all are shark..level 5 bug where all ships disappear is fixed. Need to add shark to the rest
                           
                           ////****** and ven name*/
                              //    earthParent.addChildNode(Shoonode)
                          // earthParent.addChildNode(ShoonodeSec)
                        sun.addChildNode(earth)
                         sun.addChildNode(earthParent)
                        sun.addChildNode(EarParent)
                        // earthParent.addChildNode(Shoonode)
                           earthParent.addChildNode(ssShoonode)
                        earthParent.addChildNode(ShoonodeG)
                        //earth.addChildNode(EarParent)
                         //  ssThShoonode.addChildNode(ssShoonode)
                          earthParent.addChildNode(Shoonode)
                        earthParent.addChildNode(ssThShoonode)
                           earthParent.addChildNode(FourthShoonode)
                                  earthParent.addChildNode(moonParent)
                           earthParent.addChildNode(moon)
                                moonParent.addChildNode(moon)
       //                    for n in SSnodeArray {
       //                        print("\(n.name) jessss")
       //                    }
                        }
                       }
                   }
           
    func addTargetNodesSixVenus(){
           playBackgroundMusic()
               //Need message dont shoot moon.
               //if so planet and moon destroyed
        //Make ships move on dif speeds llke earlter
                                               let venusParent = SCNNode()
                                                let venusParentSun = SCNNode()
        venusParentSun.position = SCNVector3(0,0,-1)
                                             let sun = SCNNode(geometry: SCNSphere(radius: 0.25))
            sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Sun diffuse")
                   sun.position = SCNVector3(0,0,-1)
        sun.name = "earthQJ"
                     let earthParent = SCNNode()
                let moonParent = SCNNode()
               
                   let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.8 ,0 , 0))
         let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "Venus Surface"), specular: nil, emission: #imageLiteral(resourceName: "Venus Atmosphere"), normal: nil, position: SCNVector3(0.5, 0, 0))
        venus.name = "earthQJ"
              //    let moon = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "moon Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0,0,-0.3))
                //   venusParent
                    earth.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                       earth.physicsBody?.isAffectedByGravity = false
                    earthParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                       earthParent.physicsBody?.isAffectedByGravity = false
        sun.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
             sun.physicsBody?.isAffectedByGravity = false
             sun.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                       sun.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
        venus.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                  venus.physicsBody?.isAffectedByGravity = false
                  venus.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                            venus.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                   
        AllnodeArray.removeAll()
        EarGroupNodeArray.removeAll()
                   
                  // venusParent
                   venusParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                             venusParent.physicsBody?.isAffectedByGravity = false
                     //  venusParent.position = SCNVector3(0,0,-1)
                    
                   // venusParent.name = "earth"
           //         earth.addChildNode(Shoonode)
                   //8328579
                   earN = earthParent
                     earth.name = "earthQJ"
                    earthParent.name = "earthParent"
        //where the relationships between earth and earthParent
                                             earth.position = SCNVector3(1.8,0,0)
                                              earthParent.position = SCNVector3(1.8,0,0)
        
        
        venusParent.position = SCNVector3(-1.7,0,0)
         venus.position = SCNVector3(-1.7,0,0)
                moonParent.position = SCNVector3(1.2 ,0 , 0)
                   earth.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                   earth.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                   earthParent.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                   earthParent.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                   venusParent.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                        venusParent.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                 //  let frame = self.sceneView.session.currentFrame
                 //  let frame = self.sceneView.
                   // let mat = SCNMatrix4(frame.camera.transform)
                           for index in 0...2 {
                            autoreleasepool {
                               var Shoonode = SCNNode()
                       
                               //make it to where it dont kill so many
                           //var ShoonodeSec = SCNNode()
                               // var ShoonodeCloserEarP = SCNNode()
           //                     let earthParent = SCNNode()
                                             var ssShoonode = SCNNode()
                                           var ssThShoonode = SCNNode()
                                           var FourthShoonode = SCNNode()
                            var VenShoonode = SCNNode()
                                                         //make it to where it dont kill so many
                                                     //var ShoonodeSec = SCNNode()
                                                         // var ShoonodeCloserEarP = SCNNode()
                                     //                     let earthParent = SCNNode()
                                                                       var VenssShoonode = SCNNode()
                                                                     var VenssThShoonode = SCNNode()
                                                                     var VenFourthShoonode = SCNNode()
           //frts one!!!
                               let SpaceShscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                       ssShoonode = (SpaceShscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                        ssShoonode.scale = SCNVector3(0.02,0.02,0.02)
                             //  ssShoonode.
                               ssShoonode.name = "shark"
                               //second one
                               
                               let Spacehscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                       ssThShoonode = (Spacehscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                        ssThShoonode.scale = SCNVector3(0.02,0.02,0.02)
                               ssThShoonode.name = "shark"
                               // third one
                               
                               let SpacehFscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                          FourthShoonode = (SpacehFscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                           FourthShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                  FourthShoonode.name = "shark"
                            
                            
                            
                            //Ven
                            let SpaceShscenee = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                  VenShoonode = (SpaceShscenee?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                   VenShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                        //  ssShoonode.
                                                          VenShoonode.name = "shark"
                                                          //second one
//                                                          var VenssShoonode = SCNNode()
                            
                            let Spacehscenev = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                VenssThShoonode = (Spacehscenev?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                 VenssThShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                        VenssThShoonode.name = "shark"
//                                                                                                                              var VenssThShoonode = SCNNode()
//                                                                                                                              var VenFourthShoonode = SCNNode()
                            
                                                          let Spacehscener = SCNScene(named: "art.scnassets/SS1copy.scn")
                    VenssShoonode  = (Spacehscener?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                   VenssShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                          VenssShoonode .name = "shark"
                                                          // third one
                                                          
                                                          let SpacehFscenea = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                                     VenFourthShoonode = (SpacehFscenea?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                                      VenFourthShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                             VenFourthShoonode.name = "shark"
                               

                                   let moonParent = SCNNode()
                 
                              if (index > 1) && (index % 2 == 0) {
                          
                               
                               
                                 let scene = SCNScene(named: "art.scnassets/spaceGreen.scn")
                                                                                  Shoonode = (scene?.rootNode.childNode(withName: "spaceGreenn", recursively: true)!)!
                                                             Shoonode.scale = SCNVector3(0.03,0.03,0.03)
                                                            Shoonode.name = "shark"
                                
                                let scenee = SCNScene(named: "art.scnassets/spaceGreen.scn")
                                                                                                               VenShoonode = (scenee?.rootNode.childNode(withName: "spaceGreenn", recursively: true)!)!
                                                                                            VenShoonode.scale = SCNVector3(0.03,0.03,0.03)
                                                                                           VenShoonode.name = "shark"
                                
                                         }else{
     
                              let scene = SCNScene(named: "art.scnassets/missilecopy.scn")
                                                               Shoonode = (scene?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
                                                                Shoonode.scale = SCNVector3(0.03,0.03,0.03)
                                                                Shoonode.name = "shark"
                                
                                let scenee = SCNScene(named: "art.scnassets/missilecopy.scn")
                                                                                             VenShoonode = (scenee?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
                                                                                              VenShoonode.scale = SCNVector3(0.03,0.03,0.03)
                                                                                              VenShoonode.name = "shark"
                                         }
                               
                              
                               Shoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                  Shoonode.physicsBody?.isAffectedByGravity = false
                           // ShoonodeG.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                          //  ShoonodeG.physicsBody?.isAffectedByGravity = false
                          //  VenShoonodeG.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                               // VenShoonodeG.physicsBody?.isAffectedByGravity = false
                             //  ShoonodeSec.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                  //ShoonodeSec.physicsBody?.isAffectedByGravity = false
                               Shoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                            Shoonode.physicsBody?.isAffectedByGravity = false
                            ssThShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                            ssThShoonode.physicsBody?.isAffectedByGravity = false
                                                   
                                                        
                                                                     
                                                  ssShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                    ssShoonode.physicsBody?.isAffectedByGravity = false
                               FourthShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                      FourthShoonode.physicsBody?.isAffectedByGravity = false

                              VenShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                 VenShoonode.physicsBody?.isAffectedByGravity = false
                            //  ShoonodeSec.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                 //ShoonodeSec.physicsBody?.isAffectedByGravity = false
                            //  VenShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                    //Shoonode.physicsBody?.isAffectedByGravity = false
                                                 VenssShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                   VenssShoonode.physicsBody?.isAffectedByGravity = false
                              VenFourthShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                     VenFourthShoonode.physicsBody?.isAffectedByGravity = false
                            VenssThShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                                VenssThShoonode.physicsBody?.isAffectedByGravity = false

                          //    venusParent.addChildNode(Shoonode)
                               earth.addChildNode(Shoonode)
                          //  earth.addChildNode(ShoonodeG)
                                   earth.addChildNode(ssShoonode)
                                                   earth.addChildNode(ssThShoonode)
                                                   earth.addChildNode(FourthShoonode)
                            
                            
                            venus.addChildNode(VenShoonode)
                            // venusParent.addChildNode(VenShoonodeG)
                                                              venus.addChildNode(VenssShoonode)
                                                                              venus.addChildNode(VenssThShoonode)
                                                                              venus.addChildNode(VenFourthShoonode)
           //                     earth.name = "earth"
           //                    earthParent.name = "earthParent"
                             //  earth.addChildNode(ShoonodeSec)
                               AllnodeArray.append(Shoonode)
                            //   nodeArray.append(ShoonodeSec)
                               AllnodeArray.append(FourthShoonode)
                              AllnodeArray.append(ssShoonode)
                               AllnodeArray.append(ssThShoonode)
                               EarGroupNodeArray.append(earth)
                               EarGroupNodeArray.append(earthParent)
                            AllnodeArray.append(VenShoonode)
                                                      //   nodeArray.append(ShoonodeSec)
                                                         AllnodeArray.append(VenFourthShoonode)
                                                        AllnodeArray.append(VenssShoonode)
                                                         AllnodeArray.append(VenssThShoonode)
                                                         EarGroupNodeArray.append(earth)
                                                         EarGroupNodeArray.append(earthParent)
                            Shoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.9), randomFloat(min: 0.1, max: 0.5))
                                                       
                                                    
                                                    //changed this one!!!
                                                    ssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.3), randomFloat(min: -0.8, max: 0.8))
                                                    
                                                    
                                           
                                                    ssThShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.5))
                                                     FourthShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.9), randomFloat(min: 0.1, max: 0.7))
                                                    
                               
                               

        //ven
                             VenShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.9),randomFloat(min: -0.8, max: 0.9), randomFloat(min: 0.1, max: 0.5))
                           //  VenShoonodeG.position = SCNVector3(randomFloat(min: -0.8, max: 0.9),randomFloat(min: -0.8, max: 0.9), randomFloat(min: 0.1, max: 0.9))
                                                                                                                             
                                                                                                                          
                                                                                                                          //changed this one!!!
                                VenssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.9), randomFloat(min: -0.8, max: 0.9))
                                                                                                                          
                                                                                                                          
                                                                                                                 
                            VenssThShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.9), randomFloat(min: 0.1, max: 0.9))
                                VenFourthShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                                                                
                            
                            
                                     // moonParent.position = SCNVector3(0 ,0 , -1)
                              
                               Shoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                     Shoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                            
                               ssShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                        ssShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                               ssThShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
        ssThShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                FourthShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
        FourthShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                            VenShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
        VenShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                                       
        VenssShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                                                   VenssShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
            VenssThShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
        VenssThShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
    VenFourthShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
    VenFourthShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                      
                                      self.sceneView.scene.rootNode.addChildNode(venusParent)

                                      self.sceneView.scene.rootNode.addChildNode(Shoonode)
                          //  self.sceneView.scene.rootNode.addChildNode(ShoonodeG)
                            self.sceneView.scene.rootNode.addChildNode(VenShoonode)
                            // self.sceneView.scene.rootNode.addChildNode(VenShoonodeG)
                              
                            self.sceneView.scene.rootNode.addChildNode(earthParent)
                            self.sceneView.scene.rootNode.addChildNode(sun)
                             self.sceneView.scene.rootNode.addChildNode(venusParentSun)//self.sceneView.scene.rootNode.addChildNode(ShoonodeSec)
                               self.sceneView.scene.rootNode.addChildNode(ssShoonode)
                                 self.sceneView.scene.rootNode.addChildNode(ssThShoonode)
                                self.sceneView.scene.rootNode.addChildNode(FourthShoonode)
                            self.sceneView.scene.rootNode.addChildNode(VenssShoonode)
                                                           self.sceneView.scene.rootNode.addChildNode(VenssThShoonode)
                                                          self.sceneView.scene.rootNode.addChildNode(VenFourthShoonode)

               let GreenSecRo = XRotation(time: 4)
                                      let JRRotation = Rotation(time: 5)
                                     

                                       //  let SecRotation = XRotation(time: 300)
               //         let SecRo = XRotation(time: 2)
              //                  let JRRotation = Rotation(time: 5)
                                                                                         
                            let sunAction = Rotation(time: 29)
                          //let venusRotation = Rotation(time: 9)                               // complete level 9 JRotation = Rotation(time: 15)
             //       let sunActionS = Rotation(time: 12)
                                                                                         
                                                                                         
                    let sunActionVenus = Rotation(time: 30)
            //            let sunActionNep = Rotation(time: 13)
              //      let sunActionJ = Rotation(time: 11)
                         //                                let sunActionEar = Rotation(time: 12)
                //                let earthParentRotation = Rotation(time: 20)
              //                      let VRotation = Rotation(time: 15)
            //                        let earthRotation = Rotation(time: 30)
                                    let moonRotation = Rotation(time: 10)
                                //let venusRotation = Rotation(time: 9)
          //                      let JupRotation = Rotation(time: 8)
                                                                                           let JRotation = Rotation(time: 15)
           Shoonode.runAction(GreenSecRo)
                            
                                                            //                  //  ShoonodeSec.runAction(SecRotation)
            ssShoonode.runAction(GreenSecRo)
                                                                          
                                                            //                    //FourthShoonode
            ssThShoonode.runAction(GreenSecRo)
                                        FourthShoonode.runAction(GreenSecRo)
                               venusParentSun.runAction(sunActionVenus)
                            //Ven added
                            VenShoonode.runAction(GreenSecRo)
                                //level 6 more natual waves
                                                                                     //                  //  ShoonodeSec.runAction(SecRotation)
                                        VenssShoonode.runAction(GreenSecRo)
                             
                                                                                     //                    //FourthShoonode
                                VenssThShoonode.runAction(GreenSecRo)
                            VenFourthShoonode.runAction(GreenSecRo)
                            
                            
           //                        ssThShoonode
                                      earthParent.runAction(JRotation)
                                      venusParent.runAction(JRotation)
                    
                                      moonParent.runAction(moonRotation)
                                     venus.runAction(JRRotation)
                                       //venusParent.addChildNode(venus)
                                    
                            //stable rotations
                            sun.runAction(sunAction)
                              earth.runAction(JRRotation)
                            //figured out how distribute ships will have to create more Shoonodes
                            //can be elaborate with given planets diff rotations since its
                            sun.addChildNode(earth)
                             sun.addChildNode(earthParent)
                            //venusParent.addChildNode(venus)
                            venusParentSun.addChildNode(venusParent)
                            //added venus and planets
                            venusParentSun.addChildNode(venus)
                            
                            earth.addChildNode(ssShoonode)
                               earth.addChildNode(Shoonode)
                             //  ssThShoonode.addChildNode(ssShoonode)
                               earth.addChildNode(ssThShoonode)
                               earth.addChildNode(FourthShoonode)
                            
                            venus.addChildNode(VenssShoonode)
                            venus.addChildNode(VenShoonode)
                                                        //  ssThShoonode.addChildNode(ssShoonode)
                                                          venus.addChildNode(VenssThShoonode)
                                                          venus.addChildNode(VenFourthShoonode)
                                      //earthParent.addChildNode(moonParent)
                               //earth.addChildNode(moon)
                                 //   moonParent.addChildNode(moon)
           //                    for n in SSnodeArray {
           //                        print("\(n.name) jessss")
           //                    }
                   
                           }
                       }
    }
    
    
    func h(){
   
                          
                              //radius: 0.1
                                    let sphere = SCNSphere(radius: 0.1)
                // let material = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "Venus Surface"), specular: nil, emission: #imageLiteral(resourceName: "Venus Atmosphere"), normal: nil, position: SCNVector3(0.5, 0, 0))
                //#imageLiteral(resourceName: "Venus Surface")
                 let material = SCNMaterial()
                 material.diffuse.contents = UIImage(named: "Venus Surface")
               // material.diffuse.contents = #imageLiteral(resourceName: "Venus Surface")
                sphere.materials = [material]
                                  let venusParent = SCNNode(geometry: sphere)
                                   
                                  let venusParentSun = SCNNode()
                            
                                 
                          
                
                                            venusParentSun.position = SCNVector3(0,0,-1)
                                                                                 let sun = SCNNode(geometry: SCNSphere(radius: 0.25))
                                                sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Sun diffuse")
                                                       sun.position = SCNVector3(0,0,-1)
                                                         let earthParent = SCNNode()
                                                    let moonParent = SCNNode()
                                                   
                                                       let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.8 ,0 , 0))
                                            let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "Venus Surface"), specular: nil, emission: #imageLiteral(resourceName: "Venus Atmosphere"), normal: nil, position: SCNVector3(0.5, 0, 0))
                                                      let moon = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "moon Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0,0,-0.3))
                                                    //   venusParent
                                                        earth.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                           earth.physicsBody?.isAffectedByGravity = false
                                                        earthParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                           earthParent.physicsBody?.isAffectedByGravity = false

                                                       
                                                       
                                                       
                                                      // venusParent
                                                       venusParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                 venusParent.physicsBody?.isAffectedByGravity = false
                                                         //  venusParent.position = SCNVector3(0,0,-1)
                                                        
                                                       // venusParent.name = "earth"
                                               //         earth.addChildNode(Shoonode)
                //decent rotations, maybe some could be closer. Fixed bugs with music and ships ending game!
                                                       //8328579
                                                       earN = earthParent
                                                         earth.name = "earthQJ"
                                                        earthParent.name = "earthParent"
                                            //where the relationships between earth and earthParent
                //perfect distance of planets
                earth.position = SCNVector3(1.8,0,0)
                earthParent.position = SCNVector3(1.8,0,0)
        venusParent.position = SCNVector3(-1.7,0,0)
        venus.position = SCNVector3(-1.7,0,0)
                                  //better rotations..nice positions
                             
        //        venusParent.position = SCNVector3(0,0,1.2)
        //        venus.position = SCNVector3(0,0,1.2)
                
                              moonParent.position = SCNVector3(1.2 ,0 , 0)
                          earth.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                  earth.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                  earthParent.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                  earthParent.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
        venusParent.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                              venusParent.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
        venus.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                  venus.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
     
                                              
                              for index in 0...3 {
                                                //ear***
                                      var Shoonode = SCNNode()
                                                       
                                      var ssShoonode = SCNNode()
                                      var ssThShoonode = SCNNode()
                                      var FourthShoonode = SCNNode()
                                                                 //ven******
                                              var VenShoonode = SCNNode()
        
                                                  var VenssShoonode = SCNNode()
                                                                                                         var VenssThShoonode = SCNNode()
                                                                                                         var VenFourthShoonode = SCNNode()
                                                               
                                
                                
                                               //ear
                                                                   let SpaceShscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                           ssShoonode = (SpaceShscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                            ssShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                 //  ssShoonode.
                                                                   ssShoonode.name = "shark"
                                                                   //second one
                                                                   
                                                                   let Spacehscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                           ssThShoonode = (Spacehscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                            ssThShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                   ssThShoonode.name = "shark"
                                                                   // third one
                                                                   
                                                                   let SpacehFscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                                              FourthShoonode = (SpacehFscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                                               FourthShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                      FourthShoonode.name = "shark"
                                                                
                                                                
                                                                
                                                                //Ven
                                                                let SpaceShscenee = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                                                      VenShoonode = (SpaceShscenee?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                                                       VenShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                              //ssShoonode.
                                                                                              VenShoonode.name = "shark"
                                                                                              //second one
                                    //                                                          var VenssShoonode = SCNNode()
                                                                
                                                                let Spacehscenev = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                                                    VenssThShoonode = (Spacehscenev?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                                                     VenssThShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                            VenssThShoonode.name = "shark"
                                    //                                                                                                                              var VenssThShoonode = SCNNode()
                                    //                                                                                                                              var VenFourthShoonode = SCNNode()
                                                                
                                                                                              let Spacehscener = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                                                      VenssShoonode  = (Spacehscener?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                                                       VenssShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                              VenssShoonode .name = "shark"
                                                                                              // third one
                                                                                              
                                                                                              let SpacehFscenea = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                                                                         VenFourthShoonode = (SpacehFscenea?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                                                                          VenFourthShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                                 VenFourthShoonode.name = "shark"
                                                                 //sa
                           
                                                                       let moonParent = SCNNode()
                                                     
                                                                  if (index > 1) && (index % 3 == 0) {
                                                              
                                                                   
                                                                   //ear
                                    let scene = SCNScene(named: "art.scnassets/spaceGreen.scn")
                            Shoonode = (scene?.rootNode.childNode(withName: "spaceGreenn", recursively: true)!)!
                                        Shoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                Shoonode.name = "ha"
                                                                    //Ven
                                                                    let scenee = SCNScene(named: "art.scnassets/spaceARcopy.scn")
                                                                                                                               VenShoonode = (scenee?.rootNode.childNode(withName: "spaceGreenn", recursively: true)!)!
                                                                                                                                VenShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                                               VenShoonode.name = "shark"
                                                                     //sa
                                                                                     
                                                                    
                                                                             }else{
                                                                    //ear
                                    let scene = SCNScene(named: "art.scnassets/missilecopy.scn")
                    Shoonode = (scene?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
                                                            Shoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                    Shoonode.name = "SS1copy.scn"
        //                                                            //ven
                                                                    let scenee = SCNScene(named: "art.scnassets/missilecopy.scn")
                                                                                                                                 VenShoonode = (scenee?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
                                                                                                                                  VenShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                                                  VenShoonode.name = "SS1copy.scn"
                                                                     //sa
                                                                             }
                                                                   
                                                                  
                                                                   Shoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                      Shoonode.physicsBody?.isAffectedByGravity = false
                                                
                                                                   Shoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                Shoonode.physicsBody?.isAffectedByGravity = false
                            ssThShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                            ssThShoonode.physicsBody?.isAffectedByGravity = false
                                                                                       
                                                                                            
                                                                                                         
            ssShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                ssShoonode.physicsBody?.isAffectedByGravity = false
                FourthShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                                                          FourthShoonode.physicsBody?.isAffectedByGravity = false
                                //Jup
                              
                                                                 //ven
                                                                  VenShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                     VenShoonode.physicsBody?.isAffectedByGravity = false
                                                                //  ShoonodeSec.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                     //ShoonodeSec.physicsBody?.isAffectedByGravity = false
                                                                  VenShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        
                                                                                     VenssShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                                       VenssShoonode.physicsBody?.isAffectedByGravity = false
                                                                  VenFourthShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                                                         VenFourthShoonode.physicsBody?.isAffectedByGravity = false
                                                                VenssThShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                                                                    VenssThShoonode.physicsBody?.isAffectedByGravity = false
                                                                 //sa
                                           
                                                                  
                                                                  //end
                                                              //    venusParent.addChildNode(Shoonode)
                        earth.addChildNode(Shoonode)
                            earth.addChildNode(ssShoonode)
                                        earth.addChildNode(ssThShoonode)
                                    earth.addChildNode(FourthShoonode)
                                                                //VEN
                                                              
                                                                venus.addChildNode(VenShoonode)
                                                                                                  venus.addChildNode(VenssShoonode)
                                                                                                                  venus.addChildNode(VenssThShoonode)
                                                                                                                  venus.addChildNode(VenFourthShoonode)
                                        //Sa
                                                           
                                //                    earth.name = "earth"
                                               //                    earthParent.name = "earthParent"
                                                                 //  earth.addChildNode(ShoonodeSec)
                                                                   nodeArray.append(Shoonode)
                                                                //   nodeArray.append(ShoonodeSec)
                                                                   ThirdGroupNodeArray.append(FourthShoonode)
                                                                  SSnodeArray.append(ssShoonode)
                                                                   SecGroupNodeArray.append(ssThShoonode)
                                                                   EarGroupNodeArray.append(earth)
                                                                   EarGroupNodeArray.append(earthParent)
                              
                                                                                             EarGroupNodeArray.append(earth)
                                                                                             EarGroupNodeArray.append(earthParent)
                                nodeArray.append(VenShoonode)
                                                                                     //   nodeArray.append(ShoonodeSec)
                                                                                        ThirdGroupNodeArray.append(VenFourthShoonode)
                                                                                       SSnodeArray.append(VenssShoonode)
                                                                                        SecGroupNodeArray.append(VenssThShoonode)
                                                                 //sa*
                                                            
                                                                 // EarGroupNodeArray.append(earth)
                                                                 // EarGroupNodeArray.append(earthParent)
                                                                  //nep*
                                              
                                                                                                               

                                
                                Shoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.9),randomFloat(min: -0.8, max: 0.9), randomFloat(min: 0.1, max: 0.5))
                                                                           
                                                                        
                                                                        //changed this one!!!
                            ssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.9), randomFloat(min: -0.8, max: 0.9))
                                                                        
                                                                        
                                                               
                            ssThShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                                FourthShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                                VenShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.9),randomFloat(min: -0.8, max: 0.9), randomFloat(min: 0.1, max: 0.5))
                                                          //  VenShoonodeG.position = SCNVector3(randomFloat(min: -0.8, max: 0.9),randomFloat(min: -0.8, max: 0.9), randomFloat(min: 0.1, max: 0.9))
                                                                                                                                                            
                                                                                                                                                         
                                                                                                                                                         //changed this one!!!
                                                               VenssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.9), randomFloat(min: -0.8, max: 0.9))
                                                                                                                                                         
                                                                                                                                                         
                                                                                                                                                
                                                           VenssThShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.9), randomFloat(min: 0.1, max: 0.9))
                                                               VenFourthShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                                                                                               
                                                           
                                          
                   
                                                                 
                                                                
                                                                          moonParent.position = SCNVector3(0 ,0 , -1)
                                                                  
                        Shoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                    Shoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                                                
                    ssShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                ssShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                    ssThShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                ssThShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                FourthShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
            FourthShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                //Jup
                               
                                
        //                                                         //Ven
                                                                VenShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                        VenShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
        
                        VenssShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                        VenssShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                        VenssThShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                        VenssThShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                        VenFourthShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                                                VenFourthShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                                                 //sa****
               
                                                          //Jup
        //                        Jupitar
                                                                          self.sceneView.scene.rootNode.addChildNode(venusParent)
                                self.sceneView.scene.rootNode.addChildNode(venus)
                                self.sceneView.scene.rootNode.addChildNode(venusParentSun)
                              
                                          
                                 // self.sceneView.scene.rootNode.addChildNode(JupitarParentSun)
                                                                 // self.sceneView.scene.rootNode.addChildNode(neptune)
                                                                 
                                            

                                        self.sceneView.scene.rootNode.addChildNode(Shoonode)
                                                              
                                                                  
                                            self.sceneView.scene.rootNode.addChildNode(earthParent)
                                            self.sceneView.scene.rootNode.addChildNode(sun)
                                                                 //self.sceneView.scene.rootNode.addChildNode(venusParentSun)//self.sceneView.scene.rootNode.addChildNode(ShoonodeSec)
                                                self.sceneView.scene.rootNode.addChildNode(ssShoonode)
                                            self.sceneView.scene.rootNode.addChildNode(ssThShoonode)
                                            self.sceneView.scene.rootNode.addChildNode(FourthShoonode)
                                
        //                                                         //ven
                                                                   self.sceneView.scene.rootNode.addChildNode(VenShoonode)
                                                                self.sceneView.scene.rootNode.addChildNode(VenssShoonode)
                                                                                               self.sceneView.scene.rootNode.addChildNode(VenssThShoonode)
                                                                                              self.sceneView.scene.rootNode.addChildNode(VenFourthShoonode)
                                
                                //Jup
                               
  //let venusRotation = Rotation(time: 9)                               // complete level 9 JRotation = Rotation(time: 15)
                                                                          let SecRotation = XRotation(time: 300)
                                                                     let SecRo = XRotation(time: 2)
                                                 //                let JRRotation = Rotation(time: 5)
                                                                
                                                                             let sunAction = Rotation(time: 19)
                                // complete level 9
                          //       let sunActionS = Rotation(time: 12)
                                                                
                                                          let sunActionVenus = Rotation(time: 30)
                                              //  let sunActionVenus = Rotation(time: 25)
                         //               let sunActionNep = Rotation(time: 13)
                        //            let sunActionJ = Rotation(time: 11)
                        //        let sunActionEar = Rotation(time: 12)
                                //            let earthParentRotation = Rotation(time: 20)
                                 //                                  let VRotation = Rotation(time: 15)
                                   //                                        let venusParentRotation = XRotation(time: 30)
                                 //               let earthRotation = Rotation(time: 30)
                                                                           let moonRotation = Rotation(time: 10)
                                                                 let venusRotation = Rotation(time: 9)
                             //                       let JupRotation = Rotation(time: 8)
                                                                  let JRotation = Rotation(time: 15)
                                                                   Shoonode.runAction(SecRotation)
                                               //                  //  ShoonodeSec.runAction(SecRotation)
                                                                  ssShoonode.runAction(SecRotation)
                                                             
                                               //                    //FourthShoonode
                                                                  ssThShoonode.runAction(SecRo)
                                                                   FourthShoonode.runAction(SecRotation)
                                                                      
                                //Jup
                                                                            
                                                                
        //                                                        //Ven added
                                                                 VenShoonode.runAction(SecRotation)
                                                                //                  //  ShoonodeSec.runAction(SecRotation)
                                                                                   VenssShoonode.runAction(SecRotation)
        //
        //                                                        //                    //FourthShoonode
                                                                                   VenssThShoonode.runAction(SecRo)
                                                                                    VenFourthShoonode.runAction(SecRotation)
                                                                  //nep
                                                                  
                                
                                
                                
                                //venusParent.runAction(JRotation),  venus.runAction(venusRotation)
                                                    //venusParentSun.addChildNode(venusParent),  venusParentSun.addChildNode(venus)
                                                    //venus.addChildNode(VenssShoonode)
                                                  //  venus.addChildNode(VenShoonode)
                                                                                //  ssThShoonode.addChildNode(ssShoonode)
                                                                                  //venus.addChildNode(VenssThShoonode)
                                                                                  //venus.addChildNode(VenFourthShoonode)
                                
                                                                              sun.runAction(sunAction)
                                                                       earth.runAction(sunAction)
                                venusParent.runAction(JRotation)
                                 venusParentSun.runAction(sunActionVenus)
                                                                          moonParent.runAction(moonRotation)
                                                                         venus.runAction(venusRotation)
                                                             
                                
                                                                //figured out how distribute ships will have to create more Shoonodes
                                                                //can be elaborate with given planets diff rotations since its
                                                                sun.addChildNode(earth)
                                                                 sun.addChildNode(earthParent)
                                  venusParentSun.addChildNode(venusParent)
                                venusParentSun.addChildNode(venus)
                                                                //venusParent.addChildNode(venus)
                                                             //   venusParentSun.addChildNode(venusParent)
                                                                 
                                                                //added venus and planets
                                                             //   venusParentSun.addChildNode(venus)
                                                                 
                                                                 //ear
                                                                earth.addChildNode(ssShoonode)
                                                                   earthParent.addChildNode(Shoonode)
                                                                 //  ssThShoonode.addChildNode(ssShoonode)
                                                                   earthParent.addChildNode(ssThShoonode)
                                                                   earthParent.addChildNode(FourthShoonode)
                                
                                
                                venus.addChildNode(VenssShoonode)
                                                                                venus.addChildNode(VenShoonode)
                                                                                                              //ssThShoonode.addChildNode(ssShoonode)
                                                                                                              venus.addChildNode(VenssThShoonode)
                                                                                                              venus.addChildNode(VenFourthShoonode)
                                                            
                                
                                                            //Jupitar
                                
                                                                                    
                                
                                
                                                           
                                                                   earth.addChildNode(moon)
                                                                        moonParent.addChildNode(moon)
                                               //                    for n in SSnodeArray {
                                               //                        print("\(n.name) jessss")
                                               //                    }
                                                       
                                                               }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func addTargetNodesSaturn(){
        let SaturnParent = SCNNode()
        
               
            let SaturnParentSun = SCNNode()

                                                      let venusParent = SCNNode()
        let saturnRing = createRing(ringSize: 0.3)
                                      let saturn = createPlanet(radius: 0.2, image: "saturn")
                                      saturn.name = "saturn"
                                saturn.position = SCNVector3(2.5,0,0)
                                      rotateObject(rotation: 0.1, planet: saturn, duration: 0.4)
                                      rotateObject(rotation: 0.1, planet: saturnRing, duration: 1)
                                                                                                          let venusParentSun = SCNNode()
                                                                  venusParentSun.position = SCNVector3(0,0,-1)
                                                                                                       let sun = SCNNode(geometry: SCNSphere(radius: 0.25))
                                                                      sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Sun diffuse")
                                                                             sun.position = SCNVector3(0,0,-1)
                                                                               let earthParent = SCNNode()
                                                                          let moonParent = SCNNode()
                                                                         
                                                                             let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.8 ,0 , 0))
                                                                   let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "Venus Surface"), specular: nil, emission: #imageLiteral(resourceName: "Venus Atmosphere"), normal: nil, position: SCNVector3(0.5, 0, 0))
                                        //let moon = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "moon Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0,0,-0.3))
                                                                          //   venusParent
                                                                              earth.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                                 earth.physicsBody?.isAffectedByGravity = false
        
        saturn.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                         saturn.physicsBody?.isAffectedByGravity = false
                                                                              earthParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                                 earthParent.physicsBody?.isAffectedByGravity = false

                                                                             
                                                                             
                                                                             
                                                                            // venusParent
                                                                             venusParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                                       venusParent.physicsBody?.isAffectedByGravity = false
        SaturnParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        SaturnParent.physicsBody?.isAffectedByGravity = false
                                                                               //  venusParent.position = SCNVector3(0,0,-1)
                                                                              
                                                                             // venusParent.name = "earth"
                                                                     //         earth.addChildNode(Shoonode)
                                                                             //8328579
                                                                             earN = earthParent
                                                                               earth.name = "earthQJ"
                                                                              earthParent.name = "earthParent"
                                                                  //where the relationships between earth and earthParent
                                                                                                       earth.position = SCNVector3(1.8,0,0)
                                                                                                        earthParent.position = SCNVector3(1.8,0,0)
                                                                  
                                                                  
        saturn.position = SCNVector3(-2.5,0,0)
                                SaturnParent.position = SCNVector3(-2.5,0,0)
         SaturnParentSun.position = SCNVector3(0,0,-1)
        
                                                                  venusParent.position = SCNVector3(-1.7,0,0)
                                                                   venus.position = SCNVector3(-1.7,0,0)
                                                                          moonParent.position = SCNVector3(1.2 ,0 , 0)
                                                                             earth.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                             earth.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
        saturn.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
        saturn.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
        //SaturnParent
                                                                             earthParent.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                             earthParent.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
        SaturnParent.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
        SaturnParent.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                                                             venusParent.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                                  venusParent.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                                                           //  let frame = self.sceneView.session.currentFrame
                                                                           //  let frame = self.sceneView.
                                                                             // let mat = SCNMatrix4(frame.camera.transform)
                                                                                     for index in 0...2 {
                                                                                        
                                                                                         var Shoonode = SCNNode()
                                                                                 
                                                                                         //make it to where it dont kill so many
                                                                                     //var ShoonodeSec = SCNNode()
                                                                                         // var ShoonodeCloserEarP = SCNNode()
                                                                     //                     let earthParent = SCNNode()
                                                                                                       var ssShoonode = SCNNode()
                                                                                                     var ssThShoonode = SCNNode()
                                                                                                     var FourthShoonode = SCNNode()
                                                                                      var VenShoonode = SCNNode()
                                                                                                                   //make it to where it dont kill so many
                                                                                                               //var ShoonodeSec = SCNNode()
                                                                                                                   // var ShoonodeCloserEarP = SCNNode()
                                                                                               //                     let earthParent = SCNNode()
                                                                                                                                 var VenssShoonode = SCNNode()
                                                                                                                               var VenssThShoonode = SCNNode()
                                                                                                                               var VenFourthShoonode = SCNNode(
                                                                                    )
                                                                                        
                                                                                        //sa********
                                                                                                                                                var SaShoonode = SCNNode()
                                                                                                                                                                              
                                                                                                                                                                                                                            var SAssShoonode = SCNNode()
                                                                                                                                                                                                                          var SassThShoonode = SCNNode()
                                                                                                                                                                                                                          var SaFourthShoonode = SCNNode()
                                                                     //frts one!!!
                                                                                         let SpaceShscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                                                 ssShoonode = (SpaceShscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                                                  ssShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                       //  ssShoonode.
                                                                                         ssShoonode.name = "shark"
                                                                                         //second one
                                                                                         
                                                                                         let Spacehscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                                                 ssThShoonode = (Spacehscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                                                  ssThShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                         ssThShoonode.name = "shark"
                                                                                         // third one
                                                                                         
                                                                                         let SpacehFscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                                                                    FourthShoonode = (SpacehFscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                                                                     FourthShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                            FourthShoonode.name = "shark"
                                                                                      
                                                                                      
                                                                                      
                                                                                      //Ven
                                                                                      let SpaceShscenee = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                                                                            VenShoonode = (SpaceShscenee?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                                                                             VenShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                                  //  ssShoonode.
                                                                                                                    VenShoonode.name = "shark"
                                                                                                                    //second one
                                                          //                                                          var VenssShoonode = SCNNode()
                                                                                      
                                                                                      let Spacehscenev = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                                                                          VenssThShoonode = (Spacehscenev?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                                                                           VenssThShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                                  VenssThShoonode.name = "shark"
                                                          //                                                                                                                              var VenssThShoonode = SCNNode()
                                                          //                                                                                                                              var VenFourthShoonode = SCNNode()
                                                                                      
                                                                                                                    let Spacehscener = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                                                                            VenssShoonode  = (Spacehscener?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                                                                             VenssShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                                    VenssShoonode .name = "shark"
                                                                                                                    // third one
                                                                                                                    
                                                                                                                    let SpacehFscenea = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                                                                                               VenFourthShoonode = (SpacehFscenea?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                                                                                                VenFourthShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                                                       VenFourthShoonode.name = "shark"
                                                                                        
                                                                                         //sa
                                                                                        let SpaceShscenezn = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                                                                                         SaShoonode = (SpaceShscenezn?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                                                                                             SaShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                                                                                                                                               //  ssShoonode.
                                                                                                                                                             SaShoonode.name = "shark"
                                                                                                        let SpaceShscenez = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                                        SAssShoonode = (SpaceShscenez?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                                            SAssShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                                                                                              //  ssShoonode.
                                                                                                            SAssShoonode.name = "shark"
                                                                                                                                                                                //second one
                                                                                                                                                                               // SassShoonode SassShoonode
                                                                                                       let Spacehscenec = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                            SassThShoonode = (Spacehscenec?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                                            SassThShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                                ssThShoonode.name = "shark"
                                                                                                                                                                                // third one
                                                                                                                                                                                
                                                                                                let SpacehFscenem = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                        SaFourthShoonode = (SpacehFscenem?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                                    SaFourthShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                                            SaFourthShoonode.name = "shark"
                                                                                        
                                                                                        
                                                                                        
                                                                                         

                                                                                             let moonParent = SCNNode()
                                                                           
                                                                                        if (index > 1) && (index % 2 == 0) {
                                                                                    
                                                                                         
                                                                                         
                                                                                           let scene = SCNScene(named: "art.scnassets/spaceGreen.scn")
                                                                                                                                            Shoonode = (scene?.rootNode.childNode(withName: "spaceGreenn", recursively: true)!)!
                                                                                                                       Shoonode.scale = SCNVector3(0.03,0.03,0.03)
                                                                                                                      Shoonode.name = "shark"
                                                                                          
                                                                                          let scenee = SCNScene(named: "art.scnassets/spaceGreen.scn")
                                                                                                                                                                         VenShoonode = (scenee?.rootNode.childNode(withName: "spaceGreenn", recursively: true)!)!
                                                                                                                                                      VenShoonode.scale = SCNVector3(0.03,0.03,0.03)
                                                                                                                                                     VenShoonode.name = "shark"
                                                                                            //sa
                                                                                                                                                  let scenell = SCNScene(named: "art.scnassets/spaceGreen.scn")
                                                                                                       SaShoonode = (scenell?.rootNode.childNode(withName: "spaceGreenn", recursively: true)!)!
                                                                                                                                                                                                                                   
                                                                                                                   SaShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                                   SaShoonode.name = "ha"
                                                                                          
                                                                                                   }else{
                                                               
                                                                                        let scene = SCNScene(named: "art.scnassets/missilecopy.scn")
                                                                                                                         Shoonode = (scene?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
                                                                                                                          Shoonode.scale = SCNVector3(0.03,0.03,0.03)
                                                                                                                          Shoonode.name = "SS1copy.scn"
                                                                                          
                                                                                          let scenee = SCNScene(named: "art.scnassets/missilecopy.scn")
                                                                                                                                                       VenShoonode = (scenee?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
        VenShoonode.scale = SCNVector3(0.03,0.03,0.03)
                VenShoonode.name = "SS1copy.scn"
                                                                                                   }
    let sceneb = SCNScene(named: "art.scnassets/missilecopy.scn")
                                                                                                           SaShoonode = (sceneb?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
            SaShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                                   SaShoonode.name = "SS1copy.scn"
                                                                                        
                                                                                         Shoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                                            Shoonode.physicsBody?.isAffectedByGravity = false
                                                             
                                                                                         Shoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                      Shoonode.physicsBody?.isAffectedByGravity = false
                                                                                      ssThShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                                                                      ssThShoonode.physicsBody?.isAffectedByGravity = false
                                                                                                             
                                                                                                                  
                                                                                                                               
                                                                                                            ssShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                                                              ssShoonode.physicsBody?.isAffectedByGravity = false
                                                                                         FourthShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                                                                                FourthShoonode.physicsBody?.isAffectedByGravity = false

                                                                                        VenShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                                           VenShoonode.physicsBody?.isAffectedByGravity = false
                                                                                      //  ShoonodeSec.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                                           //ShoonodeSec.physicsBody?.isAffectedByGravity = false
                                                                                        VenShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                                                              //Shoonode.physicsBody?.isAffectedByGravity = false
                                                                                                           VenssShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                                                             VenssShoonode.physicsBody?.isAffectedByGravity = false
                                                                                        VenFourthShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                                                                               VenFourthShoonode.physicsBody?.isAffectedByGravity = false
                                                                                      VenssThShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                                                                                          VenssThShoonode.physicsBody?.isAffectedByGravity = false
                                                                                        SaShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                                                            SaShoonode.physicsBody?.isAffectedByGravity = false
                                                                                                                                                                               
                                                                                                                   
                                                                                                                    SassThShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                                                    SassThShoonode.physicsBody?.isAffectedByGravity = false
                                                                                                                                                                                                            
                                                                                                                    SAssShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                                                   SAssShoonode.physicsBody?.isAffectedByGravity = false
                                                                                                                    SaFourthShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                                                    SaFourthShoonode.physicsBody?.isAffectedByGravity = false
                                                                                                                                                 

                                                                                    //    venusParent.addChildNode(Shoonode)
                                                                                         earth.addChildNode(Shoonode)
                                                                                    //  earth.addChildNode(ShoonodeG)
                                                                                             earth.addChildNode(ssShoonode)
                                                                                                             earth.addChildNode(ssThShoonode)
                                                                                                             earth.addChildNode(FourthShoonode)
                                                                                      
                                                                                      saturn.addChildNode(SaShoonode)
                                                                                                             saturn.addChildNode(SAssShoonode)
                                                                                                             saturn.addChildNode(SassThShoonode)
                                                                                        saturn.addChildNode(SaFourthShoonode)
                                                                                      venus.addChildNode(VenShoonode)
                                                                                      // venusParent.addChildNode(VenShoonodeG)
                                                                                                                        venus.addChildNode(VenssShoonode)
                                                                                                                                        venus.addChildNode(VenssThShoonode)
                                                                                                                                        venus.addChildNode(VenFourthShoonode)
                                                                     //                     earth.name = "earth"
                                                                     //                    earthParent.name = "earthParent"
                                                                                       //  earth.addChildNode(ShoonodeSec)
                                                                                         nodeArray.append(Shoonode)
                                                                                      //   nodeArray.append(ShoonodeSec)
                                                                                         ThirdGroupNodeArray.append(FourthShoonode)
                                                                                        SSnodeArray.append(ssShoonode)
                                                                                         SecGroupNodeArray.append(ssThShoonode)
                                                                                         EarGroupNodeArray.append(earth)
                                                                                         EarGroupNodeArray.append(earthParent)
                                                                                      nodeArray.append(VenShoonode)
                                                                                                                //   nodeArray.append(ShoonodeSec)
                                                                                        //sa*
                                                                                                                                                 nodeArray.append(SaShoonode)
                                                                                                                                                ThirdGroupNodeArray.append(SaFourthShoonode)
                                                                                                                                                SSnodeArray.append(SAssShoonode)
                                                                                                                                                 SecGroupNodeArray.append(SassThShoonode)
                                                                                                                   ThirdGroupNodeArray.append(VenFourthShoonode)
                                                                                                                  SSnodeArray.append(VenssShoonode)
                                                                                                                   SecGroupNodeArray.append(VenssThShoonode)
                                                                                                                   EarGroupNodeArray.append(earth)
                                                                                                                   EarGroupNodeArray.append(earthParent)
                                                                                      Shoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.9), randomFloat(min: 0.1, max: 0.5))
                                                                                                                 
                                                                                                              
                                                                                                              //changed this one!!!
                                                                                                              ssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.3), randomFloat(min: -0.8, max: 0.8))
                                                                                                              
                                                                                                              
                                                                                                     
                                                                                                              ssThShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.5))
                                                                                                               FourthShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.9), randomFloat(min: 0.1, max: 0.7))
                                                                                                              
                                                                       //sa
                                                                                        SaShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.3), randomFloat(min: -0.8, max: 0.9))
                                                                                        SAssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.3), randomFloat(min: -0.8, max: 0.9))
                                                                                                                                                                                                       
                                                                                        SassThShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                                                                                        SaFourthShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                                                                                         

                                                                  //ven
                                                                                       VenShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.9),randomFloat(min: -0.8, max: 0.9), randomFloat(min: 0.1, max: 0.5))
                                                                                     //  VenShoonodeG.position = SCNVector3(randomFloat(min: -0.8, max: 0.9),randomFloat(min: -0.8, max: 0.9), randomFloat(min: 0.1, max: 0.9))
                                                                                                                                                                                       
                                                                                                                                                                                    
                                                                                                                                                                                    //changed this one!!!
                                                                                          VenssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.9), randomFloat(min: -0.8, max: 0.9))
                                                                                                                                                                                    
                                                                                                                                                                                    
                                                                                                                                                                           
                                                                                      VenssThShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.9), randomFloat(min: 0.1, max: 0.9))
                                                                                          VenFourthShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                                                                                                                          
                                                                                      
                                                                                      
                                                                                               // moonParent.position = SCNVector3(0 ,0 , -1)
                                                                                        
                                                                                         Shoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                                               Shoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                                                                      
                                                                                         ssShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                                                                                  ssShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                                                                         ssThShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                  ssThShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                                                                          FourthShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                  FourthShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                                                                      VenShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                  VenShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                                                                                                 
                                                                  VenssShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                                                                                                             VenssShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                                                      VenssThShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                  VenssThShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                                              VenFourthShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                              VenFourthShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                                                                SAssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.3), randomFloat(min: -0.8, max: 0.9))
                                                                                        SaShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.3), randomFloat(min: -0.8, max: 0.9))
                                                                                                        
                                                                                SassThShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                                                                                SaFourthShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                                                                                                self.sceneView.scene.rootNode.addChildNode(venusParent)

                                                                                                self.sceneView.scene.rootNode.addChildNode(Shoonode)
                                                                                        //self.sceneView.scene.rootNode.addChildNode(saturn)
                                                                                        self.sceneView.scene.rootNode.addChildNode(SaturnParent)
                                                                                                  self.sceneView.scene.rootNode.addChildNode(SaturnParentSun)
                                                                                                 self.sceneView.scene.rootNode.addChildNode(SaShoonode)
                                                                                                                               self.sceneView.scene.rootNode.addChildNode(SAssShoonode)
                                                                                                                               self.sceneView.scene.rootNode.addChildNode(SassThShoonode)
                                                                                                                           self.sceneView.scene.rootNode.addChildNode(SaFourthShoonode)
                                                                                    //  self.sceneView.scene.rootNode.addChildNode(ShoonodeG)
                                                                                      self.sceneView.scene.rootNode.addChildNode(VenShoonode)
                                                                                      // self.sceneView.scene.rootNode.addChildNode(VenShoonodeG)
                                                                                        
                                                                                      self.sceneView.scene.rootNode.addChildNode(earthParent)
                                                                                      self.sceneView.scene.rootNode.addChildNode(sun)
                                                                                       self.sceneView.scene.rootNode.addChildNode(venusParentSun)//self.sceneView.scene.rootNode.addChildNode(ShoonodeSec)
                                                                                         self.sceneView.scene.rootNode.addChildNode(ssShoonode)
                                                                                           self.sceneView.scene.rootNode.addChildNode(ssThShoonode)
                                                                                          self.sceneView.scene.rootNode.addChildNode(FourthShoonode)
                                                                                      self.sceneView.scene.rootNode.addChildNode(VenssShoonode)
                                                                                                                     self.sceneView.scene.rootNode.addChildNode(VenssThShoonode)
                                                                                                                    self.sceneView.scene.rootNode.addChildNode(VenFourthShoonode)

                                                                        

                                                                                                 //  let SecRotation = XRotation(time: 300)
                                                                                //  let SecRo = XRotation(time: 2)
                                                //let JRRotation = Rotation(time: 5)
                                                                                                                                  let GreenSecRo = XRotation(time: 4)
                                                                                                                                                                 let JRRotation = Rotation(time: 5)
                                                                                        
                                                                                      let sunAction = Rotation(time: 29)
                                                                                    //let venusRotation = Rotation(time: 9)                               // complete level 9 JRotation = Rotation(time: 15)
                                            //let sunActionS = Rotation(time: 12)
                                                                                                                                                   
                                                                                                                                                   
                                                                              let sunActionVenus = Rotation(time: 30)
                                        //let sunActionNep = Rotation(time: 13)
                                    ///let sunActionJ = Rotation(time: 11)
                                    //let sunActionEar = Rotation(time: 12)
                                    //let earthParentRotation = Rotation(time: 20)
                                    //let VRotation = Rotation(time: 15)
                                    //let venusParentRotation = XRotation(time: 30)
                                    //let earthRotation = Rotation(time: 30)
                                                                                              let moonRotation = Rotation(time: 10)
                                                                                        //  let venusRotation = Rotation(time: 9)
                                    //let JupRotation = Rotation(time: 8)
                                                                                                                                                     let JRotation = Rotation(time: 15)
                                                                     Shoonode.runAction(GreenSecRo)
                                                                                      
                                                                                                                      //                  //  ShoonodeSec.runAction(SecRotation)
                                                                                        //Sa
                                                                                                                                           SaShoonode.runAction(GreenSecRo)
                                                                                                                                                                                //                  //  ShoonodeSec.runAction(SecRotation)
                                                                                                                                                                                                   SAssShoonode.runAction(GreenSecRo)
                                                                                                                                                                                                 
                                                                                                                                                                                //                    //FourthShoonode
                                                                                                                                                                                                   SassThShoonode.runAction(GreenSecRo)
                                                                                                                                                                                                    SaFourthShoonode.runAction(GreenSecRo)
                                                                      ssShoonode.runAction(GreenSecRo)
                                                                                                                                    
                                                                                                                      //                    //FourthShoonode
                                                                      ssThShoonode.runAction(GreenSecRo)
                                                                                                  FourthShoonode.runAction(GreenSecRo)
                                                                                         venusParentSun.runAction(sunActionVenus)
                                                                                      //Ven added
                                                                                      VenShoonode.runAction(GreenSecRo)
                                                                                                                                               //                  //  ShoonodeSec.runAction(SecRotation)
                                                                                                  VenssShoonode.runAction(GreenSecRo)
                                                                                       
                                                                                                                                               //                    //FourthShoonode
                                                                                          VenssThShoonode.runAction(GreenSecRo)
                                                                                      VenFourthShoonode.runAction(GreenSecRo)
                                                                                      
                                                                                      
                                                                     //                        ssThShoonode
                                                                                                earthParent.runAction(JRotation)
                                                                                                venusParent.runAction(JRotation)
                                                                              
                                                                                                moonParent.runAction(moonRotation)
                                                                                               venus.runAction(JRRotation)
                                                                                                 //venusParent.addChildNode(venus)
                                                                                              
                                                                                      //stable rotations
                                                                                      sun.runAction(sunAction)
                                                                                        earth.runAction(JRRotation)
                                                                                      //figured out how distribute ships will have to create more Shoonodes
                                                                                      //can be elaborate with given planets diff rotations since its
                                                                                      sun.addChildNode(earth)
                                                                                       sun.addChildNode(earthParent)
                                                                                      //venusParent.addChildNode(venus)
                                                                                      venusParentSun.addChildNode(venusParent)
                                                                                      //added venus and planets
                                                                                      venusParentSun.addChildNode(venus)
                                                                                      
                                                                                      earth.addChildNode(ssShoonode)
                                                                                         earth.addChildNode(Shoonode)
                                                                                       //  ssThShoonode.addChildNode(ssShoonode)
                                                                                         earth.addChildNode(ssThShoonode)
                                                                                         earth.addChildNode(FourthShoonode)
                                                                                      
                                                                                      venus.addChildNode(VenssShoonode)
                                                                                      venus.addChildNode(VenShoonode)
                                                                                                                  //  ssThShoonode.addChildNode(ssShoonode)
                                                                                                                    venus.addChildNode(VenssThShoonode)
                                                                                                                    venus.addChildNode(VenFourthShoonode)
                                                                                             SaturnParentSun.runAction(sunAction)
                                                                                                                SaturnParent.runAction(JRRotation)
                                                                                                                SaturnParentSun.addChildNode(SaturnParent)
                                                                                                            SaturnParentSun.addChildNode(saturn)
                                                                                        
                                                                      saturn.runAction(JRRotation)
                                                                                        //saturn.runAction(JRRotation)
                                                                                        saturn.addChildNode(saturnRing)
                                                                                                        saturn.addChildNode(SAssShoonode)
                                                                                                    SaturnParent.addChildNode(SaShoonode)
                                                                                                                                                                                                    //  ssThShoonode.addChildNode(ssShoonode)
                                                                                        SaturnParent.addChildNode(SassThShoonode)
                                                                                            SaturnParent.addChildNode(SaFourthShoonode)
                                                                                                //earthParent.addChildNode(moonParent)
                                                                                         //earth.addChildNode(moon)
                                                                                           //   moonParent.addChildNode(moon)
                                                                     //                    for n in SSnodeArray {
                                                                     //                        print("\(n.name) jessss")
                                                                     //                    }
                                                                             
                                                                                     }
                          }
    
    func addTargetNodesNeptune(){
           playBackgroundMusic()
       
                     // let JupitarRing = createRing(ringSize: 0.3)
                                                   // let jupiter = createPlanet(radius: 0.33, image: "jupiter")
                                                         //      jupiter.name = "zoom"
                                                 //  jupiter.position = SCNVector3(x:1.6 , y: 0, z: 0)
                                                   // rotateObject(rotation: 0.01, planet:  jupiter, duration: 0.4)
                                                   // rotateObject(rotation: 0.01, planet: JupitarRing, duration: 1)
                                        
                                        let neptuneRing = createRing(ringSize: 0.3)
                                               let neptune = createPlanet(radius: 0.2, image: "neptune")
                                               neptune.name = "neptune"
                                               neptune.position = SCNVector3(x:1.6 , y: 0, z: 0)
                                               rotateObject(rotation: 0.01, planet: neptune, duration: 0.4)
                                               rotateObject(rotation: 0.01, planet: neptuneRing, duration: 1)
                                        
                                            //radius: 0.1
                                                  let sphere = SCNSphere(radius: 0.1)
                              // let material = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "Venus Surface"), specular: nil, emission: #imageLiteral(resourceName: "Venus Atmosphere"), normal: nil, position: SCNVector3(0.5, 0, 0))
                              //#imageLiteral(resourceName: "Venus Surface")
                               let material = SCNMaterial()
                               material.diffuse.contents = UIImage(named: "Venus Surface")
                             // material.diffuse.contents = #imageLiteral(resourceName: "Venus Surface")
                              sphere.materials = [material]
                                                let venusParent = SCNNode(geometry: sphere)
                                               //   let JupitarParent = SCNNode()
                                                let venusParentSun = SCNNode()
                              let neptuneParent = SCNNode()
                                                let SaturnParent = SCNNode()
                                        
                                               
        AllnodeArray.removeAll()
        EarGroupNodeArray.removeAll()
        
                                            let SaturnParentSun = SCNNode()
                                            let neptuneParentSun = SCNNode()
                             //  let JupitarParentSun = SCNNode()
                                               SaturnParentSun.position = SCNVector3(0,0,-1)
                                    //  JupitarParentSun.position = SCNVector3(0,0,-1)
                                          neptuneParentSun.position = SCNVector3(0,0,-1)
                                                          venusParentSun.position = SCNVector3(0,0,-1)
                                                                                               let sun = SCNNode(geometry: SCNSphere(radius: 0.25))
                                                              sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Sun diffuse")
                                                                     sun.position = SCNVector3(0,0,-1)
        
                                            sun.name = "earthQJ"
                                                                       let earthParent = SCNNode()
                                                                  let moonParent = SCNNode()
                                                                 
                                                                     let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.8 ,0 , 0))
                                               let saturnRing = createRing(ringSize: 0.3)
                                                     let saturn = createPlanet(radius: 0.2, image: "saturn")
                                                     saturn.name = "earthQJ"
                                               saturn.position = SCNVector3(2.5,0,0)
                                                     rotateObject(rotation: 0.1, planet: saturn, duration: 0.4)
                                                     rotateObject(rotation: 0.1, planet: saturnRing, duration: 1)
                      //                                     let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "Venus Surface"), specular: nil, emission: #imageLiteral(resourceName: "Venus Atmosphere"), normal: nil, position: SCNVector3(0.5, 0, 0))
                                                                    let moon = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "moon Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0,0,-0.3))
                                                    moon.name = "earthQJ"
                                                                  //   venusParent
                                                                      earth.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                         earth.physicsBody?.isAffectedByGravity = false
                                                                      earthParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                         earthParent.physicsBody?.isAffectedByGravity = false

                                                                     
                                                                     
                                                                     
                                                                    // venusParent
                                                                     venusParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                               venusParent.physicsBody?.isAffectedByGravity = false
                                                                       //  venusParent.position = SCNVector3(0,0,-1)
                                                                      
                                                                     // venusParent.name = "earth"
                                                             //         earth.addChildNode(Shoonode)
                              //decent rotations, maybe some could be closer. Fixed bugs with music and ships ending game!
                                                                     //
        
        
                                                                     earN = earthParent
                                                                       earth.name = "earthQJ"
                                                                      earthParent.name = "earthQJ"
                                                          //where the relationships between earth and earthParent
                              //perfect distance of planets
                              earth.position = SCNVector3(1.8,0,0)
                              earthParent.position = SCNVector3(1.8,0,0)
                                                //better rotations..nice positions
                                               saturn.position = SCNVector3(-2.5,0,0)
                                               SaturnParent.position = SCNVector3(-2.5,0,0)
                              neptune.position = SCNVector3(0,0,3.5)
                              neptuneParent.position = SCNVector3(0,0,3.5)
                                neptune.name = "earthQJ"
//                              jupiter.position = SCNVector3(0,0,-2.9)
//                              JupitarParent.position = SCNVector3(0,0,-2.9)
                      //        venusParent.position = SCNVector3(0,0,1.2)
                      //        venus.position = SCNVector3(0,0,1.2)
                              
                                            moonParent.position = SCNVector3(1.2 ,0 , 0)
                                        earth.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                earth.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                                earthParent.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                earthParent.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                      //                      venusParent.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                      //                          venusParent.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                                          sun.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                   sun.physicsBody?.isAffectedByGravity = false
                                                                   sun.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                             sun.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
        neptune.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                          neptune.physicsBody?.isAffectedByGravity = false
                                                                          neptune.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                                    neptune.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
        
                                            for index in 0...1 {
                                                autoreleasepool {
                                                              //ear***
                                                    var Shoonode = SCNNode()
                                                                     
                                                    var ssShoonode = SCNNode()
                                                    var ssThShoonode = SCNNode()
                                                    var FourthShoonode = SCNNode()
                                                                               //ven******
                      //                                      var VenShoonode = SCNNode()
                      //
                      //                                          var VenssShoonode = SCNNode()
                      //                                                                                                 var VenssThShoonode = SCNNode()
                      //                                                                                                 var VenFourthShoonode = SCNNode()
                                                                               //sa********
                                                                               var SaShoonode = SCNNode()
                                                                                                             
                                                                                                                                                           var SAssShoonode = SCNNode()
                                                                                                                                                         var SassThShoonode = SCNNode()
                                                                                                                                                         var SaFourthShoonode = SCNNode()
                                                      //nep******
                                              var NepShoonode = SCNNode()
                                                                                                                  
                                              var NepssShoonode = SCNNode()
                                          var NepssThShoonode = SCNNode()
                                          var NepFourthShoonode = SCNNode()
                                              
                                              //Jup
//                                              var JupShoonode = SCNNode()
//
//                                                                           var JupssShoonode = SCNNode()
//                                                                           var JupssThShoonode = SCNNode()
//                                                                           var JupFourthShoonode = SCNNode()
                                              
                                              
                                                             //ear
                                                                                 let SpaceShscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                                         ssShoonode = (SpaceShscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                                          ssShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                               //  ssShoonode.
                                                                                 ssShoonode.name = "shark"
                                                                                 //second one
                                                                                 
                                                                                 let Spacehscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                                         ssThShoonode = (Spacehscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                                          ssThShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                 ssThShoonode.name = "shark"
                                                                                 // third one
                                                                                 
                                                                                 let SpacehFscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                                                            FourthShoonode = (SpacehFscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                                                             FourthShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                    FourthShoonode.name = "shark"
                                                                              
                                                                              
                                                                              
                                                                              //Ven
                                             //                                 let SpaceShscenee = SCNScene(named: "art.scnassets/SS1copy.scn")
                      //                                                                                                              VenShoonode = (SpaceShscenee?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                                                                     //VenShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                          //  ssShoonode.
                                                                                                            //VenShoonode.name = "shark"
                                                                                                            //second one
                                                  //                                                          var VenssShoonode = SCNNode()
                                                                              
                                               //                               let Spacehscenev = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                                                                  //VenssThShoonode = (Spacehscenev?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                                                                   //VenssThShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                          //VenssThShoonode.name = "shark"
                                                  //                                                                                                                              var VenssThShoonode = SCNNode()
                                                  //                                                                                                                              var VenFourthShoonode = SCNNode()
                                                                              
                                                                                                            //let Spacehscener = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                                                                    //VenssShoonode  = (Spacehscener?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                                                                     //VenssShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                            //VenssShoonode .name = "shark"
                                                                                                            // third one
                                                                                                            
                                                                                                            //let SpacehFscenea = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                                                                                       //VenFourthShoonode = (SpacehFscenea?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                                                                                        //VenFourthShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                                               //VenFourthShoonode.name = "shark"
                                                                               //sa
                                          let SpaceShscenez = SCNScene(named: "art.scnassets/SS1copy.scn")
                                          SAssShoonode = (SpaceShscenez?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                              SAssShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                                //  ssShoonode.
                                              SAssShoonode.name = "shark"
                                                                                                                  //second one
                                                                                                                 // SassShoonode SassShoonode
                                         let Spacehscenec = SCNScene(named: "art.scnassets/SS1copy.scn")
                              SassThShoonode = (Spacehscenec?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                              SassThShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                  ssThShoonode.name = "shark"
                                                                                                                  // third one
                                                                                                                  
                                  let SpacehFscenem = SCNScene(named: "art.scnassets/SS1copy.scn")
                          SaFourthShoonode = (SpacehFscenem?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                      SaFourthShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                              SaFourthShoonode.name = "shark"
                                                                                                               
                                                                                 //nep*****
                                  let SpaceShscenef = SCNScene(named: "art.scnassets/SS1copy.scn")
                                          NepssShoonode = (SpaceShscenef?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                          NepssShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                                             //  ssShoonode.
                                                                                                                               NepssShoonode.name = "shark"
                                                                                                                               //second one
                                                                                                                               
                                                                        let Spacehscenelk = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                    NepssThShoonode = (Spacehscenelk?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                    NepssThShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                            NepssThShoonode.name = "shark"
                                                                                                                               // third one
                                                                                                                               
                                                                                let SpacehFsceneg = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                NepFourthShoonode = (SpacehFsceneg?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                    NepFourthShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                            NepFourthShoonode.name = "shark"
                                              
                                              
                                              


                                                                                     let moonParent = SCNNode()
                                                                   
                                                                                if (index > 1) && (index % 1 == 0) {
                                                                            
                                                                                 
                                                                                 //ear
                                                  let scene = SCNScene(named: "art.scnassets/spaceGreen.scn")
                                          Shoonode = (scene?.rootNode.childNode(withName: "spaceGreenn", recursively: true)!)!
                                                      Shoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                              Shoonode.name = "shark"
                                                                                  //Ven
                      //                                                            let scenee = SCNScene(named: "art.scnassets/spaceARcopy.scn")
                      //                                                                                                                       VenShoonode = (scenee?.rootNode.childNode(withName: "SS1redcopy", recursively: true)!)!
                      //                                                                                                                        VenShoonode.scale = SCNVector3(0.02,0.02,0.02)
                      //                                                                                                                       VenShoonode.name = "shark"
                                                                                   //sa
                                                                             let scenell = SCNScene(named: "art.scnassets/spaceGreen.scn")
                                  SaShoonode = (scenell?.rootNode.childNode(withName: "spaceGreenn", recursively: true)!)!
                                                                                                                                                              
                                              SaShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                              SaShoonode.name = "shark"
                                                                                  //nep
                                              let scenenn = SCNScene(named: "art.scnassets/spaceGreen.scn")
                                                  NepShoonode = (scenenn?.rootNode.childNode(withName: "spaceGreenn", recursively: true)!)!
                                                                                                                                                               
                                                                  NepShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                                                                                                                        NepShoonode.name = "shark"
                                                                                  
                                                                                  
//                                                  let scenennk = SCNScene(named: "art.scnassets/spaceGreen.scn")
//                                      JupShoonode = (scenennk?.rootNode.childNode(withName: "spaceGreenn", recursively: true)!)!
//
//                                              JupShoonode.scale = SCNVector3(0.02,0.02,0.02)
//                                                                                                                                                                                                                                                                   JupShoonode.name = "ha"
//
                                                                                                                          
                                                                                  
                                                                                           }else{
                                                                                  //ear
                                                  let scene = SCNScene(named: "art.scnassets/missilecopy.scn")
                                  Shoonode = (scene?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
                                                                          Shoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                                  Shoonode.name = "shark"
                      //                                                            //ven
                      //                                                            let scenee = SCNScene(named: "art.scnassets/missilecopy.scn")
                      //                                                                                                                         VenShoonode = (scenee?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
                      //                                                                                                                          VenShoonode.scale = SCNVector3(0.02,0.02,0.02)
                      //                                                                                                                          VenShoonode.name = "SS1copy.scn"
                                                                                   //sa
                                                      let sceneb = SCNScene(named: "art.scnassets/missilecopy.scn")
                                          SaShoonode = (sceneb?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
                                          SaShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                  SaShoonode.name = "shark"
                                                          //nep
                                              let scenebn = SCNScene(named: "art.scnassets/missilecopy.scn")
                                  NepShoonode = (scenebn?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
                                  NepShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                              NepShoonode.name = "shark"
                                                                                  
                                                                                  
                                                                                  
                                                                                  
//                              let scenebe = SCNScene(named: "art.scnassets/missilecopy.scn")
//                              JupShoonode = (scenebe?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
//                              JupShoonode.scale = SCNVector3(0.02,0.02,0.02)
//                                                                                                                                                                                                                   JupShoonode.name = "SS1copy.scn"
                                                                                           }
                                                                                 
                                                                                
                                                                                 Shoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                                    Shoonode.physicsBody?.isAffectedByGravity = false
                                                              
                                                                                 Shoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                              Shoonode.physicsBody?.isAffectedByGravity = false
                                          ssThShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                          ssThShoonode.physicsBody?.isAffectedByGravity = false
                                                                                                     
                                                                                                          
                                                                                                                       
                          ssShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                              ssShoonode.physicsBody?.isAffectedByGravity = false
                              FourthShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                                                                        FourthShoonode.physicsBody?.isAffectedByGravity = false
                      
                                                           SaShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                           SaShoonode.physicsBody?.isAffectedByGravity = false
                                                                                                              
                                                  
                                                   SassThShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                   SassThShoonode.physicsBody?.isAffectedByGravity = false
                                                                                                                                           
                                                   SAssShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                  SAssShoonode.physicsBody?.isAffectedByGravity = false
                                                   SaFourthShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                   SaFourthShoonode.physicsBody?.isAffectedByGravity = false
                                                                                
                                                                                //nep
                                                                                
                                                      NepShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                      NepShoonode.physicsBody?.isAffectedByGravity = false
                                                  NepssThShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                    //  SassThShoonode.physicsBody?.isAffectedByGravity = false
                                                                                                                                                                                          
                                                  NepssShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                      NepssShoonode.physicsBody?.isAffectedByGravity = false
                                                      NepFourthShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                      NepFourthShoonode.physicsBody?.isAffectedByGravity = false
                                                                                
                                                                                //end
                                                                            //    venusParent.addChildNode(Shoonode)
                                      earth.addChildNode(Shoonode)
                                          earth.addChildNode(ssShoonode)
                                                      earth.addChildNode(ssThShoonode)
                                                  earth.addChildNode(FourthShoonode)
                                                                              //VEN
                                                                            
                      //                                                        venus.addChildNode(VenShoonode)
                      //                                                                                          venus.addChildNode(VenssShoonode)
                      //                                                                                                          venus.addChildNode(VenssThShoonode)
                      //                                                                                                          venus.addChildNode(VenFourthShoonode)
                                                      //Sa
                                                                         
                                              saturn.addChildNode(SaShoonode)
                                              saturn.addChildNode(SAssShoonode)
                                              saturn.addChildNode(SassThShoonode)
                                          saturn.addChildNode(SaFourthShoonode)
                                                                                //nep
                                                                               // neptune
                                                              neptune.addChildNode(NepShoonode)
                                                              neptune.addChildNode(NepssShoonode)
                                                      neptune.addChildNode(NepssThShoonode)
                                                          neptune.addChildNode(NepFourthShoonode)
                                              //Jupiter
//                                             jupiter.addChildNode(JupShoonode)
//                                             jupiter.addChildNode(JupssShoonode)
//                                          jupiter.addChildNode(JupssThShoonode)
//                                          jupiter.addChildNode(JupFourthShoonode)
                                                             //                     earth.name = "earth"
                                                             //                    earthParent.name = "earthParent"
                                                                               //  earth.addChildNode(ShoonodeSec)
                                                                                 AllnodeArray.append(Shoonode)
                                                                              //   nodeArray.append(ShoonodeSec)
                                                                                 AllnodeArray.append(FourthShoonode)
                                                                                AllnodeArray.append(ssShoonode)
                                                                                 AllnodeArray.append(ssThShoonode)
                                                                                 EarGroupNodeArray.append(earth)
                                                                                 EarGroupNodeArray.append(earthParent)

                                                                                                           EarGroupNodeArray.append(earth)
                                                                                                           EarGroupNodeArray.append(earthParent)
                                                                               //sa*
                                                                                AllnodeArray.append(SaShoonode)
                                                                               AllnodeArray.append(SaFourthShoonode)
                                                                               AllnodeArray.append(SAssShoonode)
                                                                                AllnodeArray.append(SassThShoonode)
                                                                               // EarGroupNodeArray.append(earth)
                                                                               // EarGroupNodeArray.append(earthParent)
                                                                                //nep*
                                                                                AllnodeArray.append(NepShoonode)
                                          AllnodeArray.append(NepFourthShoonode)
                                      AllnodeArray.append(NepssShoonode)
                                          AllnodeArray.append(NepssThShoonode)
                                      EarGroupNodeArray.append(neptune)
                                                                                                                             EarGroupNodeArray.append(neptuneParent)

                                              
                                              Shoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.9),randomFloat(min: -0.8, max: 0.9), randomFloat(min: 0.1, max: 0.5))
                                                                                         
                                                                                      
                                                                                      //changed this one!!!
                                          ssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.9), randomFloat(min: -0.8, max: 0.9))
                                                                                      
                                                                                      
                                                                             
                                          ssThShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                                              FourthShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                                                                                         
                                         
                                                                                                            
                                                                               //Sa
                                                                                 SaShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.9),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.5))
                                                                                                                                                
                                                                                                                                             
                                                                                                                                             //changed this one!!!
                              SAssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.3), randomFloat(min: -0.8, max: 0.9))
                                                                                                                                             
                              SassThShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                              SaFourthShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                                                                                //Nep
                                                    NepShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.9),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.5))
                                                                                                                                                                      
                                                                                                                                                                   
                                                                                                                                                                   //changed this one!!!
                                                   NepssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.3), randomFloat(min: -0.8, max: 0.9))
                                                                                                                                                                   
                                                    NepssThShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                                                    NepFourthShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                                                                                                   
                                                                                                                                               
                                                                                                                                               //changed this one!!!
                           
                                                                                                                                               
                                                                                                                                               
                                                                                                                                      
                          
                                        
                                                                                        moonParent.position = SCNVector3(0 ,0 , -1)
                                                                                
                                      Shoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                  Shoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                                                              
                                  ssShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                              ssShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                                  ssThShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                              ssThShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                              FourthShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                          FourthShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                             
                                                                               //sa****
                              SaShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                              SaShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                                                                                                   
                                  SAssShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                              SAssShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                              SassThShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                              SassThShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                          SaFourthShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                          SaFourthShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                                                                //nep
                            
                                                                  NepShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                              NepShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                                                                                        
                                                             NepssShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                         NepssShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                                                            NepssThShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                        NepssThShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                                         NepFourthShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                     NepFourthShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                                                        //Jup
                      //                        Jupitar
                                                                                        //self.sceneView.scene.rootNode.addChildNode(venusParent)
                                              //self.sceneView.scene.rootNode.addChildNode(JupitarParent)
                                                          self.sceneView.scene.rootNode.addChildNode(SaturnParent)
                                             
                                                          self.sceneView.scene.rootNode.addChildNode(neptuneParent)
                                                          self.sceneView.scene.rootNode.addChildNode(     neptuneParentSun)
                                                //self.sceneView.scene.rootNode.addChildNode(JupitarParentSun)
                                                                               // self.sceneView.scene.rootNode.addChildNode(neptune)
                                                                               
                                                          self.sceneView.scene.rootNode.addChildNode(SaturnParentSun)

                                                      self.sceneView.scene.rootNode.addChildNode(Shoonode)
                                                                            
                                                                                
                                                          self.sceneView.scene.rootNode.addChildNode(earthParent)
                                                          self.sceneView.scene.rootNode.addChildNode(sun)
                                                                               //self.sceneView.scene.rootNode.addChildNode(venusParentSun)//self.sceneView.scene.rootNode.addChildNode(ShoonodeSec)
                                                              self.sceneView.scene.rootNode.addChildNode(ssShoonode)
                                                          self.sceneView.scene.rootNode.addChildNode(ssThShoonode)
                                                          self.sceneView.scene.rootNode.addChildNode(FourthShoonode)
                      //                                                         //ven
                
                                                                                       //Sa
                                                                self.sceneView.scene.rootNode.addChildNode(SaShoonode)
                                                          self.sceneView.scene.rootNode.addChildNode(SAssShoonode)
                                                          self.sceneView.scene.rootNode.addChildNode(SassThShoonode)
                                                      self.sceneView.scene.rootNode.addChildNode(SaFourthShoonode)
                                                                                //Nep
                                                                               
                                                  self.sceneView.scene.rootNode.addChildNode(NepShoonode)
                                                      self.sceneView.scene.rootNode.addChildNode(NepssShoonode)
                                                  self.sceneView.scene.rootNode.addChildNode(NepssThShoonode)
                                                  self.sceneView.scene.rootNode.addChildNode(NepFourthShoonode)

                                                                                      //  let SecRotation = XRotation(time: 300)
                                                                                 //  let SecRo = XRotation(time: 2)
                                           //                                    let JRRotation = Rotation(time: 5)
                                                //got nep working
                                                                              
                                                                                           let sunAction = Rotation(time: 19)
                                              // complete level 9
                                    //           let sunActionS = Rotation(time: 12)
                                                                       
                                                    
                                                    
                                                    let GreenSecRo = XRotation(time: 4)
                                                    let JRRotation = Rotation(time: 5)
                                                                              
                                   //                           let sunActionVenus = Rotation(time: 25)
                                                      let sunActionSS = Rotation(time: 23)
                                //                  let sunActionJ = Rotation(time: 11)
                                  //            let sunActionEar = Rotation(time: 12)
                                            //              let earthParentRotation = Rotation(time: 20)
                                        //                                         let VRotation = Rotation(time: 15)
                                            //let venusParentRotation = XRotation(time: 30)
                                                          //   let earthRotation = Rotation(time: 30)
                                        let moonRotation = Rotation(time: 10)
                                                                              // let venusRotation = Rotation(time: 9)
                                               //                   let JupRotation = Rotation(time: 8)
                                                                              //  let JRotation = Rotation(time: 5)
                                                    
                                                       // Rotation(time: 5)
                                                                                                                                            Shoonode.runAction(GreenSecRo)
                                                                                                                        //                  //  ShoonodeSec.runAction(SecRotation)
                                                                                                                                           ssShoonode.runAction(GreenSecRo)
                                                                                                                                      
                                                                                                                        //                    //FourthShoonode
                                                                                                                                           ssThShoonode.runAction(GreenSecRo)
                                                                                                                                            FourthShoonode.runAction(GreenSecRo)
                                                                                                                                              
                                                                                                                                           //nep
                                                                                                                                           NepShoonode.runAction(GreenSecRo)
                                                                                                                                                                     //                  //  ShoonodeSec.runAction(SecRotation)
                                                                                                                                                                                         NepssShoonode.runAction(GreenSecRo)
                                                                                                                                                                                   
                                                                                                                                                                     //                    //FourthShoonode
                                                                                                                                                                                         NepssThShoonode.runAction(GreenSecRo)
                                                                                                                                                                                          NepFourthShoonode.runAction(GreenSecRo)
                                                                                                                                          //Sa
                                                                                                                                          SaShoonode.runAction(GreenSecRo)
                                                                                                                                                                               //                  //  ShoonodeSec.runAction(SecRotation)
                                                                                                                                                                                                  SAssShoonode.runAction(GreenSecRo)
                                                                                                                                                                                                
                                                                                                                                                                               //                    //FourthShoonode
                                                                                                                                                                                                  SassThShoonode.runAction(GreenSecRo)
                                                                                                                                                                                                   SaFourthShoonode.runAction(GreenSecRo)
                                                                                                                                         
                                                                                                                                         
                                                                                                                        //                        ssThShoonode
//                                                                                                         JupitarParentSun.runAction(sunAction)
                                                                                                                                          venusParentSun.runAction(sunAction)
                                                                                                                                                                              SaturnParentSun.runAction(sunAction)
                                                                                                         
                                                                                                         SaturnParentSun.runAction(sunAction)
                                                                                                         SaturnParent.runAction(JRRotation)
                                                                                                               saturn.runAction(JRRotation)
                                                                                                         SaturnParentSun.addChildNode(SaturnParent)
                                                                                                     SaturnParentSun.addChildNode(saturn)
                                                                                                 saturn.addChildNode(saturnRing)
                                                                                                 saturn.addChildNode(SAssShoonode)
                                                                                             SaturnParent.addChildNode(SaShoonode)
                                                                                                                                                                                             //  ssThShoonode.addChildNode(ssShoonode)
                                                                                 SaturnParent.addChildNode(SassThShoonode)
                                                                                     SaturnParent.addChildNode(SaFourthShoonode)
                                                                                                         
                                                                                                                                           neptuneParentSun.runAction(sunAction)
                                                                                                                                                   earthParent.runAction(JRRotation)
                                                                                                                                                 neptuneParent.runAction(JRRotation)
//                                                                                                                                         JupitarParent.runAction(JRRotation)
                                                                                                                                           SaturnParent.runAction(JRRotation)
                                                                                                                                                   venusParent.runAction(JRRotation)
                                                                                                                                                   moonParent.runAction(moonRotation)
                                                                                                             //all levels rotate right(ad mst load usall fast
                                                                                                                                                  //venus.runAction(venusRotation)
                                                                                                                                       neptune.runAction(JRRotation)
//                                                                                                                                         jupiter.runAction(JRRotation)
                                                                                                                                                    //venusParent.addChildNode(venus)
                                                                                                                                                   earth.runAction(JRRotation)
                                                                                                                                         sun.runAction(sunAction)
                                                                                                                                           neptune.addChildNode(neptuneRing)
                                                                                                                                           
                                                                                                                                                     
                                                                                                         
                                                                                                                                                     //Jupitar
                                                                                                         
//                                                                                                                                             sun.addChildNode(jupiter)
//                                                                                                                                         sun.addChildNode(JupitarParent)
                                                                                                            sun.addChildNode(neptuneParent)
                                                                                                             sun.addChildNode(neptune)
                                                                                                            sun.addChildNode(SaturnParent)
                                                                                                                                 sun.addChildNode(saturn)
                                                                                                             sun.addChildNode(earth)
                                                                                                                                                                    sun.addChildNode(earthParent)
                                                                                                             
//                                                                                                                                     jupiter.addChildNode(JupitarRing)
                                                                                                         
                                                                                                                                         //figured out how distribute ships will have to create more Shoonodes
                                                                                                                                         //can be elaborate with given planets diff rotations since its
                                                                                                                                       
                                                                                                                                         //venusParent.addChildNode(venus)
                                                                                                                                      //   venusParentSun.addChildNode(venusParent)
                                                                                                                                          
                                                                                                                                         //added venus and planets
                                                                                                                                      //   venusParentSun.addChildNode(venus)
                                                                                                                                       
                                                                                                                                           saturn.addChildNode(saturnRing)
                                                                                                                                          //ear
                                                                                                         //nep 100
                                                                                                                                         earth.addChildNode(ssShoonode)
                                                                                                                                            earthParent.addChildNode(Shoonode)
                                                                                                                                          //  ssThShoonode.addChildNode(ssShoonode)
                                                                                                                                            earthParent.addChildNode(ssThShoonode)
                                                                                                                                            earthParent.addChildNode(FourthShoonode)
                                                                                                                                     
                                                                                                                                          //sa
                                                                                                                                          saturn.addChildNode(SAssShoonode)
                                                                                                                                                                                SaturnParent.addChildNode(SaShoonode)
                                                                                                                                                                              //  ssThShoonode.addChildNode(ssShoonode)
                                                                                                                                                                                SaturnParent.addChildNode(SassThShoonode)
                                                                                                                                                                                SaturnParent.addChildNode(SaFourthShoonode)
                                                                                                                                          // nep //added neptune :))
                                                                                                                                           neptune.addChildNode(NepssShoonode)
                                                                                                                                            neptuneParent.addChildNode(NepShoonode)
                                                                                                                                         neptuneParent.addChildNode(NepssThShoonode)
                                                                                                                                           neptuneParent.addChildNode(NepFourthShoonode)
                                                                                                                                                   //earthParent.addChildNode(moonParent)
                                                                                                                                            earth.addChildNode(moon)
                                                                                                                                                 moonParent.addChildNode(moon)
                                                                                                                        //                    for n in SSnodeA
                                                             //                    for n in SSnodeArray {
                                                             //                        print("\(n.name) jessss")
                                                             //                    }
                                                                     
                              }
        }
    }
    
    
    
    
    func addTargetNodesJupitar(){
           playBackgroundMusic()
        
           
                          //Need message dont shoot moon.
                          //if so planet and moon destroyed
                   //Make ships move on dif speeds llke earlter
              let JupitarRing = createRing(ringSize: 0.3)
                              let jupiter = createPlanet(radius: 0.33, image: "jupiter")
        
                                         jupiter.name = "earthQJ"
                             jupiter.position = SCNVector3(x:1.6 , y: 0, z: 0)
                              rotateObject(rotation: 0.01, planet:  jupiter, duration: 0.4)
                              rotateObject(rotation: 0.01, planet: JupitarRing, duration: 1)
                  
                  let neptuneRing = createRing(ringSize: 0.3)
                         let neptune = createPlanet(radius: 0.2, image: "neptune")
                         neptune.name = "earthQJ"
                         neptune.position = SCNVector3(x:1.6 , y: 0, z: 0)
                         rotateObject(rotation: 0.01, planet: neptune, duration: 0.4)
                         rotateObject(rotation: 0.01, planet: neptuneRing, duration: 1)
                  
                      //radius: 0.1
                            let sphere = SCNSphere(radius: 0.1)
        // let material = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "Venus Surface"), specular: nil, emission: #imageLiteral(resourceName: "Venus Atmosphere"), normal: nil, position: SCNVector3(0.5, 0, 0))
        //#imageLiteral(resourceName: "Venus Surface")
        AllnodeArray.removeAll()
        EarGroupNodeArray.removeAll()
         let material = SCNMaterial()
         material.diffuse.contents = UIImage(named: "Venus Surface")
       // material.diffuse.contents = #imageLiteral(resourceName: "Venus Surface")
        sphere.materials = [material]
                          let venusParent = SCNNode(geometry: sphere)
                            let JupitarParent = SCNNode()
                          let venusParentSun = SCNNode()
        let neptuneParent = SCNNode()
                          let SaturnParent = SCNNode()
                  
                         
                      let SaturnParentSun = SCNNode()
                      let neptuneParentSun = SCNNode()
         let JupitarParentSun = SCNNode()
                         SaturnParentSun.position = SCNVector3(0,0,-1)
                JupitarParentSun.position = SCNVector3(0,0,-1)
                    neptuneParentSun.position = SCNVector3(0,0,-1)
                                    venusParentSun.position = SCNVector3(0,0,-1)
                                                                         let sun = SCNNode(geometry: SCNSphere(radius: 0.25))
                                        sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Sun diffuse")
                                               sun.position = SCNVector3(0,0,-1)
                                            sun.name = "earthQJ"
                                                 let earthParent = SCNNode()
                                            let moonParent = SCNNode()
                                           
                                               let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.8 ,0 , 0))
                         let saturnRing = createRing(ringSize: 0.3)
                               let saturn = createPlanet(radius: 0.2, image: "saturn")
                               saturn.name = "earthQJ"
       // sun.name = "earthQJ"
                         saturn.position = SCNVector3(2.5,0,0)
                               rotateObject(rotation: 0.1, planet: saturn, duration: 0.4)
                               rotateObject(rotation: 0.1, planet: saturnRing, duration: 1)
//                                     let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "Venus Surface"), specular: nil, emission: #imageLiteral(resourceName: "Venus Atmosphere"), normal: nil, position: SCNVector3(0.5, 0, 0))
                                              let moon = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "moon Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0,0,-0.3))
                                            //   venusParent
                                                earth.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                   earth.physicsBody?.isAffectedByGravity = false
                                                earthParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                   earthParent.physicsBody?.isAffectedByGravity = false

                                               
                                               
                                               
                                              // venusParent
                                               venusParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                         venusParent.physicsBody?.isAffectedByGravity = false
                                                 //  venusParent.position = SCNVector3(0,0,-1)
                                                
                                               // venusParent.name = "earth"
                                       //         earth.addChildNode(Shoonode)
        //decent rotations, maybe some could be closer. Fixed bugs with music and ships ending game!
                                               //8328579
                                               earN = earthParent
                                                 earth.name = "earthQJ"
                                                earthParent.name = "earthQJ"
                                    //where the relationships between earth and earthParent
        //perfect distance of planets
        earth.position = SCNVector3(1.8,0,0)
        earthParent.position = SCNVector3(1.8,0,0)
                          //better rotations..nice positions
                         saturn.position = SCNVector3(-1.8,0,0)
                         SaturnParent.position = SCNVector3(-1.8,0,0)
        neptune.position = SCNVector3(0,0,3.5)
        neptuneParent.position = SCNVector3(0,0,3.5)
        jupiter.position = SCNVector3(0,0,-2.9)
         jupiter.name = "earthQJ"
        JupitarParent.position = SCNVector3(0,0,-2.9)
//        venusParent.position = SCNVector3(0,0,1.2)
//        venus.position = SCNVector3(0,0,1.2)
        
                      moonParent.position = SCNVector3(1.2 ,0 , 0)
                  earth.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                          earth.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                          earthParent.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                          earthParent.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
//                      venusParent.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
//                          venusParent.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                      sun.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                                        sun.physicsBody?.isAffectedByGravity = false
                                                                                                        sun.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                                                                  sun.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
        jupiter.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                               jupiter.physicsBody?.isAffectedByGravity = false
                                                                               jupiter.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                                         jupiter.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
        
        //ssss
        saturn.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        //new best score and coin system, planets all destroy, lesss build
                                                                                      saturn.physicsBody?.isAffectedByGravity = false
                                                                                      saturn.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                                                saturn.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
        neptune.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                               neptune.physicsBody?.isAffectedByGravity = false
                                                                               neptune.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                                         neptune.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
        
                      for index in 0...1 {
                        autoreleasepool {
                                        //ear***
                              var Shoonode = SCNNode()
                                               
                              var ssShoonode = SCNNode()
                              var ssThShoonode = SCNNode()
                              var FourthShoonode = SCNNode()
                                                         //ven******
//                                      var VenShoonode = SCNNode()
//
//                                          var VenssShoonode = SCNNode()
//                                                                                                 var VenssThShoonode = SCNNode()
//                                                                                                 var VenFourthShoonode = SCNNode()
                                                         //sa********
                                                         var SaShoonode = SCNNode()
                                                                                       
                                                                                                                                     var SAssShoonode = SCNNode()
                                                                                                                                   var SassThShoonode = SCNNode()
                                                                                                                                   var SaFourthShoonode = SCNNode()
                                //nep******
                        var NepShoonode = SCNNode()
                                                                                            
                        var NepssShoonode = SCNNode()
                    var NepssThShoonode = SCNNode()
                    var NepFourthShoonode = SCNNode()
                        
                        //Jup
                        var JupShoonode = SCNNode()
                                                                      
                                                     var JupssShoonode = SCNNode()
                                                     var JupssThShoonode = SCNNode()
                                                     var JupFourthShoonode = SCNNode()
                        
                        
                                       //ear
                                                           let SpaceShscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                   ssShoonode = (SpaceShscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                    ssShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                         //  ssShoonode.
                                                           ssShoonode.name = "shark"
                                                           //second one
                                                           
                                                           let Spacehscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                   ssThShoonode = (Spacehscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                    ssThShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                           ssThShoonode.name = "shark"
                                                           // third one
                                                           
        let SpacehFscene = SCNScene(named: "art.scnassets/SS1copy.scn")
        FourthShoonode = (SpacehFscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                FourthShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                              FourthShoonode.name = "shark"
                                                        
                                                        
                                                     
                                                         //sa
                    let SpaceShscenez = SCNScene(named: "art.scnassets/SS1copy.scn")
                    SAssShoonode = (SpaceShscenez?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                        SAssShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                          //  ssShoonode.
                        SAssShoonode.name = "shark"
                                                                                            //second one
                                                                                           // SassShoonode SassShoonode
                   let Spacehscenec = SCNScene(named: "art.scnassets/SS1copy.scn")
        SassThShoonode = (Spacehscenec?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                        SassThShoonode.scale = SCNVector3(0.02,0.02,0.02)
                            ssThShoonode.name = "shark"
                                                                                            // third one
                                                                                            
            let SpacehFscenem = SCNScene(named: "art.scnassets/SS1copy.scn")
    SaFourthShoonode = (SpacehFscenem?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                SaFourthShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                        SaFourthShoonode.name = "shark"
                                                                                         
                                                           //nep*****
            let SpaceShscenef = SCNScene(named: "art.scnassets/SS1copy.scn")
                    NepssShoonode = (SpaceShscenef?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                    NepssShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                       //  ssShoonode.
                                                                                                         NepssShoonode.name = "shark"
                                                                                                         //second one
                                                                                                         
                                                  let Spacehscenelk = SCNScene(named: "art.scnassets/SS1copy.scn")
                                              NepssThShoonode = (Spacehscenelk?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                              NepssThShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                      NepssThShoonode.name = "shark"
                                                                                                         // third one
                                                                                                         
                                                          let SpacehFsceneg = SCNScene(named: "art.scnassets/SS1copy.scn")
                                          NepFourthShoonode = (SpacehFsceneg?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                              NepFourthShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                      NepFourthShoonode.name = "shark"
                        
                        
                        
                        
                        let SpaceShscener = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                  JupssShoonode = (SpaceShscener?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                   JupssShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                        //  ssShoonode.
                                                          JupssShoonode.name = "shark"
                                                          //second one
                                                          
                            let Spacehscenel = SCNScene(named: "art.scnassets/SS1copy.scn")
        JupssThShoonode = (Spacehscenel?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                JupssThShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                          JupssThShoonode.name = "shark"
                                                          // third one
                                                          
                let SpacehFsceneah = SCNScene(named: "art.scnassets/SS1copy.scn")
        JupFourthShoonode = (SpacehFsceneah?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                        JupFourthShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                    JupFourthShoonode.name = "shark"
                                                                                                      

                                                               let moonParent = SCNNode()
                                             
                                                          if (index > 1) && (index % 1 == 0) {
                                                      
                                                           
                                                           //ear
                            let scene = SCNScene(named: "art.scnassets/spaceGreen.scn")
                    Shoonode = (scene?.rootNode.childNode(withName: "spaceGreenn", recursively: true)!)!
                                Shoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                        Shoonode.name = "shark"
                                                            //Ven
//                                                            let scenee = SCNScene(named: "art.scnassets/spaceARcopy.scn")
//                                                                                                                       VenShoonode = (scenee?.rootNode.childNode(withName: "SS1redcopy", recursively: true)!)!
//                                                                                                                        VenShoonode.scale = SCNVector3(0.02,0.02,0.02)
//                                                                                                                       VenShoonode.name = "shark"
                                                             //sa
                                                       let scenell = SCNScene(named: "art.scnassets/spaceGreen.scn")
            SaShoonode = (scenell?.rootNode.childNode(withName: "spaceGreenn", recursively: true)!)!
                                                                                                                                        
                        SaShoonode.scale = SCNVector3(0.02,0.02,0.02)
                        SaShoonode.name = "ha"
                                                            //nep
                        let scenenn = SCNScene(named: "art.scnassets/spaceGreen.scn")
                            NepShoonode = (scenenn?.rootNode.childNode(withName: "spaceGreenn", recursively: true)!)!
                                                                                                                                         
                                            NepShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                                                                                                  NepShoonode.name = "shark"
                                                            
                                                            
                            let scenennk = SCNScene(named: "art.scnassets/spaceGreen.scn")
                JupShoonode = (scenennk?.rootNode.childNode(withName: "spaceGreenn", recursively: true)!)!
                                                                                                                                       
                        JupShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                                                                                                                                                             JupShoonode.name = "shark"
                                                            
                                                                                                    
                                                            
                                                                     }else{
                                                            //ear
                            let scene = SCNScene(named: "art.scnassets/missilecopy.scn")
            Shoonode = (scene?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
                                                    Shoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                            Shoonode.name = "shark"
//                                                            //ven
//                                                            let scenee = SCNScene(named: "art.scnassets/missilecopy.scn")
//                                                                                                                         VenShoonode = (scenee?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
//                                                                                                                          VenShoonode.scale = SCNVector3(0.02,0.02,0.02)
//                                                                                                                          VenShoonode.name = "SS1copy.scn"
                                                             //sa
                                let sceneb = SCNScene(named: "art.scnassets/missilecopy.scn")
                    SaShoonode = (sceneb?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
                    SaShoonode.scale = SCNVector3(0.02,0.02,0.02)
                            SaShoonode.name = "shark"
                                    //nep
                        let scenebn = SCNScene(named: "art.scnassets/missilecopy.scn")
            NepShoonode = (scenebn?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
            NepShoonode.scale = SCNVector3(0.02,0.02,0.02)
                        NepShoonode.name = "shark"
                                                            
                                                            
                                                            
                                                            
        let scenebe = SCNScene(named: "art.scnassets/missilecopy.scn")
        JupShoonode = (scenebe?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
        JupShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                                                                                                             JupShoonode.name = "shark"
                                                                     }
                                                           
                                                          
                                                           Shoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                              Shoonode.physicsBody?.isAffectedByGravity = false
                                        
                                                           Shoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                        Shoonode.physicsBody?.isAffectedByGravity = false
                    ssThShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                    ssThShoonode.physicsBody?.isAffectedByGravity = false
                                                                               
                                                                                    
                                                                                                 
    ssShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        ssShoonode.physicsBody?.isAffectedByGravity = false
        FourthShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                                                  FourthShoonode.physicsBody?.isAffectedByGravity = false
                        //Jup
                        JupShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                            JupShoonode.physicsBody?.isAffectedByGravity = false
                        JupssThShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                            JupssThShoonode.physicsBody?.isAffectedByGravity = false
                                                                                   
                                                                                        
                                                                                                     
                JupssShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                JupssShoonode.physicsBody?.isAffectedByGravity = false
                JupFourthShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                    JupFourthShoonode.physicsBody?.isAffectedByGravity = false
                        
                                                         //ven
//                                                          VenShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
//                                                                             VenShoonode.physicsBody?.isAffectedByGravity = false
//                                                        //  ShoonodeSec.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
//                                                                             //ShoonodeSec.physicsBody?.isAffectedByGravity = false
//                                                          VenShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
//
//                                                                             VenssShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
//                                                                                               VenssShoonode.physicsBody?.isAffectedByGravity = false
//                                                          VenFourthShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
//                                                                                                                 VenFourthShoonode.physicsBody?.isAffectedByGravity = false
//                                                        VenssThShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
//                                                                                                                            VenssThShoonode.physicsBody?.isAffectedByGravity = false
                                                         //sa
                                     SaShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                     SaShoonode.physicsBody?.isAffectedByGravity = false
                                                                                        
                            
                             SassThShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                             SassThShoonode.physicsBody?.isAffectedByGravity = false
                                                                                                                     
                             SAssShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                            SAssShoonode.physicsBody?.isAffectedByGravity = false
                             SaFourthShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                             SaFourthShoonode.physicsBody?.isAffectedByGravity = false
                                                          
                                                          //nep
                                                          
                                NepShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                NepShoonode.physicsBody?.isAffectedByGravity = false
                            NepssThShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                              //  SassThShoonode.physicsBody?.isAffectedByGravity = false
                                                                                                                                                                    
                            NepssShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                NepssShoonode.physicsBody?.isAffectedByGravity = false
                                NepFourthShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                NepFourthShoonode.physicsBody?.isAffectedByGravity = false
                                                          
                                                          //end
                                                      //    venusParent.addChildNode(Shoonode)
                earth.addChildNode(Shoonode)
                    earth.addChildNode(ssShoonode)
                                earth.addChildNode(ssThShoonode)
                            earth.addChildNode(FourthShoonode)
                                                        //VEN
                                                      
//                                                        venus.addChildNode(VenShoonode)
//                                                                                          venus.addChildNode(VenssShoonode)
//                                                                                                          venus.addChildNode(VenssThShoonode)
//                                                                                                          venus.addChildNode(VenFourthShoonode)
                                //Sa
                                                   
                        saturn.addChildNode(SaShoonode)
                        saturn.addChildNode(SAssShoonode)
                        saturn.addChildNode(SassThShoonode)
                    saturn.addChildNode(SaFourthShoonode)
                                                          //nep
                                                         // neptune
                                        neptune.addChildNode(NepShoonode)
                                        neptune.addChildNode(NepssShoonode)
                                neptune.addChildNode(NepssThShoonode)
                                    neptune.addChildNode(NepFourthShoonode)
                        //Jupiter
                       jupiter.addChildNode(JupShoonode)
                       jupiter.addChildNode(JupssShoonode)
                    jupiter.addChildNode(JupssThShoonode)
                    jupiter.addChildNode(JupFourthShoonode)
                                       //                     earth.name = "earth"
                                       //                    earthParent.name = "earthParent"
                                                         //  earth.addChildNode(ShoonodeSec)
                                                           AllnodeArray.append(Shoonode)
                                                        //   nodeArray.append(ShoonodeSec)
                                                           AllnodeArray.append(FourthShoonode)
                                                          AllnodeArray.append(ssShoonode)
                                                           AllnodeArray.append(ssThShoonode)
                                                           EarGroupNodeArray.append(earth)
                                                           EarGroupNodeArray.append(earthParent)
                        //Jupitar
                        AllnodeArray.append(JupShoonode)
                                                                            //   nodeArray.append(ShoonodeSec)
                                                                               AllnodeArray.append(JupFourthShoonode)
                                                                              AllnodeArray.append(JupssShoonode)
                                                                               AllnodeArray.append(JupssThShoonode)
                                                                               EarGroupNodeArray.append(jupiter)
                                                                               EarGroupNodeArray.append(JupitarParent)
                                                         //ven*
//                                                        nodeArray.append(VenShoonode)
//                                                                                  //   nodeArray.append(ShoonodeSec)
//
//                                                         ThirdGroupNodeArray.append(VenFourthShoonode)
//                                                                                    SSnodeArray.append(VenssShoonode)
//                                                                                     SecGroupNodeArray.append(VenssThShoonode)
                                                                                     EarGroupNodeArray.append(earth)
                                                                                     EarGroupNodeArray.append(earthParent)
                                                         //sa*
                                                          AllnodeArray.append(SaShoonode)
                                                         AllnodeArray.append(SaFourthShoonode)
                                                         AllnodeArray.append(SAssShoonode)
                                                          AllnodeArray.append(SassThShoonode)
                                                         // EarGroupNodeArray.append(earth)
                                                         // EarGroupNodeArray.append(earthParent)
                                                          //nep*
                                                          AllnodeArray.append(NepShoonode)
                    AllnodeArray.append(NepFourthShoonode)
                AllnodeArray.append(NepssShoonode)
                    AllnodeArray.append(NepssThShoonode)
                EarGroupNodeArray.append(neptune)
                                                                                                       EarGroupNodeArray.append(neptuneParent)

                        
                        Shoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.9),randomFloat(min: -0.8, max: 0.9), randomFloat(min: 0.1, max: 0.5))
                                                                   
                                                                
                                                                //changed this one!!!
                    ssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.9), randomFloat(min: -0.8, max: 0.9))
                                                                
                                                                
                                                       
                    ssThShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                        FourthShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                                                                   
                        //new Jup
                        JupShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.9),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.5))
                                                                                          
                                                                                       
                                                                                       //changed this one!!!
                            JupssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.3), randomFloat(min: -0.8, max: 0.9))
                                                                                       
                                                                                       
        JupssThShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                JupFourthShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                         
                        
                                                           
                                                           
                                                        
                                                                                      
                                                         //Sa
                                                           SaShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.9),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.5))
                                                                                                                          
                                                                                                                       
                                                                                                                       //changed this one!!!
        SAssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.3), randomFloat(min: -0.8, max: 0.9))
                                                                                                                       
        SassThShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
        SaFourthShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                                                          //Nep
            NepShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.9),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.5))
                                                                                                                            
                                                                                                                         
                                                                                                                         //changed this one!!!
         NepShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.9),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.5))
                                                                                                                                                                             
                                                                                                                                                                          
                                                                                                                                                                          //changed this one!!!
                                                          NepssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.3), randomFloat(min: -0.8, max: 0.9))
                                                                                                                                                                          
                                                           NepssThShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                                                           NepFourthShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                                                                                                          
                                                        
                                                                  moonParent.position = SCNVector3(0 ,0 , -1)
                                                          
                Shoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
            Shoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                                        
            ssShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
        ssShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                            ssThShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
        ssThShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
        FourthShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
    FourthShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                        //Jup
                        JupShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                            JupShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                                                               
                    JupssShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                JupssShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                    JupssThShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                    JupssThShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                    JupFourthShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                JupFourthShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                        

                                                         //sa****
        SaShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
        SaShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                                                                             
            SAssShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
        SAssShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
        SassThShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
        SassThShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
    SaFourthShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
    SaFourthShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                                          //nepNepShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                   NepShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                                                                                             
                                                                  NepssShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                              NepssShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                                                                 NepssThShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                             NepssThShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                                              NepFourthShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                          NepFourthShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                                  //Jup
//                        Jupitar
                                                                  //self.sceneView.scene.rootNode.addChildNode(venusParent)
                        self.sceneView.scene.rootNode.addChildNode(JupitarParent)
                                    self.sceneView.scene.rootNode.addChildNode(SaturnParent)
                       
                                    self.sceneView.scene.rootNode.addChildNode(neptuneParent)
                                    self.sceneView.scene.rootNode.addChildNode(     neptuneParentSun)
                          self.sceneView.scene.rootNode.addChildNode(JupitarParentSun)
                                                         // self.sceneView.scene.rootNode.addChildNode(neptune)
                                                         
                                    self.sceneView.scene.rootNode.addChildNode(SaturnParentSun)

                                self.sceneView.scene.rootNode.addChildNode(Shoonode)
                                                      
                                                          
                                    self.sceneView.scene.rootNode.addChildNode(earthParent)
                                    self.sceneView.scene.rootNode.addChildNode(sun)
                                                         //self.sceneView.scene.rootNode.addChildNode(venusParentSun)//self.sceneView.scene.rootNode.addChildNode(ShoonodeSec)
                                        self.sceneView.scene.rootNode.addChildNode(ssShoonode)
                                    self.sceneView.scene.rootNode.addChildNode(ssThShoonode)
                                    self.sceneView.scene.rootNode.addChildNode(FourthShoonode)
//                                                         //ven
//                                                           self.sceneView.scene.rootNode.addChildNode(VenShoonode)
//                                                        self.sceneView.scene.rootNode.addChildNode(VenssShoonode)
//                                                                                       self.sceneView.scene.rootNode.addChildNode(VenssThShoonode)
//                                                                                      self.sceneView.scene.rootNode.addChildNode(VenFourthShoonode)
                        
                        //Jup
                        self.sceneView.scene.rootNode.addChildNode(JupShoonode)
                        self.sceneView.scene.rootNode.addChildNode(JupssShoonode)
                                self.sceneView.scene.rootNode.addChildNode(JupssThShoonode)
                                self.sceneView.scene.rootNode.addChildNode(JupFourthShoonode)
                                                                 //Sa
                                          self.sceneView.scene.rootNode.addChildNode(SaShoonode)
                                    self.sceneView.scene.rootNode.addChildNode(SAssShoonode)
                                    self.sceneView.scene.rootNode.addChildNode(SassThShoonode)
                                self.sceneView.scene.rootNode.addChildNode(SaFourthShoonode)
                                                          //Nep
                                                         
                            self.sceneView.scene.rootNode.addChildNode(NepShoonode)
                                self.sceneView.scene.rootNode.addChildNode(NepssShoonode)
                            self.sceneView.scene.rootNode.addChildNode(NepssThShoonode)
                            self.sceneView.scene.rootNode.addChildNode(NepFourthShoonode)

                            let GreenSecRo = XRotation(time: 4)
                                    let JRRotation = Rotation(time: 5)
                            
                                                                //  let SecRotation = XRotation(time: 300)
                                                            // let SecRo = XRotation(time: 2)
                                                    //     let JRRotation = Rotation(time: 5)
                                                        
                                                                     let sunAction = Rotation(time: 42)
                        // complete level 9
                      //   let sunActionS = Rotation(time: 12)
                                             //fixed rotation around planets! all planet rotations look nice
                                                        
                        //                let sunActionVenus = Rotation(time: 25)
                      //          let sunActionNep = Rotation(time: 13)
                     //       let sunActionJ = Rotation(time: 11)
                   //     let sunActionEar = Rotation(time: 12)
                              //      let earthParentRotation = Rotation(time: 20)
                                     //                      let VRotation = Rotation(time: 15)
                                             //                      let venusParentRotation = XRotation(time: 30)
                              //          let earthRotation = Rotation(time: 30)
                                                                   let moonRotation = Rotation(time: 10)
//                                                         let venusRotation = Rotation(time: 9)
                                           // let JupRotation = Rotation(time: 8)
                                                        //  let JRotation = Rotation(time: 5)
                                                           Shoonode.runAction(GreenSecRo)
                                       //                  //  ShoonodeSec.runAction(SecRotation)
                                                          ssShoonode.runAction(GreenSecRo)
                                                     
                                       //                    //FourthShoonode
                                                          ssThShoonode.runAction(GreenSecRo)
                                                           FourthShoonode.runAction(GreenSecRo)
                                                              
                        //Jup
                                                                    JupShoonode.runAction(GreenSecRo)
                                                        
                                                                        JupssShoonode.runAction(GreenSecRo)
                                                                         
                                                           //                    //FourthShoonode
                                                                              JupssThShoonode.runAction(GreenSecRo)
                                                                               JupFourthShoonode.runAction(GreenSecRo)
                                                        
//                                                        //Ven added
//                                                         VenShoonode.runAction(SecRotation)
//                                                        //                  //  ShoonodeSec.runAction(SecRotation)
//                                                                           VenssShoonode.runAction(SecRotation)
//
//                                                        //                    //FourthShoonode
//                                                                           VenssThShoonode.runAction(SecRo)
//                                                                            VenFourthShoonode.runAction(SecRotation)
                                                          //nep
                                                          NepShoonode.runAction(GreenSecRo)
                                                                                    //                  //  ShoonodeSec.runAction(SecRotation)
                                                                                                        NepssShoonode.runAction(GreenSecRo)
                                                                                                  
                                                                                    //                    //FourthShoonode
                                                                                                        NepssThShoonode.runAction(GreenSecRo)
                                                                                                         NepFourthShoonode.runAction(GreenSecRo)
                                                         //Sa
                                                         SaShoonode.runAction(GreenSecRo)
                                                                                              //                  //  ShoonodeSec.runAction(SecRotation)
                                                                                                                 SAssShoonode.runAction(GreenSecRo)
                                                                                                               
                                                                                              //                    //FourthShoonode
                                                                                                                 SassThShoonode.runAction(GreenSecRo)
                                                                                                                  SaFourthShoonode.runAction(GreenSecRo)
                                                        
                                                        
                                       //                        ssThShoonode
                        JupitarParentSun.runAction(sunAction)
                                                         venusParentSun.runAction(sunAction)
                                                                                             SaturnParentSun.runAction(sunAction)
                        
                        SaturnParentSun.runAction(sunAction)
                        SaturnParent.runAction(JRRotation)
                              saturn.runAction(JRRotation)
                        SaturnParentSun.addChildNode(SaturnParent)
                    SaturnParentSun.addChildNode(saturn)
                saturn.addChildNode(saturnRing)
                saturn.addChildNode(SAssShoonode)
            SaturnParent.addChildNode(SaShoonode)
                                                                                                            //  ssThShoonode.addChildNode(ssShoonode)
SaturnParent.addChildNode(SassThShoonode)
    SaturnParent.addChildNode(SaFourthShoonode)
                        
                                                          neptuneParentSun.runAction(sunAction)
                                                                  earthParent.runAction(JRRotation)
                                                                neptuneParent.runAction(JRRotation)
                                                        JupitarParent.runAction(JRRotation)
                                                          SaturnParent.runAction(JRRotation)
                                                                  venusParent.runAction(JRRotation)
                                                                  moonParent.runAction(moonRotation)
                            //all levels rotate right(ad mst load usall fast
                                                                 //venus.runAction(venusRotation)
                                                      neptune.runAction(JRRotation)
                                                        jupiter.runAction(JRRotation)
                                                                   //venusParent.addChildNode(venus)
                                                                  earth.runAction(JRRotation)
                                                        sun.runAction(sunAction)
                                                          neptune.addChildNode(neptuneRing)
                                                          
                                                                    
                        
                                                                    //Jupitar
                        
                                                            sun.addChildNode(jupiter)
                                                        sun.addChildNode(JupitarParent)
                           sun.addChildNode(neptuneParent)
                            sun.addChildNode(neptune)
                           sun.addChildNode(SaturnParent)
                                                sun.addChildNode(saturn)
                            sun.addChildNode(earth)
                                                                                   sun.addChildNode(earthParent)
                            
                                                    jupiter.addChildNode(JupitarRing)
                        
                                                        //figured out how distribute ships will have to create more Shoonodes
                                                        //can be elaborate with given planets diff rotations since its
                                                      
                                                        //venusParent.addChildNode(venus)
                                                     //   venusParentSun.addChildNode(venusParent)
                                                         
                                                        //added venus and planets
                                                     //   venusParentSun.addChildNode(venus)
                                                      
                                                          saturn.addChildNode(saturnRing)
                                                         //ear
                        //nep 100
                                                        earth.addChildNode(ssShoonode)
                                                           earthParent.addChildNode(Shoonode)
                                                         //  ssThShoonode.addChildNode(ssShoonode)
                                                           earthParent.addChildNode(ssThShoonode)
                                                           earthParent.addChildNode(FourthShoonode)
                                                    //Jupitar
                        
                                                                            jupiter.addChildNode(JupssShoonode)
                                                                                  JupitarParent.addChildNode(JupShoonode)
                                                                                //  ssThShoonode.addChildNode(ssShoonode)
                                                                                  JupitarParent.addChildNode(JupssThShoonode)
                                                                                  JupitarParent.addChildNode(JupFourthShoonode)
        
                        
                        
                                                        //ven
                                                    //    venus.addChildNode(VenssShoonode)
                                                     //   venusParent.addChildNode(VenShoonode)
                                                                                    //  ssThShoonode.addChildNode(ssShoonode)
                                                                                      //venusParent.addChildNode(VenssThShoonode)
                                                                                      //venusParent.addChildNode(VenFourthShoonode)
                                                         //sa
                                                         saturn.addChildNode(SAssShoonode)
                                                                                               SaturnParent.addChildNode(SaShoonode)
                                                                                             //  ssThShoonode.addChildNode(ssShoonode)
                                                                                               SaturnParent.addChildNode(SassThShoonode)
                                                                                               SaturnParent.addChildNode(SaFourthShoonode)
                                                         // nep //added neptune :))
                                                          neptune.addChildNode(NepssShoonode)
                                                           neptuneParent.addChildNode(NepShoonode)
                                                        neptuneParent.addChildNode(NepssThShoonode)
                                                          neptuneParent.addChildNode(NepFourthShoonode)
                                                                  //earthParent.addChildNode(moonParent)
                                                           earth.addChildNode(moon)
                                                                moonParent.addChildNode(moon)
                                       //                    for n in SSnodeArray {
                                       //                        print("\(n.name) jessss")
                                       //                    }
                                               
                                                       }
        }
                                  }
        
    
    func rotateObject(rotation: Float, planet: SCNNode, duration: Float){
        let rotation = SCNAction.rotateBy(x:0,y:CGFloat(rotation),z:0, duration: TimeInterval(duration))
        planet.runAction(SCNAction.repeatForever(rotation))
    }
    
    func createRing(ringSize: Float) -> SCNNode {
         
         let ring = SCNTorus(ringRadius: CGFloat(ringSize), pipeRadius: 0.002)
         let material = SCNMaterial()
         material.diffuse.contents = UIColor.darkGray
         
         ring.materials = [material]
         
         let ringNode = SCNNode(geometry: ring)
         
         return ringNode
     }
    func createPlanet(radius: Float, image: String) -> SCNNode{
           let planet = SCNSphere(radius: CGFloat(radius))
           let material = SCNMaterial()
           material.diffuse.contents = UIImage(named: "\(image).jpg")
           planet.materials = [material]
       
           let planetNode = SCNNode(geometry: planet)
           
           
           return planetNode
       }
    func addTargetNodesSixSat(){
               //Need message dont shoot moon.
               //if so planet and moon destroyed
        //Make ships move on dif speeds llke earlter
                                               let venusParent = SCNNode()
                                             let sun = SCNNode(geometry: SCNSphere(radius: 0.25))
            sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Sun diffuse")
                   sun.position = SCNVector3(0,0,-1)
                     let earthParent = SCNNode()
                let moonParent = SCNNode()
               
                   let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.2 ,0 , 0))
         let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "Venus Surface"), specular: nil, emission: #imageLiteral(resourceName: "Venus Atmosphere"), normal: nil, position: SCNVector3(0.7, 0, 0))
                  let moon = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "moon Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0,0,-0.3))
    //    let saturnRing = createRing(ringSize: 1.2)
               let saturn = createPlanet(radius: 0.03, image: "saturn")
               saturn.name = "saturn"
               saturn.position = SCNVector3(x:1.2 , y: 0, z: 0)
                //   venusParent
                    earth.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                       earth.physicsBody?.isAffectedByGravity = false
                    earthParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                       earthParent.physicsBody?.isAffectedByGravity = false

                   
                   
                   
                  // venusParent
                   venusParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                             venusParent.physicsBody?.isAffectedByGravity = false
                       venusParent.position = SCNVector3(0,0,-1)
                    
                   // venusParent.name = "earth"
           //         earth.addChildNode(Shoonode)
                   //8328579
                   earN = earthParent
                     earth.name = "earth"
                    earthParent.name = "earthParent"
                                             earth.position = SCNVector3(0,0,-1)
                                              earthParent.position = SCNVector3(0,0,-1)
                moonParent.position = SCNVector3(1.2 ,0 , 0)
                   earth.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                   earth.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                   earthParent.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                   earthParent.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                   venusParent.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                        venusParent.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                 //  let frame = self.sceneView.session.currentFrame
                 //  let frame = self.sceneView.
                   // let mat = SCNMatrix4(frame.camera.transform)
                           for index in 0...6 {
                               //need to create an array of nodes..each time you shoot check name and if it right one remove 5 reg nodes and the one hit make sure it explode. Make strings var make  this func shorter
                               //make node array empty in the end of the game func
                               //decent increase number of ships still seem a bit easy but that might be fine
                               var Shoonode = SCNNode()
                               //make it to where it dont kill so many
                           //var ShoonodeSec = SCNNode()
                               // var ShoonodeCloserEarP = SCNNode()
           //                     let earthParent = SCNNode()
                                             var ssShoonode = SCNNode()
                                           var ssThShoonode = SCNNode()
                                           var FourthShoonode = SCNNode()
           //frts one!!!
                               let SpaceShscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                       ssShoonode = (SpaceShscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                        ssShoonode.scale = SCNVector3(0.02,0.02,0.02)
                             //  ssShoonode.
                               ssShoonode.name = "shark"
                               //second one
                               
                               let Spacehscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                       ssThShoonode = (Spacehscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                        ssThShoonode.scale = SCNVector3(0.02,0.02,0.02)
                               ssThShoonode.name = "shark"
                               // third one
                               
                               let SpacehFscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                          FourthShoonode = (SpacehFscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                           FourthShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                  FourthShoonode.name = "shark"
                               

                                   let moonParent = SCNNode()
                 
                              if (index > 1) && (index % 3 == 0) {
                               //this good for a level 2.. speed of red shps and white hard to finish in 30 sec
                              // red
           //                                  let scene = SCNScene(named: "art.scnassets/spaceARcopy.scn")
           //                                 Shoonode = (scene?.rootNode.childNode(withName: "SS1redcopy", recursively: true)!)!
           //                                  Shoonode.scale = SCNVector3(0.03,0.03,0.03)
           //                                 Shoonode.name = "shark"
                               
                               
                                   let scene = SCNScene(named: "art.scnassets/spaceARcopy.scn")
                                                            Shoonode = (scene?.rootNode.childNode(withName: "SS1redcopy", recursively: true)!)!
                                                             Shoonode.scale = SCNVector3(0.03,0.03,0.03)
                                                            Shoonode.name = "shark"
                                         }else{
                              // blue
           //                                  let scene = SCNScene(named: "art.scnassets/SS1copy.scn")
           //                                  FourthShoonode = (scene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
           //                                   FourthShoonode.scale = SCNVector3(0.03,0.03,0.03)
           //                                   FourthShoonode.name = "shark"
                              let scene = SCNScene(named: "art.scnassets/missilecopy.scn")
                                                               Shoonode = (scene?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
                                                                Shoonode.scale = SCNVector3(0.03,0.03,0.03)
                                                                Shoonode.name = "SS1copy.scn"
                                         }
                               
                              
                               Shoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                  Shoonode.physicsBody?.isAffectedByGravity = false
                             //  ShoonodeSec.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                  //ShoonodeSec.physicsBody?.isAffectedByGravity = false
                               Shoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                     Shoonode.physicsBody?.isAffectedByGravity = false
                                                  ssShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                    ssShoonode.physicsBody?.isAffectedByGravity = false
                               FourthShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                      FourthShoonode.physicsBody?.isAffectedByGravity = false

                          //    venusParent.addChildNode(Shoonode)
                               earth.addChildNode(Shoonode)
                                   earth.addChildNode(ssShoonode)
                                                   earth.addChildNode(ssThShoonode)
                                                   earth.addChildNode(FourthShoonode)
           //                     earth.name = "earth"
           //                    earthParent.name = "earthParent"
                             //  earth.addChildNode(ShoonodeSec)
                               nodeArray.append(Shoonode)
                            //   nodeArray.append(ShoonodeSec)
                               ThirdGroupNodeArray.append(FourthShoonode)
                              SSnodeArray.append(ssShoonode)
                               SecGroupNodeArray.append(ssThShoonode)
                               EarGroupNodeArray.append(earth)
                               EarGroupNodeArray.append(earthParent)

                               Shoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.5))
                                  
                               //  let moonRotation = Rotation(time: 5)
                               //changed this one!!!
                               ssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.3), randomFloat(min: -0.8, max: 0.5))
                               
                               
                      
                               ssThShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.5))
                                FourthShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.5))
                               
                               

                                      moonParent.position = SCNVector3(0 ,0 , -1)
                              
                               Shoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                     Shoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                               //ShoonodeSec.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                      //ShoonodeSec.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                               //ssShoonode
                               ssShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                        ssShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                               ssThShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                                          ssThShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                                FourthShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                                                            FourthShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                               
                               // -0.8
                                      //self.sceneView.scene.rootNode.addChildNode(earth)
                                      //self.sceneView.scene.rootNode.addChildNode(earthParent)
                                      self.sceneView.scene.rootNode.addChildNode(venusParent)

                                      self.sceneView.scene.rootNode.addChildNode(Shoonode)
                              
                            
                            self.sceneView.scene.rootNode.addChildNode(sun) //self.sceneView.scene.rootNode.addChildNode(ShoonodeSec)
                               self.sceneView.scene.rootNode.addChildNode(ssShoonode)
                                 self.sceneView.scene.rootNode.addChildNode(ssThShoonode)
                                self.sceneView.scene.rootNode.addChildNode(FourthShoonode)

              

                                      let SecRotation = XRotation(time: 300)
                                 let SecRo = XRotation(time: 6)
                                         let sunAction = Rotation(time: 20)
                                       let earthParentRotation = Rotation(time: 20)
                               let VRotation = Rotation(time: 6)
                                   //    let venusParentRotation = XRotation(time: 30)
                                   //    let earthRotation = Rotation(time: 30)
                                       let moonRotation = Rotation(time: 10)
                             let venusRotation = Rotation(time: 8)
                           
                               Shoonode.runAction(SecRo)
           //                  //  ShoonodeSec.runAction(SecRotation)
                              ssShoonode.runAction(SecRotation)
                             
           //                    //FourthShoonode
                              ssThShoonode.runAction(SecRotation)
                               FourthShoonode.runAction(SecRotation)
           //                        ssThShoonode
                                      earthParent.runAction(earthParentRotation)
                                      venusParent.runAction(VRotation)
                                      moonParent.runAction(moonRotation)
                                     venus.runAction(venusRotation)
                                       venusParent.addChildNode(venus)
                                      earth.runAction(sunAction)
                            sun.runAction(sunAction)
                              // earthParent.addChildNode(venusParent)
    //                           venusParent.addChildNode(Shoonode)
                               
                               ////****** and ven name*/
                                  //    earthParent.addChildNode(Shoonode)
                              // earthParent.addChildNode(ShoonodeSec)
                            sun.addChildNode(earth)
                             sun.addChildNode(earthParent)
                             earthParent.addChildNode(Shoonode)
                               earthParent.addChildNode(ssShoonode)
                             //  ssThShoonode.addChildNode(ssShoonode)
                               earthParent.addChildNode(ssThShoonode)
                               earthParent.addChildNode(FourthShoonode)
                                      earthParent.addChildNode(moonParent)
                               earth.addChildNode(moon)
                                    moonParent.addChildNode(moon)
           //                    for n in SSnodeArray {
           //                        print("\(n.name) jessss")
           //                    }
                   
                           }
                       }
    
     var venusParent = SCNNode()
    func addGGTargetNodes(){
            //2nd phase
            //when points get to a certain point like 40 means 1 left and 37 means 2 may be left
            //when game finish congrat them
            //kill certain ship and certain amount of points
            //when time run out
            //next take code from here appl to brd version
            
            //**immediate goals**
            //save won games in default
            //make blue lke small ships so it be so easy and more black and white
            //reward coins
            //add new level. (next one blue ships but a lil faster)
    
                          //  let msun = SCNNode(geometry: SCNSphere(radius: 0.15))
              let earthParent = SCNNode()
            let earth =  SCNNode(geometry: SCNSphere(radius: 0.15))
         //   venusParent
             earth.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                earth.physicsBody?.isAffectedByGravity = false
             earthParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                earthParent.physicsBody?.isAffectedByGravity = false

            
            
            
           // venusParent
            venusParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                      venusParent.physicsBody?.isAffectedByGravity = false
                venusParent.position = SCNVector3(0,0,-1)
             
            // venusParent.name = "earth"
    //         earth.addChildNode(Shoonode)
            //8328579
            earN = earthParent
              earth.name = "earth"
             earthParent.name = "earthParent"
                                      earth.position = SCNVector3(0,0,-1)
                                       earthParent.position = SCNVector3(0,0,-1)
            earth.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
            earth.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
            earthParent.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
            earthParent.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
            venusParent.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                 venusParent.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
          //  let frame = self.sceneView.session.currentFrame
          //  let frame = self.sceneView.
            // let mat = SCNMatrix4(frame.camera.transform)
                    for index in 0...6 {
                        //need to create an array of nodes..each time you shoot check name and if it right one remove 5 reg nodes and the one hit make sure it explode. Make strings var make  this func shorter
                        //make node array empty in the end of the game func
                        //decent increase number of ships still seem a bit easy but that might be fine
                        var Shoonode = SCNNode()
                        //make it to where it dont kill so many
                    //var ShoonodeSec = SCNNode()
                        // var ShoonodeCloserEarP = SCNNode()
    //                     let earthParent = SCNNode()
                                      var ssShoonode = SCNNode()
                                    var ssThShoonode = SCNNode()
                                    var FourthShoonode = SCNNode()
    //frts one!!!
                        let SpaceShscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                ssShoonode = (SpaceShscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                 ssShoonode.scale = SCNVector3(0.02,0.02,0.02)
                      //  ssShoonode.
                        ssShoonode.name = "shark"
                        //second one
                        
                        let Spacehscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                ssThShoonode = (Spacehscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                 ssThShoonode.scale = SCNVector3(0.02,0.02,0.02)
                        ssThShoonode.name = "shark"
                        // third one
                        
                        let SpacehFscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                   FourthShoonode = (SpacehFscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                    FourthShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                           FourthShoonode.name = "shark"
                        

                            let moonParent = SCNNode()
          
                       if (index > 1) && (index % 3 == 0) {
                        //this good for a level 2.. speed of red shps and white hard to finish in 30 sec
                       // red
    //                                  let scene = SCNScene(named: "art.scnassets/spaceARcopy.scn")
    //                                 Shoonode = (scene?.rootNode.childNode(withName: "SS1redcopy", recursively: true)!)!
    //                                  Shoonode.scale = SCNVector3(0.03,0.03,0.03)
    //                                 Shoonode.name = "shark"
                        
                        
                            let scene = SCNScene(named: "art.scnassets/spaceARcopy.scn")
                                                     Shoonode = (scene?.rootNode.childNode(withName: "SS1redcopy", recursively: true)!)!
                                                      Shoonode.scale = SCNVector3(0.03,0.03,0.03)
                                                     Shoonode.name = "shark"
                                  }else{
                       // blue
    //                                  let scene = SCNScene(named: "art.scnassets/SS1copy.scn")
    //                                  FourthShoonode = (scene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
    //                                   FourthShoonode.scale = SCNVector3(0.03,0.03,0.03)
    //                                   FourthShoonode.name = "shark"
                       let scene = SCNScene(named: "art.scnassets/missilecopy.scn")
                                                        Shoonode = (scene?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
                                                         Shoonode.scale = SCNVector3(0.03,0.03,0.03)
                                                         Shoonode.name = "SS1copy.scn"
                                  }
                        
                       
                        Shoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                           Shoonode.physicsBody?.isAffectedByGravity = false
                      //  ShoonodeSec.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                           //ShoonodeSec.physicsBody?.isAffectedByGravity = false
                        Shoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                              Shoonode.physicsBody?.isAffectedByGravity = false
                                           ssShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                             ssShoonode.physicsBody?.isAffectedByGravity = false
                        FourthShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                               FourthShoonode.physicsBody?.isAffectedByGravity = false

                   //    venusParent.addChildNode(Shoonode)
                        earth.addChildNode(Shoonode)
                            earth.addChildNode(ssShoonode)
                                            earth.addChildNode(ssThShoonode)
                                            earth.addChildNode(FourthShoonode)
    //                     earth.name = "earth"
    //                    earthParent.name = "earthParent"
                      //  earth.addChildNode(ShoonodeSec)
                        nodeArray.append(Shoonode)
                     //   nodeArray.append(ShoonodeSec)
                        ThirdGroupNodeArray.append(FourthShoonode)
                       SSnodeArray.append(ssShoonode)
                        SecGroupNodeArray.append(ssThShoonode)
                        EarGroupNodeArray.append(earth)
                        EarGroupNodeArray.append(earthParent)

                        Shoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.5))
                           
                        
                        //changed this one!!!
                        ssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.3), randomFloat(min: -0.8, max: 0.5))
                        
                        
               
                        ssThShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.5))
                         FourthShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.5))
                        
                        

                               moonParent.position = SCNVector3(0 ,0 , -1)
                       
                        Shoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                              Shoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                        //ShoonodeSec.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                               //ShoonodeSec.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                        //ssShoonode
                        ssShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                 ssShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                        ssThShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                                   ssThShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                         FourthShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                                                     FourthShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                        
                        // -0.8
                               self.sceneView.scene.rootNode.addChildNode(earth)
                               self.sceneView.scene.rootNode.addChildNode(earthParent)
                               self.sceneView.scene.rootNode.addChildNode(venusParent)

                               self.sceneView.scene.rootNode.addChildNode(Shoonode)
                        //self.sceneView.scene.rootNode.addChildNode(ShoonodeSec)
                        self.sceneView.scene.rootNode.addChildNode(ssShoonode)
                          self.sceneView.scene.rootNode.addChildNode(ssThShoonode)
                         self.sceneView.scene.rootNode.addChildNode(FourthShoonode)

       

                               let SecRotation = XRotation(time: 300)
                          let SecRo = XRotation(time: 6)
                                  let sunAction = Rotation(time: 20)
                                let earthParentRotation = Rotation(time: 10)
                        let VRotation = Rotation(time: 6)
                              //  let venusParentRotation = XRotation(time: 20)
                            //    let earthRotation = Rotation(time: 20)
                                let moonRotation = Rotation(time: 5)
                        // decent rotations a bit to easy.. need to make harder to kill big blue and red--show blast hitting maybe with fire but instead ship dont disappear
                          //  make big ships spin as it Rotate
                        Shoonode.runAction(SecRo)
    //                  //  ShoonodeSec.runAction(SecRotation)
                       ssShoonode.runAction(SecRotation)
    //                    //FourthShoonode
                       ssThShoonode.runAction(SecRotation)
                        FourthShoonode.runAction(SecRotation)
    //                        ssThShoonode
                               earthParent.runAction(earthParentRotation)
                               venusParent.runAction(VRotation)
                               moonParent.runAction(moonRotation)

                               
                               earth.runAction(sunAction)
                       // earthParent.addChildNode(venusParent)
                        venusParent.addChildNode(Shoonode)
                        
                        ////****** and ven name*/
                           //    earthParent.addChildNode(Shoonode)
                       // earthParent.addChildNode(ShoonodeSec)
                        earthParent.addChildNode(ssShoonode)
                      //  ssThShoonode.addChildNode(ssShoonode)
                        earthParent.addChildNode(ssThShoonode)
                        earthParent.addChildNode(FourthShoonode)
                               earthParent.addChildNode(moonParent)
    //                    for n in SSnodeArray {
    //                        print("\(n.name) jessss")
    //                    }
            
                    }
                }
    
    //create random float between specified ranges
    func randomFloat(min: Float, max: Float) -> Float {
        return (Float(arc4random()) / 0xFFFFFFFF) * (max - min) + min
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
//    func session(_ session: ARSession, didFailWithError error: Error) {
//        // Present an error message to the user
//
//    }
//
    
   func SecaddTargetNodes(){
       playBackgroundMusic()
            //stable
            //when points get to a certain point like 40 means 1 left and 37 means 2 may be left
            //when game finish congrat them
            //kill certain ship and certain amount of points
            //when time run out
            //next take code from here appl to brd version
                                        let venusParent = SCNNode()
                                  //    let msun = SCNNode(geometry: SCNSphere(radius: 0.15))
              let earthParent = SCNNode()
            let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.2 ,0 , 0))
         //   venusParent
             earth.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                earth.physicsBody?.isAffectedByGravity = false
             earthParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                earthParent.physicsBody?.isAffectedByGravity = false

            
            //all needed to save on memory
                           AllnodeArray.removeAll()
                    EarGroupNodeArray.removeAll()
            
           // venusParent
            venusParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                      venusParent.physicsBody?.isAffectedByGravity = false
                venusParent.position = SCNVector3(0,0,-1)
             
            // venusParent.name = "earth"
    //         earth.addChildNode(Shoonode)
            //8328579
            earN = earthParent
              earth.name = "earthQJ"
             earthParent.name = "earthQJ"
                                      earth.position = SCNVector3(0,0,-1)
                                       earthParent.position = SCNVector3(0,0,-1)
            earth.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
            earth.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
            earthParent.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
            earthParent.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
            venusParent.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                 venusParent.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
          //  let frame = self.sceneView.session.currentFrame
          //  let frame = self.sceneView.
            // let mat = SCNMatrix4(frame.camera.transform)
                    for index in 0...3 {
                        autoreleasepool {
                        //first two levels solid
                        //need to create an array of nodes..each time you shoot check name and if it right one remove 5 reg nodes and the one hit make sure it explode. Make strings var make  this func shorter
                        //make node array empty in the end of the game func
                        //decent increase number of ships still seem a bit easy but that might be fine
                        var Shoonode = SCNNode()
                        //make it to where it dont kill so many
                    //var ShoonodeSec = SCNNode()
                        // var ShoonodeCloserEarP = SCNNode()
    //                     let earthParent = SCNNode()
                                      var ssShoonode = SCNNode()
                                    var ssThShoonode = SCNNode()
                                    var FourthShoonode = SCNNode()
    //frts one!!!
                        let SpaceShscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                ssShoonode = (SpaceShscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                 ssShoonode.scale = SCNVector3(0.02,0.02,0.02)
                      //  ssShoonode.
                        ssShoonode.name = "shark"
                        //second one
                        
                        let Spacehscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                ssThShoonode = (Spacehscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                 ssThShoonode.scale = SCNVector3(0.02,0.02,0.02)
                        ssThShoonode.name = "shark"
                        // third one
                        
                        let SpacehFscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                   FourthShoonode = (SpacehFscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                    FourthShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                           FourthShoonode.name = "shark"
                        
                        //ThirdGroupNodeArray
                        //name
    //                    for v in name {
    //
    //                        ssShoonode.name = v
    //                    }
    //                    name.removeAll()
                            let moonParent = SCNNode()
          
                       if (index > 1) && (index % 3 == 0) {
                       // red
                                         let scene = SCNScene(named: "art.scnassets/spaceGreen.scn")
                                        Shoonode = (scene?.rootNode.childNode(withName: "spaceGreenn", recursively: true)!)!
                                      Shoonode.scale = SCNVector3(0.03,0.03,0.03)
                                     Shoonode.name = "shark"
                                  }else{
                       // blue
                                      let scene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                     Shoonode = (scene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                      Shoonode.scale = SCNVector3(0.03,0.03,0.03)
                                      Shoonode.name = "shark"
                                  }
                        
                       
                        Shoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                           Shoonode.physicsBody?.isAffectedByGravity = false
                      //  ShoonodeSec.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                           //ShoonodeSec.physicsBody?.isAffectedByGravity = false
                        Shoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                              Shoonode.physicsBody?.isAffectedByGravity = false
                        
                                              //Shoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                 //Shoonode.physicsBody?.isAffectedByGravity = false
                                            //  ShoonodeSec.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                 //ShoonodeSec.physicsBody?.isAffectedByGravity = false
                                              ssThShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                    ssThShoonode.physicsBody?.isAffectedByGravity = false
                                           ssShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                             ssShoonode.physicsBody?.isAffectedByGravity = false
                        FourthShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                               FourthShoonode.physicsBody?.isAffectedByGravity = false

                   //    venusParent.addChildNode(Shoonode)
                        earth.addChildNode(Shoonode)
                            earth.addChildNode(ssShoonode)
                                            earth.addChildNode(ssThShoonode)
                                            earth.addChildNode(FourthShoonode)
    //                     earth.name = "earth"
    //                    earthParent.name = "earthParent"
                      //  earth.addChildNode(ShoonodeSec)
                        AllnodeArray.append(Shoonode)
                     //   nodeArray.append(ShoonodeSec)
                        AllnodeArray.append(FourthShoonode)
                       AllnodeArray.append(ssShoonode)
                        AllnodeArray.append(ssThShoonode)
                        EarGroupNodeArray.append(earth)
                                           EarGroupNodeArray.append(earthParent)
    //                    let r = ssShoonode
    //                     let b = ssShoonode
    //                     let c = ssShoonode
    //                       Shoonode.addChildNode(ssShoonode)
    //                     Shoonode.addChildNode(ssThShoonode)
    //                    Shoonode.addChildNode(FourthShoonode)
    //                     Shoonode.addChildNode(b)
    //                    Shoonode.addChildNode(c)
                    //      ShoonodeSec.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: -0.8, max: 0.5)) -0.8, max: 0.3
//     Shoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.9), randomFloat(min: 0.1, max: 0.5))
//
//
//                                              //changed this one!!!
//    ssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.3), randomFloat(min: -0.8, max: 0.8))
//
//
//
//    ssThShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.5))
//    FourthShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.9), randomFloat(min: 0.1, max: 0.7))
                                              
                                              
                                           Shoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.9),randomFloat(min: -0.8, max: 0.9), randomFloat(min: 0.1, max: 0.5))
                                                                                                      
                                                                                                   
                                                                                                   //changed this one!!!
                                                       ssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.9), randomFloat(min: -0.8, max: 0.9))
                                                                                                   
                                                                                                   
                                                                                          
                                                       ssThShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                                                           FourthShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))

                               moonParent.position = SCNVector3(0 ,0 , -1)
                       
                        Shoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                              Shoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                        //ShoonodeSec.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                               //ShoonodeSec.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                        //ssShoonode
                        ssShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                 ssShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                        ssThShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                                   ssThShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                         FourthShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                                                     FourthShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                        
                        // -0.8
                               self.sceneView.scene.rootNode.addChildNode(earth)
                               self.sceneView.scene.rootNode.addChildNode(earthParent)
                               self.sceneView.scene.rootNode.addChildNode(venusParent)

                               self.sceneView.scene.rootNode.addChildNode(Shoonode)
                        //self.sceneView.scene.rootNode.addChildNode(ShoonodeSec)
                        self.sceneView.scene.rootNode.addChildNode(ssShoonode)
                          self.sceneView.scene.rootNode.addChildNode(ssThShoonode)
                         self.sceneView.scene.rootNode.addChildNode(FourthShoonode)

       

                             //  let SecRotation = XRotation(time: 300)
                          //let SecRo = XRotation(time: 6)
                               //   let sunAction = Rotation(time: 15)
                             //   let earthParentRotation = Rotation(time: 10)
                        let VRotation = Rotation(time: 9)
                             //   let venusParentRotation = XRotation(time: 20)
                            //    let earthRotation = Rotation(time: 20)
                                let moonRotation = Rotation(time: 5)
                            let GreenSecRo = XRotation(time: 6)
                                                       let JRRotation = Rotation(time: 7)
                        // decent rotations a bit to easy.. need to make harder to kill big blue and red--show blast hitting maybe with fire but instead ship dont disappear
                          //  make big ships spin as it Rotate
                        Shoonode.runAction(GreenSecRo)
    //                  //  ShoonodeSec.runAction(SecRotation)
                       ssShoonode.runAction(GreenSecRo)
    //                    //FourthShoonode
                       ssThShoonode.runAction(GreenSecRo)
                        FourthShoonode.runAction(GreenSecRo)
    //                        ssThShoonode
                               earthParent.runAction(JRRotation)
                               venusParent.runAction(VRotation)
                               moonParent.runAction(moonRotation)

                               
                               earth.runAction(JRRotation)
                       // earthParent.addChildNode(venusParent)
                        venusParent.addChildNode(Shoonode)
                        
                        ////****** and ven name*/
                           //    earthParent.addChildNode(Shoonode)
                       // earthParent.addChildNode(ShoonodeSec)
                       earth.addChildNode(ssShoonode)
                      //  ssThShoonode.addChildNode(ssShoonode)
                        earthParent.addChildNode(ssThShoonode)
                        earthParent.addChildNode(FourthShoonode)
                               earthParent.addChildNode(moonParent)
    //                    for n in SSnodeArray {
    //                        print("\(n.name) jessss")
    //                    }
            
                    }
                }
    }
        
    
    
    func FsaddTargetNodes(){
                  playBackgroundMusic()
               //when points get to a certain point like 40 means 1 left and 37 means 2 may be left
               //when game finish congrat them
               //kill certain ship and certain amount of points
               //when time run out
               //next take code from here appl to brd version
                                           let venusParent = SCNNode()
                                //         let msun = SCNNode(geometry: SCNSphere(radius: 0.15))
                 let earthParent = SCNNode()
               let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.2 ,0 , 0))
            //   venusParent
                earth.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                   earth.physicsBody?.isAffectedByGravity = false
                earthParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                   earthParent.physicsBody?.isAffectedByGravity = false

               AllnodeArray.removeAll()
            EarGroupNodeArray.removeAll()
               //all needed to save on memory
               // AllnodeArray.removeAll()
        
        
        
              // venusParent
               venusParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                         venusParent.physicsBody?.isAffectedByGravity = false
                   venusParent.position = SCNVector3(0,0,-1)
                
               // venusParent.name = "earth"
       //         earth.addChildNode(Shoonode)
               //8328579
               earN = earthParent
                 earth.name = "earthQJ"
                earthParent.name = "earthQJ"
                                         earth.position = SCNVector3(0,0,-1)
                                          earthParent.position = SCNVector3(0,0,-1)
               earth.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
               earth.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
               earthParent.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
               earthParent.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
               venusParent.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                    venusParent.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
             //  let frame = self.sceneView.session.currentFrame
             //  let frame = self.sceneView.
               // let mat = SCNMatrix4(frame.camera.transform)
                       for index in 0...2 {
                  
                        autoreleasepool {
                           //need to create an array of nodes..each time you shoot check name and if it right one remove 5 reg nodes and the one hit make sure it explode. Make strings var make  this func shorter
                           //make node array empty in the end of the game func
                           //decent increase number of ships still seem a bit easy but that might be fine
                           var Shoonode = SCNNode()
                           //make it to where it dont kill so many
                       //var ShoonodeSec = SCNNode()
                           // var ShoonodeCloserEarP = SCNNode()
       //                     let earthParent = SCNNode()
                                         var ssShoonode = SCNNode()
                                       var ssThShoonode = SCNNode()
                                       var FourthShoonode = SCNNode()
       //frts one!!!
                        var f = 0
                           let SpaceShscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                   ssShoonode = (SpaceShscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                    ssShoonode.scale = SCNVector3(0.02,0.02,0.02)
                         //  ssShoonode.
                           ssShoonode.name = "shark"
                        
                           //second one
                           
                           let Spacehscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                   ssThShoonode = (Spacehscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                    ssThShoonode.scale = SCNVector3(0.02,0.02,0.02)
                           ssThShoonode.name = "shark"
                        f = f+1
                           // third one
                           
                           let SpacehFscene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                      FourthShoonode = (SpacehFscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                       FourthShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                              FourthShoonode.name = "shark"
                        f = f+1
                           
                           //ThirdGroupNodeArray
                           //name
       //                    for v in name {
       //
       //                        ssShoonode.name = v
       //                    }
       //                    name.removeAll()
                               let moonParent = SCNNode()
             
                          if (index > 1) && (index % 2 == 0) {
                            
                        
                          // red
                                         let scene = SCNScene(named: "art.scnassets/spaceGreen.scn")
                                        Shoonode = (scene?.rootNode.childNode(withName: "spaceGreenn", recursively: true)!)!
                                         Shoonode.scale = SCNVector3(0.03,0.03,0.03)
                                        Shoonode.name = "shark"
                            f = f+1
                                     }else{
                          // blue
                                         let scene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                        Shoonode = (scene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                         Shoonode.scale = SCNVector3(0.03,0.03,0.03)
                                         Shoonode.name = "shark"
                            f = f+1
                                     }
                           
                          
                           Shoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                              Shoonode.physicsBody?.isAffectedByGravity = false
                         //  ShoonodeSec.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                              //ShoonodeSec.physicsBody?.isAffectedByGravity = false
                           ssThShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                 ssThShoonode.physicsBody?.isAffectedByGravity = false
                                              ssShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                ssShoonode.physicsBody?.isAffectedByGravity = false
                           FourthShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                                                                  FourthShoonode.physicsBody?.isAffectedByGravity = false

                      //    venusParent.addChildNode(Shoonode)
                           earth.addChildNode(Shoonode)
                               earth.addChildNode(ssShoonode)
                                               earth.addChildNode(ssThShoonode)
                                               earth.addChildNode(FourthShoonode)
       //                     earth.name = "earth"
       //                    earthParent.name = "earthParent"
                         //  earth.addChildNode(ShoonodeSec)
//                           nodeArray.append(Shoonode)
//                        //   nodeArray.append(ShoonodeSec)
//                           ThirdGroupNodeArray.append(FourthShoonode)
//                          SSnodeArray.append(ssShoonode)
//                           SecGroupNodeArray.append(ssThShoonode)
                        EarGroupNodeArray.append(earth)
                                           EarGroupNodeArray.append(earthParent)
                        AllnodeArray.append(Shoonode)
                         AllnodeArray.append(FourthShoonode)
                        AllnodeArray.append(ssShoonode)
                          AllnodeArray.append(ssThShoonode)
                                         
                                                                                                       
                                                                                                       //changed this one!!!
                            Shoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.9),randomFloat(min: -0.8, max: 0.9), randomFloat(min: 0.1, max: 0.5))
                                                                                                                                 
                                                                                                                              
                                                                                                                              //changed this one!!!
                                                                                  ssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.9), randomFloat(min: -0.8, max: 0.9))
                                                                                                                              
                                                                                                                              
                                                                                                                     
                                                                                  ssThShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                                                                                      FourthShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                                          
                        
                        
                        
                                  moonParent.position = SCNVector3(0 ,0 , -1)
                          
                           Shoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                 Shoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                           //ShoonodeSec.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                  //ShoonodeSec.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                           //ssShoonode
                           ssShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                    ssShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                           ssThShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                                      ssThShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                            FourthShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                                                                                        FourthShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                           
                           // -0.8
                                  self.sceneView.scene.rootNode.addChildNode(earth)
                                  self.sceneView.scene.rootNode.addChildNode(earthParent)
                                  self.sceneView.scene.rootNode.addChildNode(venusParent)

                        //com.whatever.AR-JesBrA.Coins
                        //Jesse_CoinsSellas
                        self.sceneView.scene.rootNode.addChildNode(Shoonode)
                           //self.sceneView.scene.rootNode.addChildNode(ShoonodeSec)
                           self.sceneView.scene.rootNode.addChildNode(ssShoonode)
                             self.sceneView.scene.rootNode.addChildNode(ssThShoonode)
                            self.sceneView.scene.rootNode.addChildNode(FourthShoonode)

          
                            let GreenSecRo = XRotation(time: 4)
                            let JRRotation = Rotation(time: 5)
                               //   let SecRotation = XRotation(time: 300)
                          //   let SecRo = XRotation(time: 6)
                                     let sunAction = Rotation(time: 6)
                                 //  let earthParentRotation = Rotation(time: 8)
                         //  let VRotation = Rotation(time: 6)
                          //         let venusParentRotation = XRotation(time: 20)
                              //     let earthRotation = Rotation(time: 20)
                                   let moonRotation = Rotation(time: 5)
                           // decent rotations a bit to easy.. need to make harder to kill big blue and red--show blast hitting maybe with fire but instead ship dont disappear
                             //  make big ships spin as it Rotate
                            Shoonode.runAction(GreenSecRo)
                                         //  ShoonodeG.runAction(GreenSecRo)
                                             //                  //  ShoonodeSec.runAction(SecRotation)
                                                                ssShoonode.runAction(GreenSecRo)
                                             //                    //FourthShoonode
                                                                ssThShoonode.runAction(GreenSecRo)
                                                                 FourthShoonode.runAction(GreenSecRo)
                            
//                           Shoonode.runAction(SecRotation)
//       //                  //  ShoonodeSec.runAction(SecRotation)
//                          ssShoonode.runAction(SecRotation)
//       //                    //FourthShoonode
//                          ssThShoonode.runAction(SecRo)
//                           FourthShoonode.runAction(SecRotation)
       //                        ssThShoonode
                                  earthParent.runAction(JRRotation)
                                  venusParent.runAction(JRRotation)
                                  moonParent.runAction(moonRotation)

                                  
                                  earth.runAction(sunAction)
                          // earthParent.addChildNode(venusParent)
                           venusParent.addChildNode(Shoonode)
                        earthParent.addChildNode(venusParent)
                           
                           ////****** and ven name*/
                                  earth.addChildNode(Shoonode)
                          // earthParent.addChildNode(ShoonodeSec)
                           earthParent.addChildNode(ssShoonode)
                         //  ssThShoonode.addChildNode(ssShoonode)
                           earthParent.addChildNode(ssThShoonode)
                           earthParent.addChildNode(FourthShoonode)
                                  earthParent.addChildNode(moonParent)
       //                    for n in SSnodeArray {
       //                        print("\(n.name) jessss")
       //                    }
                        print("nnnnnnnnnn\(f)")
               
                       }
                   }
    }
    
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    
    
    // MARK: - Contact Delegate
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        //        let defaults = UserDefaults.standard
        //               if let gameScore = defaults.value(forKey: "scoreL"){
        //                   let score = gameScore as! Int
        let nodeA = contact.nodeA
        let nodeB = contact.nodeB
        if nodeA.physicsBody?.categoryBitMask == CollisionCategory.targetCategory.rawValue {
            self.target = nodeA
        } else
            if nodeB.physicsBody?.categoryBitMask == CollisionCategory.targetCategory.rawValue {
                self.target = nodeB
        }
        //can reduce by size to
        print("** Collision!! " + contact.nodeA.name! + " hit " + contact.nodeB.name!)
        
        if contact.nodeA.physicsBody?.categoryBitMask == CollisionCategory.targetCategory.rawValue
            || contact.nodeB.physicsBody?.categoryBitMask == CollisionCategory.targetCategory.rawValue {
            
            
            if (contact.nodeA.name! == "ha" || contact.nodeB.name! == "ha") {
                //                if let Jes = self.sceneView.scene.rootNode.childNode(withName: "ha", recursively: true)
                //decided not add because this a bonus
                //  power = "axe"
             //   Coins+=4
                scoreL+=8
                //                 if !self.AllnodeArray.isEmpty{
                //level 9
                //
                //                score+=5
                //                scoreL+=5
                //                     AllnodeArray.removeLast()
                //                    print("\( AllnodeArray)")
                //                    } else{
                //                    gameOver()
                //                    print("\( AllnodeArray) Over")
                //                }
                
                //  play()
                
                //  playSound(sound: "Power", format: "wav")
                //scoreL+=s
            } else if (contact.nodeA.name! == "earthQJ" || contact.nodeB.name! == "earthQJ") {
                //                self.messageLabel.isHidden = false
                //                              self.messageLabel.text = "you destroyed an planet"
                // Coins = 0
                      // self.timer.invalidate()
                DispatchQueue.main.async { [weak self] in
                  //  isPlanetHitORneedTime = t
           //  DispatchQueue.main.async { [weak self] in
                             guard let self = self else {return}
                         //  self.sceneView.scene.rootNode.removeAllAudioPlayers()
                      // }
                    self.PlanetHit()
                    self.scoreL+=0
                }
                
                
                
            } else if (contact.nodeA.name! == "moonnn" || contact.nodeB.name! == "moonnn"){
//
//                DispatchQueue.main.async {
//
//                   // self.Coins = 0
//                    self.PlanetHitMoon()
//                }
                // self.timer.invalidate()
                DispatchQueue.main.async { [weak self] in
                       //  isPlanetHitORneedTime = t
                //  DispatchQueue.main.async { [weak self] in
                                  guard let self = self else {return}
                                 //  isPlanetHitORneedTime = t
                   
                                   self.PlanetHit()
                    self.scoreL+=0
                               }
                               
                
            }
            
            
            DispatchQueue.main.async { [weak self] in
                       //  isPlanetHitORneedTime = t
                //  DispatchQueue.main.async { [weak self] in
                                  guard let self = self else {return}
                contact.nodeA.removeFromParentNode()
                // contact.nodeA.removeFromParentNode()
                contact.nodeB.removeFromParentNode()
                // contact.ear
                //LETS GOOOOOOOOOOOOOOOOOO This it ******************
                //               self.scoreLabel.text = String(self.scoreL)
                if (contact.nodeA.name! == "mo" || contact.nodeB.name! == "mo"){
                    
              
                    
                }
                    
                else if (contact.nodeA.name! == "shark" || contact.nodeB.name! == "shark"){
                    // var r = 0
                    if let _ = self.sceneView.scene.rootNode.childNode(withName: "shark", recursively: true) {
                     //   let rrr = (self.timerLabel.text)
                        self.scoreL+=1
                        self.Coins+=1
                        if self.seconds < 60 && self.seconds > 50 {
                            self.CoinsAva+=3
                            self.scoreL+=3
                            self.defaultss.set(self.Coins, forKey: "Coins")
                                                           self.defaultss.set(self.CoinsAva, forKey: "CoinsAva")
//                             self.Coins+=1
                            print("Jess annnnnnnnnnnnnnnnnnnnnnnnnn")
                        } else if self.seconds < 40 && self.seconds > 49 {
                            self.CoinsAva+=2
                            self.scoreL+=2
                            self.defaultss.set(self.Coins, forKey: "Coins")
                                                           self.defaultss.set(self.CoinsAva, forKey: "CoinsAva")
//                             self.Coins+=1
                            print("Jess annnnnnnnnnnnnnnnnnnnnnnnnn")
                        }
                        else if self.seconds > 20 && self.seconds < 39 {
                          //  self.CoinsAva+=2
                            self.scoreL+=1
                            self.defaultss.set(self.Coins, forKey: "Coins")
                                                           self.defaultss.set(self.CoinsAva, forKey: "CoinsAva")
//                             self.Coins+=1
                                                   print("Jess annnnnnnnnnnnnnnnnnnnnnnnnn")
                                               }
//                        else if self.seconds > 0 && self.seconds < 20 {
//                            self.Coins+=1
//                                                self.scoreL+=2
//                        }
                       
                        // self.AllnodeArray.removeLast()
                        print("\(self.scoreL) scoreL")
                        print("\(self.Coins)Coins")
                            print("\(self.CoinsAva)CoinsAvaAva Jeeeserdckhghk")
                        print("\(contact.nodeA.name!)")
                     
                      //  print("\(self.timer)")
                            self.defaultss.set(self.Coins, forKey: "Coins")
                                                           self.defaultss.set(self.CoinsAva, forKey: "CoinsAva")
                       // r = r + 1
                      //  print("\(self.timerLabel.text) scoreL")
                    } else{
                          if self.adShowFinish == false {
                        DispatchQueue.main.async {
                          
//                            self.resetTimer(time: 60)
//                            self.ReportScore(with: self.scoreL)
                            self.scoreL+=0
                            self.BeatLevel()
                            }
                            
                            }
                        else {
                            DispatchQueue.main.async {
                            self.resetScene()
                            }
                        }
                        
                    }
                    
                    // SS1copy.scn
                }
                else {
                    self.Coins+=1
                    self.scoreL+=1
                    print("\(self.Coins)Coins else else")
                                              print("\(self.CoinsAva)CoinsAvaAva else else")
                     print("\(self.scoreL)scoreL else else")
                    self.defaultss.set(self.Coins, forKey: "Coins")
                              self.defaultss.set(self.CoinsAva, forKey: "CoinsAva")
                }
                
                self.scoreLabel.text = String(self.scoreL)
                //added dope fireball
            }
            let  explosion = SCNParticleSystem(named: "gaga", inDirectory: nil)
            
            explosion?.particleLifeSpan = 4
            explosion?.emitterShape = contact.nodeB.geometry
            contact.nodeB.addParticleSystem(explosion!)
            
        }
    }
    
    //memory around 400-500
    func planet(geometry: SCNGeometry, diffuse: UIImage, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode {
           let planet = SCNNode(geometry: geometry)
           planet.geometry?.firstMaterial?.diffuse.contents = diffuse
           planet.geometry?.firstMaterial?.specular.contents = specular
           planet.geometry?.firstMaterial?.emission.contents = emission
           planet.geometry?.firstMaterial?.normal.contents = normal
           planet.position = position
           return planet
           
       }
//    func pauseGame() {
//        self.isPaused = true
//        self.physicsWorld.speed = 0
//        self.speed = 0.0
//        self.scene?.view?.isPaused = true
//    }
    func Rotation(time: TimeInterval) -> SCNAction {
        //see here it rotate around the y - axis can do the same for x-axis
        //this game we save planets!! - from colorful creatures?
        let Rotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: time)
        let foreverRotation = SCNAction.repeatForever(Rotation)
        return foreverRotation
    }
    func XRotation(time: TimeInterval) -> SCNAction {
         //see here it rotate around the y - axis can do the same for x-axis
         //this game we save planets!! - from colorful creatures?
         let Rotation = SCNAction.rotateBy(x: CGFloat(360.degreesToRadians), y: 0, z: 0, duration: time)
         let foreverRotation = SCNAction.repeatForever(Rotation)
         return foreverRotation
     }
    // MARK: - sounds
    
    var player: AVAudioPlayer?
    
    func playSound(sound : String, format: String) {
        guard let url = Bundle.main.url(forResource: sound, withExtension: format) else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.playback)))
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playBackgroundMusic(){
//        let audioNode = SCNNode()
//        let audioSource = SCNAudioSource(fileNamed: "Sleepy.mp3")!
//        let audioPlayer = SCNAudioPlayer(source: audioSource)
//
//        audioNode.addAudioPlayer(audioPlayer)
//        //arm 7, ads work, nice begining load, blast react fast, beat repeat
//        let play = SCNAction.playAudio(audioSource, waitForCompletion: true)
//        let soundd = SCNAction.repeatForever(play)
//       // let play = SCNAction.pa
////        let gg = SCNAction.removeFromParentNode()
//        audioNode.runAction(soundd)
//
//        sceneView.scene.rootNode.addChildNode(audioNode)
        let audioPlayer = SCNAudioPlayer(source: audioSource)
                    
                    audioNode.addAudioPlayer(audioPlayer)
                    
                    let play = SCNAction.playAudio(audioSource, waitForCompletion: true)
                   // let play = SCNAction.pa
            //        let gg = SCNAction.removeFromParentNode()
                    audioNode.runAction(play)
                    
                    sceneView.scene.rootNode.addChildNode(audioNode)
    }
    func stopBackgroundMus() {
//         let audioPlayer = SCNAudioPlayer(source: audioSource)
        let gg = SCNAction.removeFromParentNode()
        audioNode.runAction(gg)
        sceneView.scene.rootNode.removeAllAudioPlayers()
//
          //  audioPlayer.stop()
         //   audioPlayer.currentTime = 0 // I usually reset the song when I stop it. To pause it create another method and call the pause() method on the audioPlayer.
         //   audioPlayer.prepareToPlay()
        }
    
}

struct CollisionCategory: OptionSet {
    let rawValue: Int
    
    static let missileCategory  = CollisionCategory(rawValue: 1 << 0)
    static let targetCategory = CollisionCategory(rawValue: 1 << 1)
    static let otherCategory = CollisionCategory(rawValue: 1 << 2)
}
extension Int {
    
    var degreesToRadians: Double { return Double(self) * .pi/180}
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
    return input.rawValue
}
//Finish the waves(they know its a new level by "shoot plane.."message ) and best scre and coins.. changed "fire.smsp" to gaga..need to apply memory manage to rest of code
extension ViewController: FBInterstitialAdDelegate {
    func interstitialAdDidLoad(_ interstitialAd: FBInterstitialAd) {
        print("Ads Loaded")
        
         print(" adShowFinish = true")
//        adShowFinish = true
        AdsLoaded = true
    }
  //arm 7, ads work, nice begining load, blast react fast
    func interstitialAdWillClose(_ interstitialAd: FBInterstitialAd) {
        InterstitialAd()
//        DispatchQueue.main.async {
//            self.shouldShowBestScoreContainerView(state: false)
//           self.resetTimer(time: 30)
//            self.runTimer()
//        }
    }
    func interstitialAdDidClose(_ interstitialAd: FBInterstitialAd) {
         self.resetButton.isHidden = false
          adShowFinish = false
             print("Interstitial had been closed")
       self.sceneView.isHidden = false
                       SwiftSpinner.hide()
             arrrrr = self.scoreL
                           
                             defaultss.set(arrrrr, forKey: "scoreL")
            defaultss.set(self.Coins, forKey: "Coins")
         defaultss.set(self.CoinsAva, forKey: "CoinsAva")
                            self.ReportScore(with: arrrrr)
        DispatchQueue.main.async {
            self.shouldShowBestScoreContainerView(state: false)
           self.resetTimer(time: 30)
            self.runTimer()
        }
            self.PoP = false
            if isPlanetHit{
                    DispatchQueue.main.async {
                    self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
                    node.removeFromParentNode()
                        }
                        self.play()
                    }
            } else {
              DispatchQueue.main.async {
                self.playBackgroundMusic()
            }
        
            }
            isPlanetHit = false
    }
}
