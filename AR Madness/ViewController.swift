//
//  ViewController.swift
//  AR Madness
//

//  Copyright © 2018 O'Sullivan, Andy. All rights reserved.
//

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
import UIKit
import SceneKit
import ARKit
import StoreKit
//import SpriteKit
enum BitMaskCategory: Int {
    case target  = 3
}
//class AudioPlayer {
//    var audioPlayer = AVAudioPlayer()
//    func playingSoundWith(fileName: String) {
//        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: Bundle.main.url(forResource: fileName, withExtension: "mp3")!)
//            audioPlayer.prepareToPlay()
//            audioPlayer.play()
//        } catch {
//            print(error)
//        }
//    }
//}

class ViewController: UIViewController, ARSCNViewDelegate, SCNPhysicsContactDelegate, SKPaymentTransactionObserver {
    
    //MARK: - variables

    @IBOutlet var sceneView: ARSCNView!
    
    //used to display timer to player
    @IBOutlet weak var timerLabel: UILabel!
    
    //used to display score to player
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var Score: UILabel!
    
    
    @IBOutlet weak var BesLabel: UILabel!
    
    @IBOutlet weak var BestScore: UILabel!
    @IBOutlet weak var levelJB:UILabel!
    var Time = false
    
    
    @IBOutlet weak var retry: UIButton!
    //revve
    @IBOutlet weak var r: UIButton!
    var trackerNode: SCNNode?
    var foundSurface = false
    var tracking = true
//    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
//    }
    //used to store the scoreP:>L)_________________________________________________________________________________________________________________________[…≥π÷{{Ú∏˘::
    
    let audioNode = SCNNode()
    let audioSource = SCNAudioSource(fileNamed: "Sleepy.mp3")!
    let productID = "Jesse_CoinsSellas"
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
    
//   messageLabel.isHidden = true
    //MARK: - buttons
    
    
    @IBAction func Restart(_ sender: Any) {
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
                                        node.removeFromParentNode()
                                    }
              self.pla()
    }
    
    
    @IBAction func Revive(_ sender: Any) {
        
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
                                  node.removeFromParentNode()
                              }
        self.pla()
    }
    
    
  //make blue and red(esp) clse!!!
    //axe button
    
    
    
    
//    @IBAction func onAxeButton(_ sender: Any) {
//        fireMissile(type: "axe")
//    }
//    
//    //banana button
//    @IBAction func onBananaButton(_ sender: Any) {
//        //the one!!!!
//        fireMissile(type: "banana")
//    }
    
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
    
    //MARK: - view functions
    // let audioPlayer = SCNAudioPlayer(source: audioSource)
    override func viewDidLoad() {
        super.viewDidLoad()
        SKPaymentQueue.default().add(self)
        // stopBackgroundMusic()
        // Set the view's delegate
        sceneView.delegate = self
        // let audioPlayer = SCNAudioPlayer(source: audioSource)
        // Show statistics such as fps and timing information
        //sceneView.showsStatistics = true
        
        //set the physics delegate
        sceneView.scene.physicsWorld.contactDelegate = self
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.sceneView.addGestureRecognizer(gestureRecognizer)

        let defaults = UserDefaults.standard
            if let gameScore = defaults.value(forKey: "Coins"){
                 Coins = gameScore as! Int
                print("\(Coins) Jesse KKKK")
                
                //pla()
        }
       // DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.pla()
   // })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //stopBackgroundMusic()
//        let defaults = UserDefaults.standard
//                   if let gameScore = defaults.value(forKey: "scoreL"){
//                       let score = gameScore as! Int
//                       if score > 90 {
//                           print("\(score): welcome to level 2")
//                       } else{
//                           print("\(score): still on level 1")
//                       }
//                       //scoreLabel.text = "Score: \(String(score))"
//                   }
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        //can see which phones supported ie ARWorldTrackingConfiguration.isSupported see if supported
        //if not give them ArSessionConfiguration()
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //stopBackgroundMusic()
        // Pause the view's session
        sceneView.session.pause()
       // stopBackgroundMusic()
    }
    
    // MARK: - timer
    
    //to store how many sceonds the game is played for
    var seconds = 30
    
    //timer
    var timer = Timer()
    
    //to keep track of whether the timer is on
    var isTimerRunning = false
    
    //to run the timer
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer){
        fireMissile(type: power)
       
    }
    
    func PlayInstructions() {

//        messageLabel.isHidden = false
//        [self performSelector:@selector(hiddenLabel) withObject:nil afterDelay:3];
        self.messageLabel.isHidden = false
               self.messageLabel.text = "Shoot all the spaceships. Do not shoot planets"
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {

        self.messageLabel.isHidden = true
                 })




    }
    
    //decrements seconds by 1, updates the timerLabel and calls gameOver if seconds is 0
    @objc func updateTimer() {
        if seconds == 0 {
            timer.invalidate()
            //believe this issue because this the only place that calls  gameOver()
            NeedMoreTime()
           // gameOver()
        }else{
            seconds -= 1
            timerLabel.text = "\(seconds)"
        }
    }
    
    //resets the timer
    func resetTimer(){
        timer.invalidate()
        seconds = 60
        timerLabel.text = "\(seconds)"
    }
    
    // MARK: - game over
    
    func gameOver(){
//        earth"
//        earthParent.name = "earthParent
        var scoreJJ = 0
        let chd = "earth"
          let chdKK = "earthParent"
    


         let defaultss = UserDefaults.standard
                    if let gameScore = defaultss.value(forKey: "scoreL"){
                         scoreJJ = gameScore as! Int
                        if Coins > 90 {
                          //  print("\(score):score >90 welcome to level 2")
                        } else{
                           // print("\(score): score <90 still on level 1")
                        }
        //                //scoreLabel.text = "Score: \(String(score))"
                 }
        
        
     //   scoreL += score
        let fscre = scoreL
        //store the score in UserDefaults
        let defaults = UserDefaults.standard
        defaults.set(Coins, forKey: "Coins")
//        scoreL += score
      //  defaults.set(scoreL, forKey: "scoreL")
       // let arrrrr = scoreJJ + fscre
        let arrrrr = scoreL
        let defaultsJB = UserDefaults.standard
        defaultsJB.set(arrrrr, forKey: "scoreL")
        //go back to the Home View Controller
       // removeAud
        //stopBackgroundMusic()
        self.dismiss(animated: true, completion: nil)
         stopBackgroundMus()
    }
    func NeedMoreTime(){
          
//        var Time = false
        timer.invalidate()

        let alert = UIAlertController(title: "Need more time", message: "Continue this level?", preferredStyle: UIAlertController.Style.alert)

             let ok = UIAlertAction(title: "10 coins", style: .default, handler: { action in
                //remembe
                 if self.Coins>=10{
                    //not working because coins = 0 in real physical world
                    //will need restart here cuz planet gone
                                print("\(self.Coins) Coins")
                                self.Coins = self.Coins - 10
                                 print("\(self.Coins) Coins after")
                    let defaults = UserDefaults.standard
                                        defaults.set(self.Coins, forKey: "Coins")
                                                   //        scoreL += score
                                                         //  defaults.set(scoreL, forKey: "scoreL")
                                                           let arrrrr = self.scoreL
                                                           let defaultsJB = UserDefaults.standard
                                                           defaultsJB.set(arrrrr, forKey: "scoreL")
                    //since planet got hit restart with **Correct** points
//                    self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
//                                              node.removeFromParentNode()
//                                          }
//                    self.pla()
                   // timer
                    //self.seconds = 90
                    //need to make sre messgae go wi
                    self.resetTimer()
                    self.runTimer()
                               // let fscre = self.scoreL
                                                     //store the score in UserDefaults and leaderboard
                                         
                }
                 else {
                    let alert = UIAlertController(title: "Not enough coins", message: "Buy more?", preferredStyle: .alert)

                         let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                            //magic for in app purchases
                            //j
                            //All project
                            self.Time = true
                            self.buyPremiumQuotes()
                            
                         })
                         alert.addAction(ok)
                         let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { action in
                            //done in ph world too
                            self.Coins = 0
                            self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
                                                                              node.removeFromParentNode()
                                                                          }
                                                    self.pla()
                         })
                         alert.addAction(cancel)
                         DispatchQueue.main.async(execute: {
                            self.present(alert, animated: true)
                    })
                    
                }
             })
             alert.addAction(ok)
             let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { action in
                self.Coins = 0
                self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
                                                   node.removeFromParentNode()
                                               }
                         self.pla()
             })
             alert.addAction(cancel)
             DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
        })


        
      }
    
    func PlanetHit() {


        timer.invalidate()

        let alert = UIAlertController(title: "You shot a planet", message: "Continue this level?", preferredStyle: UIAlertController.Style.alert)

             let ok = UIAlertAction(title: "10 coins", style: .default, handler: { action in
                //remembe
                 if self.Coins>=10{
                    //not working because coins = 0 in real physical world
                    //will need restart here cuz planet gone
                                print("\(self.Coins) Coins")
                                self.Coins = self.Coins - 10
                                 print("\(self.Coins) Coins after")
                    let defaults = UserDefaults.standard
                                        defaults.set(self.Coins, forKey: "Coins")
                                                   //        scoreL += score
                                                         //  defaults.set(scoreL, forKey: "scoreL")
                                                           let arrrrr = self.scoreL
                                                           let defaultsJB = UserDefaults.standard
                                                           defaultsJB.set(arrrrr, forKey: "scoreL")
                    //since planet got hit restart with **Correct** points
                    self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
                                              node.removeFromParentNode()
                                          }
                    self.pla()
                               // let fscre = self.scoreL
                                                     //store the score in UserDefaults and leaderboard
                                         
                }
                 else {
                    let alert = UIAlertController(title: "Not enough coins", message: "Buy more?", preferredStyle: .alert)

                         let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                            //magic for in app purchases
                            //j
                            //All project
                            self.buyPremiumQuotes()
                            
                         })
                         alert.addAction(ok)
                         let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { action in
                            //done in ph world too
                            self.Coins = 0
                            self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
                                                                              node.removeFromParentNode()
                                                                          }
                                                    self.pla()
                         })
                         alert.addAction(cancel)
                         DispatchQueue.main.async(execute: {
                            self.present(alert, animated: true)
                    })
                    
                }
             })
             alert.addAction(ok)
             let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { action in
                self.Coins = 0
                self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
                                                   node.removeFromParentNode()
                                               }
                         self.pla()
             })
             alert.addAction(cancel)
             DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
        })




             }
    //C
    // MARK: - In-App Purchase Methods
    
    func buyPremiumQuotes() {
        if SKPaymentQueue.canMakePayments() {
            //Can make payments
            
           let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productID
            SKPaymentQueue.default().add(paymentRequest)
            
            
        } else {
            //Can't make payments
            print("User can't make payments")
            
            //add alert here
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                
                //User payment successful
                print("Transaction successful!")
                
                showPremiumQuotes()
                
               
                
                SKPaymentQueue.default().finishTransaction(transaction)
                
            } else if transaction.transactionState == .failed {
                
                //Payment failed
                if let error = transaction.error {
                    let errorDescription = error.localizedDescription
                    print("Transaction failed due to error: \(errorDescription)")
                }
                
                 SKPaymentQueue.default().finishTransaction(transaction)
                
            } else if transaction.transactionState == .restored {
                
                showPremiumQuotes()
                
                print("Transaction restored")
                
                navigationItem.setRightBarButton(nil, animated: true)
                
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
        
    }
  
    
    func showPremiumQuotes() {
        
        UserDefaults.standard.set(true, forKey: productID)
        
     //   quotesToShow.append(contentsOf: premiumQuotes)
       // tableView.reloadData()
        //self.Coins = Coins + 10
        //in app works... Transaction successful!
        //need to sub or add less cuz it goes too next level
        //well do add 5 for now.. for 1.99 look at other games in app purchases
        self.Coins+=10
        let defaults = UserDefaults.standard
                  defaults.set(self.Coins, forKey: "Coins")
        print("\(self.Coins) Coins")
//        self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
//                                  node.removeFromParentNode()
//                              }
        //next make sure message correspond to score probably be better to have wave that lead to next level. increase game play and help better solve issue of not having to shoot every ship. help with points because unless score met ill just keep redoing level(on average 2) and message label = wave 4 ect...or can keep simple but risk consistency...Ar shoot sim to first but even session..My solution=== reward right amount of points crete large range fr levels. Make sure with the way points rewarded user cant skip levels --leaderboard/ach ---dope ui --- bugs --approval req/doc
        //
        if Time {
            self.resetTimer()
        self.runTimer()
        } else {
            self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
                                             node.removeFromParentNode()
                                         }
            //make sure cancel ends game and every scenerio
        self.resetTimer()
        
        self.pla()
        }
        
          Time = false
        
    }
    
    
//    func C() -> Int {
//
//    }
    
    func BeatLevel() {

         //        messageLabel.isHidden = false
         //        [self performSelector:@selector(hiddenLabel) withObject:nil afterDelay:3];
//        checkOutButtonOutlet.layer.shadowColor = UIColor.black.cgColor
//                          checkOutButtonOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//                        checkOutButtonOutlet.layer.masksToBounds = false
//                         checkOutButtonOutlet.layer.shadowRadius = 1.0
//                        checkOutButtonOutlet.layer.shadowOpacity = 0.5
//                          checkOutButtonOutlet.layer.cornerRadius = 7
        //almost finish in-app
        
        
        var counter = 0
                 self.messageLabel.isHidden = false
        timer.invalidate()
                        self.messageLabel.text = "Level Completed"
       
                 // if let gameScore = defaults.value(forKey: "Coins"){
                      // Coins = gameScore as! Int
                      print("\(Coins) Jesse KKKK")
                    self.BesLabel.text = ("+")
                     self.BestScore.text  = "\(Coins) coins"
//        self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
//                                  node.removeFromParentNode()
//                              }

             DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
                self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
                           node.removeFromParentNode()
                       }
           

                         let defaultss = UserDefaults.standard
//                                    if let gameScore = defaultss.value(forKey: "Coins"){
//                                         scoreJJ = gameScore as! Int
//                                        if self.Coins > 90 {
//                                          //  print("\(score):score >90 welcome to level 2")
//                                        } else{
//                                           // print("\(score): score <90 still on level 1")
//                                        }
//                        //                //scoreLabel.text = "Score: \(String(score))"
//                                 }
                        
                        
                     //   scoreL += score
                let fscre = self.scoreL
                        //store the score in UserDefaults
                        let defaults = UserDefaults.standard
                defaults.set(self.Coins, forKey: "Coins")
                //        scoreL += score
                      //  defaults.set(scoreL, forKey: "scoreL")
                
                
                
                        //After in app purchases make this 0..so we can keep
                        //up with best score
                        let arrrrr = self.scoreL
                        let defaultsJB = UserDefaults.standard
                        defaultsJB.set(arrrrr, forKey: "scoreL")
                        //go back to the Home View Controller
                       // removeAud
                        //stopBackgroundMusic()
                       // self.dismiss(animated: true, completion: nil)
                //self.stopBackgroundMus()
                 self.messageLabel.isHidden = true
                self.BestScore.isHidden = true
                      self.BestScore.isHidden = true
                self.BesLabel.isHidden = true
                
                self.pla()
                          })




             }
    
    
    
    func PlanetHitMoon() {

            //        messageLabel.isHidden = false
            //        [self performSelector:@selector(hiddenLabel) withObject:nil afterDelay:3];
                    self.messageLabel.isHidden = false
                           self.messageLabel.text = "You shot the moon"
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
                    var scoreJJ = 0
                           let chd = "earth"
                             let chdKK = "earthParent"
                       


                            let defaultss = UserDefaults.standard
                                       if let gameScore = defaultss.value(forKey: "scoreL"){
                                            scoreJJ = gameScore as! Int
                                           if self.Coins > 90 {
                                             //  print("\(score):score >90 welcome to level 2")
                                           } else{
                                              // print("\(score): score <90 still on level 1")
                                           }
                           //                //scoreLabel.text = "Score: \(String(score))"
                                    }
                           
                           
                        //   scoreL += score
                   let fscre = self.scoreL
                           //store the score in UserDefaults
                           let defaults = UserDefaults.standard
                   defaults.set(self.Coins, forKey: "Coins")
                   //        scoreL += score
                         //  defaults.set(scoreL, forKey: "scoreL")
                           let arrrrr = self.scoreL
                           let defaultsJB = UserDefaults.standard
                           defaultsJB.set(arrrrr, forKey: "scoreL")
                           //go back to the Home View Controller
                          // removeAud
                           //stopBackgroundMusic()
                           self.dismiss(animated: true, completion: nil)
                   self.stopBackgroundMus()
                    self.messageLabel.isHidden = true
                             })




                }
       
    
    
    func pla() {
       // resetTimer()
        //this will eventually use gold!!rewarded for next level instead of score
        //more gold they spend could go down..
        if 7...38 ~= Coins {
                      power = "banana"
                                   messageLabel.isHidden = true
                            levelJB.text = "level 2"
                                  SecaddTargetNodes()
//            addTargetNodesJupitar()
             sceneView.scene.rootNode.removeAllAudioPlayers()
                                  PlayInstructions()
                                  //play background music
//                            stopBackgroundMusic()
                                  playBackgroundMusic()
           // addTargetNodesFive()
        //addTargetNodesSixVenus()
           // addTargetNodesNeptune()
           // addTargetNodesSaturn()
            //h()
          //  addTargetNodesFour()
                                  // addTargetNodesJupitar()
                                  //start tinmer
                                  runTimer()
    
                            print("\(Coins): welcome to level 2")
                        } else if 39...66 ~= Coins{
            power = "banana"
                          //  sceneView.backgroundColor = UIColor.red
                                   messageLabel.isHidden = true
                            levelJB.text = "level 3"
                                  addTargetNodes()
                            //FsaddTargetNodes()
                            // FsaddTargetNodes()
            // sceneView.scene.rootNode.removeAllAudioPlayers()
                                  PlayInstructions()
                                  //play background music
                                  playBackgroundMusic()
                                  
                                  //start tinmer
                                  runTimer()
                              print("\(Coins): welcome to level 3 jess")
              
                        }
                        else if 67...94 ~= Coins{
            power = "banana"
                                          //  sceneView.backgroundColor = UIColor.red
                                                   messageLabel.isHidden = true
                                            levelJB.text = "level 4"
                                                  addTargetNodesFour()
                                      //     sceneView.scene.rootNode.removeAllAudioPlayers()
                                                  PlayInstructions()
                                                  //play background music
                                                  playBackgroundMusic()
                                                  
                                                  //start tinmer
                                                  runTimer()
                                              print("\(Coins): welcome to level 4 jess")
                            
                                        }       else if 95...129 ~= Coins{
            power = "banana"
                                                                    //  sceneView.backgroundColor = UIColor.red
                                                                             messageLabel.isHidden = true
                                                                      levelJB.text = "level 5"
                            
                            //Will need to add other nodes give a more real effect. For smaller ships
                                                                            addTargetNodesFive()
                                                                      //FsaddTargetNodes()
                                                                      // FsaddTargetNodes()
             //sceneView.scene.rootNode.removeAllAudioPlayers()
                                                                            PlayInstructions()
                                                                            //play background music
                                                                        //    playBackgroundMusic()
                                                                           // playingSoundWith
                                                                            //start tinmer
                                                                            runTimer()
                                                                        print("\(Coins): welcome to level 5 jess")
                                                                   //
                                                                  } else if 130...161 ~= Coins{
            power = "banana"
                                                                                                          //  sceneView.backgroundColor = UIColor.red
            
             sceneView.scene.rootNode.removeAllAudioPlayers()
                                                                                                                   messageLabel.isHidden = true
                                                                                                            levelJB.text = "level 6"
                                                                  
                                                                  //Will need to add other nodes give a more real effect. For smaller ships
                                                                                                                  addTargetNodesSixVenus()
                                                                                                            //FsaddTargetNodes()
                                                                                                            // FsaddTargetNodes()
                                                                                                                  PlayInstructions()
                                                                                                                  //play background music
                                                                                                                  playBackgroundMusic()
                                                                                                                  
                                                                                                                  //start tinmer
                                                                                                                  runTimer()
                                                                                                              print("\(Coins): welcome to level 6 jess")
                                                                               
                                                                                                        }
                        
                        //addTargetNodesSaturn()
                        else if 162...209 ~= Coins{
            power = "banana"
            
             sceneView.scene.rootNode.removeAllAudioPlayers()
            
                                                                //  sceneView.backgroundColor = UIColor.red
                                                                         messageLabel.isHidden = true
                                                                  levelJB.text = "level 7"
                        
                        //Will need to add other nodes give a more real effect. For smaller ships
            addTargetNodesNeptune()
                                                                        //addTargetNodesSaturn()
                                                                  //FsaddTargetNodes()
                                                                  // FsaddTargetNodes()
                                                                        PlayInstructions()
                                                                        //play background music
                                                                        playBackgroundMusic()
                                                                        
                                                                        //start tinmer
                                                                        runTimer()
                                                                    print("\(Coins): welcome to level 7 jess")
                                                               
                                                              }
                        else if 209...1320 ~= Coins{
            
            power = "banana"
            
             sceneView.scene.rootNode.removeAllAudioPlayers()
                                                                               //  sceneView.backgroundColor = UIColor.red
                                                                                        messageLabel.isHidden = true
                                                                                 levelJB.text = "level 8"
                                       
                               
                                                                                       addTargetNodesJupitar()
                            // FsaddTargetNodes()
                                                                                       PlayInstructions()
                                                                                       //play background music
                                                                                       playBackgroundMusic()
                                                                                       
                                                                                       //start tinmer
                                                                                       runTimer()
                                                                                   print("\(Coins): welcome to level 8 jess")
                                                                              
                                                                             }
//      else if 807...5950 ~= score{
//             sceneView.scene.rootNode.removeAllAudioPlayers()
//                                                                               //  sceneView.backgroundColor = UIColor.red
//                                                                                        messageLabel.isHidden = true
//                                                                                 levelJB.text = "level 1"
//
//                                       //Will need to add other nodes give a more real effect. For smaller ships
//              FsaddTargetNodes()
//
//                                                                                  //addTargetNodesJupitar()
//
//         //   addTargetNodesSixVenus()
//           // addTargetNodesNeptune()
//            //addTargetNodesSaturn()
//            //addTargetNodes()
//
//            //addTargetNodesFour()
//                                                                                    //addTargetNodesFive()
//                                                       //    FsaddTargetNodes()
//           // SecaddTargetNodes()
//            PlayInstructions()
//                                                                                    //play background music
//                                                                     //          stopBackgroundMusic()
//            //Sleepy
//            playBackgroundMusic()
//           // playingSoundWith(fileName: String)
//           // playingSoundWith(fileName: "Sleepy")
//
//                                                                                       //start tinmer
//                                                                                       runTimer()
//                                                                                   print("\(score): welcome to level 9 jess")
//           // stopBackgroundMusic()
//
//                                                                             }
      
                 
                else{
            power = "banana"
                  //  sceneView.backgroundColor = UIColor.red
             sceneView.scene.rootNode.removeAllAudioPlayers()
                           messageLabel.isHidden = true
                    levelJB.text = "level 1"
                          //addTargetNodes()
                        FsaddTargetNodes()
                          PlayInstructions()
                          //play background music
                          playBackgroundMusic()
                        //  addTargetNodesJupitar()
                          //start tinmer
                          runTimer()
                    print("\(Coins): still on level 1")
   
                }
      //  stopBackgroundMusic()
    }
    
    // MARK: - missiles & targets
    
    //creates banana or axe node and 'fires' it
    func fireMissile(type : String){
        var node = SCNNode()
            //create node
        //Finish last level, new music and new ships. Dope
            node = createMissile(type: type)
   
            let (direction, position) = self.getUserVector()
            node.position = position
            var nodeDirection = SCNVector3()
            switch type {
            case "banana":
                nodeDirection  = SCNVector3(direction.x*40,direction.y*40,direction.z*40)
                node.physicsBody?.applyForce(nodeDirection, at: SCNVector3(0.1,0,0), asImpulse: true)
                playSound(sound: "JBsmartsound", format: "mp3")
                
                //this stronger make a lot easier this should be temporary and rewarded after a certain level
                //or destroying enemy ship/s JBsmartsound.mp3
            case "axe":
                nodeDirection  = SCNVector3(direction.x*40,direction.y*40,direction.z*40)
                node.physicsBody?.applyForce(SCNVector3(direction.x,direction.y,direction.z), at: SCNVector3(0,0,0.1), asImpulse: true)
                playSound(sound: "JBsmartsound", format: "mp3")
            default:
                nodeDirection = direction
            }
            
            //move node
            node.physicsBody?.applyForce(nodeDirection , asImpulse: true)
            
            //add node to scene
            sceneView.scene.rootNode.addChildNode(node)
        }
        
    //creates nodes
    func createMissile(type : String)->SCNNode{
        var node = SCNNode(geometry: SCNSphere(radius: 0.2))
      //  var SuperNode = SCNNode(geometry: SCNCapsule(radius: 0.2))
        
        //get a feel for game difficulty and level base difficulty
        //next color coat ships
        //space ships around a little more..
        //more elaboratle explosion!!
        //new lasor sounds
        //add pop ups that gives instructions(eventually AFTER ads(reward ads!!)).. for levels and coin clamage or possibly in- app
        //next level open if win and more important coins..that can unlock new levels or just in- app
        //two new ideas for levels.... 1) have a little faster and maybe less ships
              
              //using case statement to allow variations of scale and rotations
        
              switch type {
              case "banana":
//                  let scene = SCNScene(named: "art.scnassets/missile.dae")
//                  node = (scene?.rootNode.childNode(withName: "missile", recursively: true)!)!
//                  node.scale = SCNVector3(0.2,0.2,0.2)
                node .geometry?.firstMaterial?.diffuse.contents = UIColor.red
                 node.name = "bathtub"
                //  node.name = "banana"
              case "axe":
                
//                  let scene = SCNScene(named: "art.scnassets/missile.dae")
//                  node = (scene?.rootNode.childNode(withName: "missile", recursively: true)!)!
//                  node.scale = SCNVector3(0.2,0.2,0.2)
                node .geometry?.firstMaterial?.diffuse.contents = UIColor.blue
                  node.name = "bathtub"
              default:
                  node = SCNNode()
              }
              
              //the physics body governs how the object interacts with other objects and its environment
              node.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
              node.physicsBody?.isAffectedByGravity = false
              
              //these bitmasks used to define "collisions" with other objects
              node.physicsBody?.categoryBitMask = CollisionCategory.missileCategory.rawValue
              node.physicsBody?.collisionBitMask = CollisionCategory.targetCategory.rawValue
              return node
          }
    
    //Adds 100 objects to the scene, spins them, and places them at random positions around the player.
    func addTargetNodes(){
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
                                  let msun = SCNNode(geometry: SCNSphere(radius: 0.15))
          let earthParent = SCNNode()
        let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.2 ,0 , 0))
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
                                                     Shoonode.name = "SS1copy.scn"
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
                    nodeArray.append(Shoonode)
                 //   nodeArray.append(ShoonodeSec)
                    ThirdGroupNodeArray.append(FourthShoonode)
                   SSnodeArray.append(ssShoonode)
                    SecGroupNodeArray.append(ssThShoonode)
                    EarGroupNodeArray.append(earth)
                    EarGroupNodeArray.append(earthParent)

                    Shoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.9),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.5))
                       
                    
                    //changed this one!!!
                    ssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.3), randomFloat(min: -0.8, max: 0.9))
                    
                    
           
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

   

                           let SecRotation = XRotation(time: 300)
                      let SecRo = XRotation(time: 6)
                              let sunAction = Rotation(time: 20)
                            let earthParentRotation = Rotation(time: 10)
                    let VRotation = Rotation(time: 6)
                            let venusParentRotation = XRotation(time: 20)
                            let earthRotation = Rotation(time: 20)
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
    
    
    
    func addTargetNodesFour(){
        //Need message dont shoot moon.
        //if so planet and moon destroyed

                                        let venusParent = SCNNode()
                                      let msun = SCNNode(geometry: SCNSphere(radius: 0.15))
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
        moonParent.name = "moon"
        moonn.name = "moonnn"
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
                        

                           // let moonParent = SCNNode()
          
                       if (index > 1) && (index % 3 == 0) {
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
                                                         Shoonode.name = "SS1copy.scn"
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
                        nodeArray.append(Shoonode)
                     //   nodeArray.append(ShoonodeSec)
                        ThirdGroupNodeArray.append(FourthShoonode)
                       SSnodeArray.append(ssShoonode)
                        SecGroupNodeArray.append(ssThShoonode)
                        EarGroupNodeArray.append(earth)
                        EarGroupNodeArray.append(earthParent)

                Shoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.9),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.5))
                                             
                                          
                                          //changed this one!!!
                                          ssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.3), randomFloat(min: -0.8, max: 0.9))
                                          
                                          
                                 
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

       

                               let SecRotation = XRotation(time: 300)
                          let SecRo = XRotation(time: 6)
                                  let sunAction = Rotation(time: 20)
                                let earthParentRotation = Rotation(time: 10)
                        let VRotation = Rotation(time: 6)
                                let venusParentRotation = XRotation(time: 20)
                                let earthRotation = Rotation(time: 30)
                                let moonRotation = Rotation(time: 18)
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
        
    func addTargetNodesFive(){
           //Need message dont shoot moon.
           //if so planet and moon destroyed
        //wrked on level 4 and 5(migh get rid of moon)

                                           let venusParent = SCNNode()
                                         let sun = SCNNode(geometry: SCNSphere(radius: 0.25))
        sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Sun diffuse")
               sun.position = SCNVector3(0,0,-1)
                 let earthParent = SCNNode()
            let moonParent = SCNNode()
           
               let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.8 ,0 , 0))
        let EarParent = SCNNode()
        EarParent.position = SCNVector3(0,0,-1)
              let moon = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "moon Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0,0,-0.3))
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
                       for index in 0...6 {
                          
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
             
                          if (index > 1) && (index % 3 == 0) {
              
                           
                           
                              let scene = SCNScene(named: "art.scnassets/spaceGreen.scn")
                                                ShoonodeG = (scene?.rootNode.childNode(withName: "spaceGreenn", recursively: true)!)!
                                                         ShoonodeG.scale = SCNVector3(0.03,0.03,0.03)
                                                        ShoonodeG.name = "shark"
                                     }else{
        
                          let scene = SCNScene(named: "art.scnassets/missilecopy.scn")
                                                           Shoonode = (scene?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
                                                            Shoonode.scale = SCNVector3(0.03,0.03,0.03)
                                                            Shoonode.name = "SS1copy.scn"
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

                           nodeArray.append(Shoonode)
                        //   nodeArray.append(ShoonodeSec)
                           ThirdGroupNodeArray.append(FourthShoonode)
                          SSnodeArray.append(ssShoonode)
                           SecGroupNodeArray.append(ssThShoonode)
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

          

                                  let SecRotation = XRotation(time: 300)
                         let GreenSecRo = XRotation(time: 4)
                             let SecRo = XRotation(time: 6)
                                     let sunAction = Rotation(time: 20)
                                   let earthParentRotation = Rotation(time: 20)
                        
                        let JRotation = Rotation(time: 15)
                        let JRRotation = Rotation(time: 5)
                        let VJRotation = Rotation(time: 25)
                           let VRotation = Rotation(time: 6)
                                   let venusParentRotation = XRotation(time: 20)
                                   let earthRotation = Rotation(time: 30)
                                   let moonRotation = Rotation(time: 10)
                           // decent rotations a bit to easy.. need to make harder to kill big blue and red--show blast hitting maybe with fire but instead ship dont disappear
//                        let sunAction = Rotation(time: 20)
//                                               let earthParentRotation = Rotation(time: 10)
//                                       let VRotation = Rotation(time: 6)
                             //  make big ships spin as it Rotate
                        Shoonode.runAction(SecRo)
                        ShoonodeG.runAction(GreenSecRo)
                          //                  //  ShoonodeSec.runAction(SecRotation)
                                             ssShoonode.runAction(SecRotation)
                          //                    //FourthShoonode
                                             ssThShoonode.runAction(SecRotation)
                                              FourthShoonode.runAction(SecRotation)
                         //  Shoonode.runAction(SecRo)
       //                  //  ShoonodeSec.runAction(SecRotation)
                        //  ssShoonode.runAction(SecRo)
                        EarParent.runAction(JRotation)
       //                    //FourthShoonode
                        //  ssThShoonode.runAction(SecRotation)
                        //   FourthShoonode.runAction(SecRotation)
       //                        ssThShoonode
                                  earthParent.runAction(earthParentRotation)
                                  venusParent.runAction(VRotation)
                                  moonParent.runAction(moonRotation)

                                  
                                  earth.runAction(JRRotation)
                        sun.runAction(sunAction)
                          // earthParent.addChildNode(venusParent)
//                           venusParent.addChildNode(Shoonode)
                           
                           ////****** and ven name*/
                              //    earthParent.addChildNode(Shoonode)
                          // earthParent.addChildNode(ShoonodeSec)
                        sun.addChildNode(earth)
                         sun.addChildNode(earthParent)
                        sun.addChildNode(EarParent)
                        // earthParent.addChildNode(Shoonode)
                           earth.addChildNode(ssShoonode)
                        earth.addChildNode(ShoonodeG)
                        //earth.addChildNode(EarParent)
                         //  ssThShoonode.addChildNode(ssShoonode)
                          earthParent.addChildNode(Shoonode)
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
           
    func addTargetNodesSixVenus(){
               //Need message dont shoot moon.
               //if so planet and moon destroyed
        //Make ships move on dif speeds llke earlter

                                               let venusParent = SCNNode()
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
                           for index in 0...3 {
                              
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
                 
                              if (index > 1) && (index % 3 == 0) {
                          
                               
                               
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
                                                                Shoonode.name = "SS1copy.scn"
                                
                                let scenee = SCNScene(named: "art.scnassets/missilecopy.scn")
                                                                                             VenShoonode = (scenee?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
                                                                                              VenShoonode.scale = SCNVector3(0.03,0.03,0.03)
                                                                                              VenShoonode.name = "SS1copy.scn"
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
                              VenShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
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
                               nodeArray.append(Shoonode)
                            //   nodeArray.append(ShoonodeSec)
                               ThirdGroupNodeArray.append(FourthShoonode)
                              SSnodeArray.append(ssShoonode)
                               SecGroupNodeArray.append(ssThShoonode)
                               EarGroupNodeArray.append(earth)
                               EarGroupNodeArray.append(earthParent)
                            nodeArray.append(VenShoonode)
                                                      //   nodeArray.append(ShoonodeSec)
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

              

                                         let SecRotation = XRotation(time: 300)
                        let SecRo = XRotation(time: 2)
                                let JRRotation = Rotation(time: 5)
                                                                                         
                            let sunAction = Rotation(time: 29)
                          //let venusRotation = Rotation(time: 9)                               // complete level 9 JRotation = Rotation(time: 15)
                    let sunActionS = Rotation(time: 12)
                                                                                         
                                                                                         
                    let sunActionVenus = Rotation(time: 30)
                        let sunActionNep = Rotation(time: 13)
                    let sunActionJ = Rotation(time: 11)
                                                         let sunActionEar = Rotation(time: 12)
                                let earthParentRotation = Rotation(time: 20)
                                    let VRotation = Rotation(time: 15)
                                    let venusParentRotation = XRotation(time: 30)
                                    let earthRotation = Rotation(time: 30)
                                    let moonRotation = Rotation(time: 10)
                                let venusRotation = Rotation(time: 9)
                                let JupRotation = Rotation(time: 8)
                                                                                           let JRotation = Rotation(time: 15)
           Shoonode.runAction(SecRotation)
                            
                                                            //                  //  ShoonodeSec.runAction(SecRotation)
            ssShoonode.runAction(SecRotation)
                                                                          
                                                            //                    //FourthShoonode
            ssThShoonode.runAction(SecRotation)
                                        FourthShoonode.runAction(SecRotation)
                               venusParentSun.runAction(sunActionVenus)
                            //Ven added
                            VenShoonode.runAction(SecRotation)
                                                                                     //                  //  ShoonodeSec.runAction(SecRotation)
                                        VenssShoonode.runAction(SecRotation)
                             
                                                                                     //                    //FourthShoonode
                                VenssThShoonode.runAction(SecRotation)
                            VenFourthShoonode.runAction(SecRotation)
                            
                            
           //                        ssThShoonode
                                      earthParent.runAction(JRotation)
                                      venusParent.runAction(JRotation)
                    
                                      moonParent.runAction(moonRotation)
                                     venus.runAction(venusRotation)
                                       //venusParent.addChildNode(venus)
                                    
                            //stable rotations
                            sun.runAction(sunAction)
                              earth.runAction(venusRotation)
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
                                                                 let JRRotation = Rotation(time: 5)
                                                                
                                                                             let sunAction = Rotation(time: 19)
                                // complete level 9
                                 let sunActionS = Rotation(time: 12)
                                                                
                                                          let sunActionVenus = Rotation(time: 30)
                                              //  let sunActionVenus = Rotation(time: 25)
                                        let sunActionNep = Rotation(time: 13)
                                    let sunActionJ = Rotation(time: 11)
                                let sunActionEar = Rotation(time: 12)
                                            let earthParentRotation = Rotation(time: 20)
                                                                   let VRotation = Rotation(time: 15)
                                                                           let venusParentRotation = XRotation(time: 30)
                                                let earthRotation = Rotation(time: 30)
                                                                           let moonRotation = Rotation(time: 10)
                                                                 let venusRotation = Rotation(time: 9)
                                                    let JupRotation = Rotation(time: 8)
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
                                                                            let moon = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "moon Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0,0,-0.3))
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
                                                                                     for index in 0...3 {
                                                                                        
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
                                                                           
                                                                                        if (index > 1) && (index % 3 == 0) {
                                                                                    
                                                                                         
                                                                                         
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

                                                                        

                                                                                                   let SecRotation = XRotation(time: 300)
                                                                                  let SecRo = XRotation(time: 2)
                                                                                          let JRRotation = Rotation(time: 5)
                                                                                                                                                   
                                                                                      let sunAction = Rotation(time: 29)
                                                                                    //let venusRotation = Rotation(time: 9)                               // complete level 9 JRotation = Rotation(time: 15)
                                                                              let sunActionS = Rotation(time: 12)
                                                                                                                                                   
                                                                                                                                                   
                                                                              let sunActionVenus = Rotation(time: 30)
                                                                                  let sunActionNep = Rotation(time: 13)
                                                                              let sunActionJ = Rotation(time: 11)
                                                                                                                   let sunActionEar = Rotation(time: 12)
                                                                                          let earthParentRotation = Rotation(time: 20)
                                                                                              let VRotation = Rotation(time: 15)
                                                                                              let venusParentRotation = XRotation(time: 30)
                                                                                              let earthRotation = Rotation(time: 30)
                                                                                              let moonRotation = Rotation(time: 10)
                                                                                          let venusRotation = Rotation(time: 9)
                                                                                          let JupRotation = Rotation(time: 8)
                                                                                                                                                     let JRotation = Rotation(time: 15)
                                                                     Shoonode.runAction(SecRotation)
                                                                                      
                                                                                                                      //                  //  ShoonodeSec.runAction(SecRotation)
                                                                                        //Sa
                                                                                                                                           SaShoonode.runAction(SecRotation)
                                                                                                                                                                                //                  //  ShoonodeSec.runAction(SecRotation)
                                                                                                                                                                                                   SAssShoonode.runAction(SecRotation)
                                                                                                                                                                                                 
                                                                                                                                                                                //                    //FourthShoonode
                                                                                                                                                                                                   SassThShoonode.runAction(SecRo)
                                                                                                                                                                                                    SaFourthShoonode.runAction(SecRotation)
                                                                      ssShoonode.runAction(SecRotation)
                                                                                                                                    
                                                                                                                      //                    //FourthShoonode
                                                                      ssThShoonode.runAction(SecRotation)
                                                                                                  FourthShoonode.runAction(SecRotation)
                                                                                         venusParentSun.runAction(sunActionVenus)
                                                                                      //Ven added
                                                                                      VenShoonode.runAction(SecRotation)
                                                                                                                                               //                  //  ShoonodeSec.runAction(SecRotation)
                                                                                                  VenssShoonode.runAction(SecRotation)
                                                                                       
                                                                                                                                               //                    //FourthShoonode
                                                                                          VenssThShoonode.runAction(SecRotation)
                                                                                      VenFourthShoonode.runAction(SecRotation)
                                                                                      
                                                                                      
                                                                     //                        ssThShoonode
                                                                                                earthParent.runAction(JRotation)
                                                                                                venusParent.runAction(JRotation)
                                                                              
                                                                                                moonParent.runAction(moonRotation)
                                                                                               venus.runAction(venusRotation)
                                                                                                 //venusParent.addChildNode(venus)
                                                                                              
                                                                                      //stable rotations
                                                                                      sun.runAction(sunAction)
                                                                                        earth.runAction(venusRotation)
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
                                                                                                                SaturnParent.runAction(JRotation)
                                                                                                                SaturnParentSun.addChildNode(SaturnParent)
                                                                                                            SaturnParentSun.addChildNode(saturn)
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
       
                     // let JupitarRing = createRing(ringSize: 0.3)
                                                   // let jupiter = createPlanet(radius: 0.33, image: "jupiter")
                                                         //      jupiter.name = "zoom"
                                                 //  jupiter.position = SCNVector3(x:1.6 , y: 0, z: 0)
                                                   // rotateObject(rotation: 0.01, planet:  jupiter, duration: 0.4)
                                                   // rotateObject(rotation: 0.01, planet: JupitarRing, duration: 1)
                                        
                                        let neptuneRing = createRing(ringSize: 0.3)
                                               let neptune = createPlanet(radius: 0.23, image: "neptune")
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
                                                                       let earthParent = SCNNode()
                                                                  let moonParent = SCNNode()
                                                                 
                                                                     let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.8 ,0 , 0))
                                               let saturnRing = createRing(ringSize: 0.3)
                                                     let saturn = createPlanet(radius: 0.2, image: "saturn")
                                                     saturn.name = "saturn"
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
                                                                      earthParent.name = "earthParent"
                                                          //where the relationships between earth and earthParent
                              //perfect distance of planets
                              earth.position = SCNVector3(1.8,0,0)
                              earthParent.position = SCNVector3(1.8,0,0)
                                                //better rotations..nice positions
                                               saturn.position = SCNVector3(-2.5,0,0)
                                               SaturnParent.position = SCNVector3(-2.5,0,0)
                              neptune.position = SCNVector3(0,0,3.5)
                              neptuneParent.position = SCNVector3(0,0,3.5)
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
                                                            
                                            for index in 0...3 {
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
                                                                              let SpaceShscenee = SCNScene(named: "art.scnassets/SS1copy.scn")
                      //                                                                                                              VenShoonode = (SpaceShscenee?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                                                                     //VenShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                          //  ssShoonode.
                                                                                                            //VenShoonode.name = "shark"
                                                                                                            //second one
                                                  //                                                          var VenssShoonode = SCNNode()
                                                                              
                                                                              let Spacehscenev = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                                                                  //VenssThShoonode = (Spacehscenev?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                                                                   //VenssThShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                          //VenssThShoonode.name = "shark"
                                                  //                                                                                                                              var VenssThShoonode = SCNNode()
                                                  //                                                                                                                              var VenFourthShoonode = SCNNode()
                                                                              
                                                                                                            let Spacehscener = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                                                                    //VenssShoonode  = (Spacehscener?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                                                                     //VenssShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                            //VenssShoonode .name = "shark"
                                                                                                            // third one
                                                                                                            
                                                                                                            let SpacehFscenea = SCNScene(named: "art.scnassets/SS1copy.scn")
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
                                                                   
                                                                                if (index > 1) && (index % 3 == 0) {
                                                                            
                                                                                 
                                                                                 //ear
                                                  let scene = SCNScene(named: "art.scnassets/spaceGreen.scn")
                                          Shoonode = (scene?.rootNode.childNode(withName: "spaceGreenn", recursively: true)!)!
                                                      Shoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                              Shoonode.name = "ha"
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
                                                                                                                                                                                                        NepShoonode.name = "ha"
                                                                                  
                                                                                  
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
                                                                                                                  Shoonode.name = "SS1copy.scn"
                      //                                                            //ven
                      //                                                            let scenee = SCNScene(named: "art.scnassets/missilecopy.scn")
                      //                                                                                                                         VenShoonode = (scenee?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
                      //                                                                                                                          VenShoonode.scale = SCNVector3(0.02,0.02,0.02)
                      //                                                                                                                          VenShoonode.name = "SS1copy.scn"
                                                                                   //sa
                                                      let sceneb = SCNScene(named: "art.scnassets/missilecopy.scn")
                                          SaShoonode = (sceneb?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
                                          SaShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                  SaShoonode.name = "SS1copy.scn"
                                                          //nep

                                              let scenebn = SCNScene(named: "art.scnassets/missilecopy.scn")
                                  NepShoonode = (scenebn?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
                                  NepShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                              NepShoonode.name = "SS1copy.scn"
                                                                                  
                                                                                  
                                                                                  
                                                                                  
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
                                              //Jup
//                                              JupShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
//                                                  JupShoonode.physicsBody?.isAffectedByGravity = false
//                                              JupssThShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
//                                                  JupssThShoonode.physicsBody?.isAffectedByGravity = false
//
//
//
//                                      JupssShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
//                                      JupssShoonode.physicsBody?.isAffectedByGravity = false
//                                      JupFourthShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
//                                          JupFourthShoonode.physicsBody?.isAffectedByGravity = false
//
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

//                                             jupiter.addChildNode(JupShoonode)
//                                             jupiter.addChildNode(JupssShoonode)
//                                          jupiter.addChildNode(JupssThShoonode)
//                                          jupiter.addChildNode(JupFourthShoonode)
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
                                              //Jupitar
//                                              nodeArray.append(JupShoonode)
//                                                                                                  //   nodeArray.append(ShoonodeSec)
//                                                                                                     ThirdGroupNodeArray.append(JupFourthShoonode)
//                                                                                                    SSnodeArray.append(JupssShoonode)
//                                                                                                     SecGroupNodeArray.append(JupssThShoonode)
//                                                                                                     EarGroupNodeArray.append(jupiter)
//                                                                                                     EarGroupNodeArray.append(JupitarParent)
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
                                                                                nodeArray.append(SaShoonode)
                                                                               ThirdGroupNodeArray.append(SaFourthShoonode)
                                                                               SSnodeArray.append(SAssShoonode)
                                                                                SecGroupNodeArray.append(SassThShoonode)
                                                                               // EarGroupNodeArray.append(earth)
                                                                               // EarGroupNodeArray.append(earthParent)
                                                                                //nep*
                                                                                nodeArray.append(NepShoonode)
                                          ThirdGroupNodeArray.append(NepFourthShoonode)
                                      SSnodeArray.append(NepssShoonode)
                                          SecGroupNodeArray.append(NepssThShoonode)
                                      EarGroupNodeArray.append(neptune)
                                                                                                                             EarGroupNodeArray.append(neptuneParent)

                                              
                                              Shoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.9),randomFloat(min: -0.8, max: 0.9), randomFloat(min: 0.1, max: 0.5))
                                                                                         
                                                                                      
                                                                                      //changed this one!!!
                                          ssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.9), randomFloat(min: -0.8, max: 0.9))
                                                                                      
                                                                                      
                                                                             
                                          ssThShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                                              FourthShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                                                                                         
                                              //new Jup
//                                              JupShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.9),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.5))
//
//
//                                                                                                             //changed this one!!!
//                                                  JupssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.3), randomFloat(min: -0.8, max: 0.9))
//
//
//                              JupssThShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
//                                      JupFourthShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                                               
                                              
                                                                                 
                                                                                 
                                                                                   //Ven
                                              
                                                                              
                      //                                                          VenShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.3))
                      //
                      //
                      //                                                                                                                      //changed this one!!!
                      //                                                                                                                      VenssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.3), randomFloat(min: -0.8, max: 0.3))
                      //
                      //
                      //
                      //                                                                                                                      VenssThShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.3))
                      //                                                                                                                       VenFourthShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.3))
                                                                                                            
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
                      //                                                           self.sceneView.scene.rootNode.addChildNode(VenShoonode)
                      //                                                        self.sceneView.scene.rootNode.addChildNode(VenssShoonode)
                      //                                                                                       self.sceneView.scene.rootNode.addChildNode(VenssThShoonode)
                      //                                                                                      self.sceneView.scene.rootNode.addChildNode(VenFourthShoonode)
                                              
                                              //Jup
//                                              self.sceneView.scene.rootNode.addChildNode(JupShoonode)
//                                              self.sceneView.scene.rootNode.addChildNode(JupssShoonode)
//                                                      self.sceneView.scene.rootNode.addChildNode(JupssThShoonode)
//                                                      self.sceneView.scene.rootNode.addChildNode(JupFourthShoonode)
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

                                                                                        let SecRotation = XRotation(time: 300)
                                                                                   let SecRo = XRotation(time: 2)
                                                                               let JRRotation = Rotation(time: 5)
                                                //got nep working
                                                                              
                                                                                           let sunAction = Rotation(time: 19)
                                              // complete level 9
                                               let sunActionS = Rotation(time: 12)
                                                                              
                                                                              
                                                              let sunActionVenus = Rotation(time: 25)
                                                      let sunActionSS = Rotation(time: 19)
                                                  let sunActionJ = Rotation(time: 11)
                                              let sunActionEar = Rotation(time: 12)
                                                          let earthParentRotation = Rotation(time: 20)
                                                                                 let VRotation = Rotation(time: 15)
                                                                                         let venusParentRotation = XRotation(time: 30)
                                                              let earthRotation = Rotation(time: 30)
                                                                                         let moonRotation = Rotation(time: 10)
                                                                               let venusRotation = Rotation(time: 9)
                                                                  let JupRotation = Rotation(time: 8)
                                                                                let JRotation = Rotation(time: 5)
                                                                                 Shoonode.runAction(SecRotation)
                                                             //                  //  ShoonodeSec.runAction(SecRotation)
                                                                                ssShoonode.runAction(SecRotation)
                                                                           
                                                             //                    //FourthShoonode
                                                                                ssThShoonode.runAction(SecRo)
                                                                                 FourthShoonode.runAction(SecRotation)
                                                                                    
               
                                                                                NepShoonode.runAction(SecRotation)
                                                                                                          //                  //  ShoonodeSec.runAction(SecRotation)
                                                                                                                              NepssShoonode.runAction(SecRotation)
                                                                                                                        
                                                                                                          //                    //FourthShoonode
                                                                                                                              NepssThShoonode.runAction(SecRo)
                                                                                                                               NepFourthShoonode.runAction(SecRotation)
                                                                               //Sa
                                                                               SaShoonode.runAction(SecRotation)
                                                                                                                    //                  //  ShoonodeSec.runAction(SecRotation)
                                                                                                                                       SAssShoonode.runAction(SecRotation)
                                                                                                                                     
                                                                                                                    //                    //FourthShoonode
                                                                                                                                       SassThShoonode.runAction(SecRo)
                                                                                                                                        SaFourthShoonode.runAction(SecRotation)
                                                                              
                                                                              
                                                             //                        ssThShoonode
                                             // JupitarParentSun.runAction(sunAction)
                                                                               venusParentSun.runAction(sunAction)
                                                                                                                   //SaturnParentSun.runAction(sunAction)
                                              
                                              SaturnParentSun.runAction(sunActionSS)
                                              SaturnParent.runAction(JRotation)
                                              SaturnParentSun.addChildNode(SaturnParent)
                                          SaturnParentSun.addChildNode(saturn)
                                      saturn.addChildNode(saturnRing)
                                      saturn.addChildNode(SAssShoonode)
                                  SaturnParent.addChildNode(SaShoonode)
                                                                                                                                  //  ssThShoonode.addChildNode(ssShoonode)
                      SaturnParent.addChildNode(SassThShoonode)
                          SaturnParent.addChildNode(SaFourthShoonode)
                                              
                                                                                neptuneParentSun.runAction(sunAction)
                                                                                        earthParent.runAction(JRotation)
                                                                                      neptuneParent.runAction(JRotation)
                                                                              //JupitarParent.runAction(JRotation)
                                                                                SaturnParent.runAction(JRotation)
                                                                                        venusParent.runAction(JRotation)
                                                                                        moonParent.runAction(moonRotation)
                                                                                       //venus.runAction(venusRotation)
                                                                            neptune.runAction(venusRotation)
                                                                              //jupiter.runAction(JupRotation)
                                                                                         //venusParent.addChildNode(venus)
                                                                                        earth.runAction(sunAction)
                                                                              sun.runAction(sunAction)
                                                                                neptune.addChildNode(neptuneRing)
                                                                                neptuneParentSun.addChildNode(neptuneParent)
                                                                                neptuneParentSun.addChildNode(neptune)
                                                                                          
                                              
                                                                                          //Jupitar
                                              
                                                                                  
                                              
                                                                              //figured out how distribute ships will have to create more Shoonodes
                                                                              //can be elaborate with given planets diff rotations since its
                                                                              sun.addChildNode(earth)
                                                                               sun.addChildNode(earthParent)
                                                                              //venusParent.addChildNode(venus)
                                                                           //   venusParentSun.addChildNode(venusParent)
                                                                               
                                                                              //added venus and planets
                                                                           //   venusParentSun.addChildNode(venus)
                                                                               SaturnParentSun.addChildNode(SaturnParent)
                                                                                     SaturnParentSun.addChildNode(saturn)
                                                                                saturn.addChildNode(saturnRing)
                                                                               //ear
                                                                              earth.addChildNode(ssShoonode)
                                                                                 earthParent.addChildNode(Shoonode)
                                                                               //  ssThShoonode.addChildNode(ssShoonode)
                                                                                 earthParent.addChildNode(ssThShoonode)
                                                                                 earthParent.addChildNode(FourthShoonode)
                                                                          //Jupitar
                                              
//                                                                                                  jupiter.addChildNode(JupssShoonode)
//                                                                                                        JupitarParent.addChildNode(JupShoonode)
//                                                                                                      //  ssThShoonode.addChildNode(ssShoonode)
//                                                                                                        JupitarParent.addChildNode(JupssThShoonode)
//                                                                                                        JupitarParent.addChildNode(JupFourthShoonode)
                              
                                              
                                              
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
    
    
    
    
    func addTargetNodesJupitar(){
        
           
                          //Need message dont shoot moon.
                          //if so planet and moon destroyed
                   //Make ships move on dif speeds llke earlter
              let JupitarRing = createRing(ringSize: 0.3)
                              let jupiter = createPlanet(radius: 0.33, image: "jupiter")
                                         jupiter.name = "zoom"
                             jupiter.position = SCNVector3(x:1.6 , y: 0, z: 0)
                              rotateObject(rotation: 0.01, planet:  jupiter, duration: 0.4)
                              rotateObject(rotation: 0.01, planet: JupitarRing, duration: 1)
                  
                  let neptuneRing = createRing(ringSize: 0.3)
                         let neptune = createPlanet(radius: 0.23, image: "neptune")
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
                                                 let earthParent = SCNNode()
                                            let moonParent = SCNNode()
                                           
                                               let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.8 ,0 , 0))
                         let saturnRing = createRing(ringSize: 0.3)
                               let saturn = createPlanet(radius: 0.2, image: "saturn")
                               saturn.name = "saturn"
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
                                                earthParent.name = "earthParent"
                                    //where the relationships between earth and earthParent
        //perfect distance of planets
        earth.position = SCNVector3(1.8,0,0)
        earthParent.position = SCNVector3(1.8,0,0)
                          //better rotations..nice positions
                         saturn.position = SCNVector3(-2.5,0,0)
                         SaturnParent.position = SCNVector3(-2.5,0,0)
        neptune.position = SCNVector3(0,0,3.5)
        neptuneParent.position = SCNVector3(0,0,3.5)
        jupiter.position = SCNVector3(0,0,-2.9)
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
                                      
                      for index in 0...3 {
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
                                                        
                                                        
                                                        
                                                        //Ven
                                                        let SpaceShscenee = SCNScene(named: "art.scnassets/SS1copy.scn")
//                                                                                                              VenShoonode = (SpaceShscenee?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                                               //VenShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                    //  ssShoonode.
                                                                                      //VenShoonode.name = "shark"
                                                                                      //second one
                            //                                                          var VenssShoonode = SCNNode()
                                                        
                                                        let Spacehscenev = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                                            //VenssThShoonode = (Spacehscenev?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                                             //VenssThShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                    //VenssThShoonode.name = "shark"
                            //                                                                                                                              var VenssThShoonode = SCNNode()
                            //                                                                                                                              var VenFourthShoonode = SCNNode()
                                                        
                                                                                      let Spacehscener = SCNScene(named: "art.scnassets/SS1copy.scn")
                                                                                                              //VenssShoonode  = (Spacehscener?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                                                                                               //VenssShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                      //VenssShoonode .name = "shark"
                                                                                      // third one
                                                                                      
                                                                                      let SpacehFscenea = SCNScene(named: "art.scnassets/SS1copy.scn")
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
                                             
                                                          if (index > 1) && (index % 3 == 0) {
                                                      
                                                           
                                                           //ear
                            let scene = SCNScene(named: "art.scnassets/spaceGreen.scn")
                    Shoonode = (scene?.rootNode.childNode(withName: "spaceGreenn", recursively: true)!)!
                                Shoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                        Shoonode.name = "ha"
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
                                                                                                                                                                                  NepShoonode.name = "ha"
                                                            
                                                            
                            let scenennk = SCNScene(named: "art.scnassets/spaceGreen.scn")
                JupShoonode = (scenennk?.rootNode.childNode(withName: "spaceGreenn", recursively: true)!)!
                                                                                                                                       
                        JupShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                                                                                                                                                             JupShoonode.name = "ha"
                                                            
                                                                                                    
                                                            
                                                                     }else{
                                                            //ear
                            let scene = SCNScene(named: "art.scnassets/missilecopy.scn")
            Shoonode = (scene?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
                                                    Shoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                            Shoonode.name = "SS1copy.scn"
//                                                            //ven
//                                                            let scenee = SCNScene(named: "art.scnassets/missilecopy.scn")
//                                                                                                                         VenShoonode = (scenee?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
//                                                                                                                          VenShoonode.scale = SCNVector3(0.02,0.02,0.02)
//                                                                                                                          VenShoonode.name = "SS1copy.scn"
                                                             //sa
                                let sceneb = SCNScene(named: "art.scnassets/missilecopy.scn")
                    SaShoonode = (sceneb?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
                    SaShoonode.scale = SCNVector3(0.02,0.02,0.02)
                            SaShoonode.name = "SS1copy.scn"
                                    //nep

                        let scenebn = SCNScene(named: "art.scnassets/missilecopy.scn")
            NepShoonode = (scenebn?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
            NepShoonode.scale = SCNVector3(0.02,0.02,0.02)
                        NepShoonode.name = "SS1copy.scn"
                                                            
                                                            
                                                            
                                                            
        let scenebe = SCNScene(named: "art.scnassets/missilecopy.scn")
        JupShoonode = (scenebe?.rootNode.childNode(withName: "SS1Bcopy", recursively: true)!)!
        JupShoonode.scale = SCNVector3(0.02,0.02,0.02)
                                                                                                                                                                                             JupShoonode.name = "SS1copy.scn"
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
                                                           nodeArray.append(Shoonode)
                                                        //   nodeArray.append(ShoonodeSec)
                                                           ThirdGroupNodeArray.append(FourthShoonode)
                                                          SSnodeArray.append(ssShoonode)
                                                           SecGroupNodeArray.append(ssThShoonode)
                                                           EarGroupNodeArray.append(earth)
                                                           EarGroupNodeArray.append(earthParent)
                        //Jupitar
                        nodeArray.append(JupShoonode)
                                                                            //   nodeArray.append(ShoonodeSec)
                                                                               ThirdGroupNodeArray.append(JupFourthShoonode)
                                                                              SSnodeArray.append(JupssShoonode)
                                                                               SecGroupNodeArray.append(JupssThShoonode)
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
                                                          nodeArray.append(SaShoonode)
                                                         ThirdGroupNodeArray.append(SaFourthShoonode)
                                                         SSnodeArray.append(SAssShoonode)
                                                          SecGroupNodeArray.append(SassThShoonode)
                                                         // EarGroupNodeArray.append(earth)
                                                         // EarGroupNodeArray.append(earthParent)
                                                          //nep*
                                                          nodeArray.append(NepShoonode)
                    ThirdGroupNodeArray.append(NepFourthShoonode)
                SSnodeArray.append(NepssShoonode)
                    SecGroupNodeArray.append(NepssThShoonode)
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
                         
                        
                                                           
                                                           
                                                             //Ven
                        
                                                        
//                                                          VenShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.3))
//
//
//                                                                                                                      //changed this one!!!
//                                                                                                                      VenssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.3), randomFloat(min: -0.8, max: 0.3))
//
//
//
//                                                                                                                      VenssThShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.3))
//                                                                                                                       VenFourthShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.3))
                                                                                      
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
                        
//                                                         //Ven
//                                                        VenShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
//                VenShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
//
//                VenssShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
//                VenssShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
//                VenssThShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
//                VenssThShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
//                VenFourthShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
//                                                                                        VenFourthShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
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

                                                                  let SecRotation = XRotation(time: 300)
                                                             let SecRo = XRotation(time: 2)
                                                         let JRRotation = Rotation(time: 5)
                                                        
                                                                     let sunAction = Rotation(time: 75)
                        // complete level 9
                         let sunActionS = Rotation(time: 12)
                                                        
                                                        
                                        let sunActionVenus = Rotation(time: 25)
                                let sunActionNep = Rotation(time: 13)
                            let sunActionJ = Rotation(time: 11)
                        let sunActionEar = Rotation(time: 12)
                                    let earthParentRotation = Rotation(time: 20)
                                                           let VRotation = Rotation(time: 15)
                                                                   let venusParentRotation = XRotation(time: 30)
                                        let earthRotation = Rotation(time: 30)
                                                                   let moonRotation = Rotation(time: 10)
                                                         let venusRotation = Rotation(time: 9)
                                            let JupRotation = Rotation(time: 8)
                                                          let JRotation = Rotation(time: 5)
                                                           Shoonode.runAction(SecRotation)
                                       //                  //  ShoonodeSec.runAction(SecRotation)
                                                          ssShoonode.runAction(SecRotation)
                                                     
                                       //                    //FourthShoonode
                                                          ssThShoonode.runAction(SecRo)
                                                           FourthShoonode.runAction(SecRotation)
                                                              
                        //Jup
                                                                    JupShoonode.runAction(SecRotation)
                                                        
                                                                        JupssShoonode.runAction(SecRotation)
                                                                         
                                                           //                    //FourthShoonode
                                                                              JupssThShoonode.runAction(SecRo)
                                                                               JupFourthShoonode.runAction(SecRotation)
                                                        
//                                                        //Ven added
//                                                         VenShoonode.runAction(SecRotation)
//                                                        //                  //  ShoonodeSec.runAction(SecRotation)
//                                                                           VenssShoonode.runAction(SecRotation)
//
//                                                        //                    //FourthShoonode
//                                                                           VenssThShoonode.runAction(SecRo)
//                                                                            VenFourthShoonode.runAction(SecRotation)
                                                          //nep
                                                          NepShoonode.runAction(SecRotation)
                                                                                    //                  //  ShoonodeSec.runAction(SecRotation)
                                                                                                        NepssShoonode.runAction(SecRotation)
                                                                                                  
                                                                                    //                    //FourthShoonode
                                                                                                        NepssThShoonode.runAction(SecRotation)
                                                                                                         NepFourthShoonode.runAction(SecRotation)
                                                         //Sa
                                                         SaShoonode.runAction(SecRotation)
                                                                                              //                  //  ShoonodeSec.runAction(SecRotation)
                                                                                                                 SAssShoonode.runAction(SecRotation)
                                                                                                               
                                                                                              //                    //FourthShoonode
                                                                                                                 SassThShoonode.runAction(SecRo)
                                                                                                                  SaFourthShoonode.runAction(SecRotation)
                                                        
                                                        
                                       //                        ssThShoonode
                        JupitarParentSun.runAction(sunAction)
                                                         venusParentSun.runAction(sunAction)
                                                                                             SaturnParentSun.runAction(sunAction)
                        
                        SaturnParentSun.runAction(sunAction)
                        SaturnParent.runAction(JRotation)
                        SaturnParentSun.addChildNode(SaturnParent)
                    SaturnParentSun.addChildNode(saturn)
                saturn.addChildNode(saturnRing)
                saturn.addChildNode(SAssShoonode)
            SaturnParent.addChildNode(SaShoonode)
                                                                                                            //  ssThShoonode.addChildNode(ssShoonode)
SaturnParent.addChildNode(SassThShoonode)
    SaturnParent.addChildNode(SaFourthShoonode)
                        
                                                          neptuneParentSun.runAction(sunAction)
                                                                  earthParent.runAction(JRotation)
                                                                neptuneParent.runAction(JRotation)
                                                        JupitarParent.runAction(JRotation)
                                                          SaturnParent.runAction(JRotation)
                                                                  venusParent.runAction(JRotation)
                                                                  moonParent.runAction(moonRotation)
                                                                 //venus.runAction(venusRotation)
                                                      neptune.runAction(venusRotation)
                                                        jupiter.runAction(JupRotation)
                                                                   //venusParent.addChildNode(venus)
                                                                  earth.runAction(sunAction)
                                                        sun.runAction(sunAction)
                                                          neptune.addChildNode(neptuneRing)
                                                          neptuneParentSun.addChildNode(neptuneParent)
                                                          neptuneParentSun.addChildNode(neptune)
                                                                    
                        
                                                                    //Jupitar
                        
                                                            JupitarParentSun.addChildNode(jupiter)
                                                        JupitarParentSun.addChildNode(JupitarParent)
                                                    jupiter.addChildNode(JupitarRing)
                        
                                                        //figured out how distribute ships will have to create more Shoonodes
                                                        //can be elaborate with given planets diff rotations since its
                                                        sun.addChildNode(earth)
                                                         sun.addChildNode(earthParent)
                                                        //venusParent.addChildNode(venus)
                                                     //   venusParentSun.addChildNode(venusParent)
                                                         
                                                        //added venus and planets
                                                     //   venusParentSun.addChildNode(venus)
                                                         SaturnParentSun.addChildNode(SaturnParent)
                                                               SaturnParentSun.addChildNode(saturn)
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
        let saturnRing = createRing(ringSize: 1.2)
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
                                       let venusParentRotation = XRotation(time: 30)
                                       let earthRotation = Rotation(time: 30)
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

                                        let venusParent = SCNNode()
                                      let msun = SCNNode(geometry: SCNSphere(radius: 0.15))
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
                                let venusParentRotation = XRotation(time: 20)
                                let earthRotation = Rotation(time: 20)
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
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    
   func SecaddTargetNodes(){
            
            //when points get to a certain point like 40 means 1 left and 37 means 2 may be left
            //when game finish congrat them
            //kill certain ship and certain amount of points
            //when time run out
            //next take code from here appl to brd version

                                        let venusParent = SCNNode()
                                      let msun = SCNNode(geometry: SCNSphere(radius: 0.15))
              let earthParent = SCNNode()
            let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.2 ,0 , 0))
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
                    for index in 0...6 {
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
                        ssThShoonode.name = "sharkk"
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
                                      Shoonode.name = "SS1copy.scn"
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
                        nodeArray.append(Shoonode)
                     //   nodeArray.append(ShoonodeSec)
                        ThirdGroupNodeArray.append(FourthShoonode)
                       SSnodeArray.append(ssShoonode)
                        SecGroupNodeArray.append(ssThShoonode)
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
                      Shoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.9), randomFloat(min: 0.1, max: 0.9))
                                               
                                            
                                            //changed this one!!!
                                            ssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.9), randomFloat(min: -0.8, max: 0.8))
                                            
                                            
                                   
                                            ssThShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.9))
                                             FourthShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.9), randomFloat(min: 0.1, max: 0.9))
                        
                        

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
                                  let sunAction = Rotation(time: 15)
                                let earthParentRotation = Rotation(time: 10)
                        let VRotation = Rotation(time: 9)
                                let venusParentRotation = XRotation(time: 20)
                                let earthRotation = Rotation(time: 20)
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
        
    
    
    func FsaddTargetNodes(){
               
               //when points get to a certain point like 40 means 1 left and 37 means 2 may be left
               //when game finish congrat them
               //kill certain ship and certain amount of points
               //when time run out
               //next take code from here appl to brd version

                                           let venusParent = SCNNode()
                                         let msun = SCNNode(geometry: SCNSphere(radius: 0.15))
                 let earthParent = SCNNode()
               let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.2 ,0 , 0))
            //   venusParent
                earth.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                   earth.physicsBody?.isAffectedByGravity = false
                earthParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                   earthParent.physicsBody?.isAffectedByGravity = false

               AllnodeArray.removeAll()
               
               
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
                           ssThShoonode.name = "sharkk"
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
             
                          if (index > 1) && (index % 3 == 0) {
                            
                        
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
                                         Shoonode.name = "SS1copy.scn"
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
       //                    let r = ssShoonode
       //                     let b = ssShoonode
       //                     let c = ssShoonode
       //                       Shoonode.addChildNode(ssShoonode)
       //                     Shoonode.addChildNode(ssThShoonode)
       //                    Shoonode.addChildNode(FourthShoonode)
       //                     Shoonode.addChildNode(b)
       //                    Shoonode.addChildNode(c)
                       //      ShoonodeSec.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: -0.8, max: 0.5)) -0.8, max: 0.3
                           Shoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.9), randomFloat(min: 0.1, max: 0.5))
                              
                           
                           //changed this one!!!
                           ssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.3), randomFloat(min: -0.8, max: 0.8))
                           
                           
                  
                           ssThShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.5))
                            FourthShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.9), randomFloat(min: 0.1, max: 0.7))
                           
                           

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

          

                                  let SecRotation = XRotation(time: 300)
                             let SecRo = XRotation(time: 6)
                                     let sunAction = Rotation(time: 6)
                                   let earthParentRotation = Rotation(time: 10)
                           let VRotation = Rotation(time: 6)
                                   let venusParentRotation = XRotation(time: 20)
                                   let earthRotation = Rotation(time: 20)
                                   let moonRotation = Rotation(time: 5)
                           // decent rotations a bit to easy.. need to make harder to kill big blue and red--show blast hitting maybe with fire but instead ship dont disappear
                             //  make big ships spin as it Rotate
                           Shoonode.runAction(SecRotation)
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
                Coins+=4
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
               
              //  pla()
                
                          //  playSound(sound: "Power", format: "wav")
                //scoreL+=s
            } else if (contact.nodeA.name! == "earthQJ" || contact.nodeB.name! == "earthQJ") {
//                self.messageLabel.isHidden = false
//                              self.messageLabel.text = "you destroyed an planet"
               // Coins = 0
                
             DispatchQueue.main.async {
                
                
                self.PlanetHit()
                }
                
            

            } else if (contact.nodeA.name! == "moonnn" || contact.nodeB.name! == "moonnn"){

                DispatchQueue.main.async {
                   
                    self.Coins = 0
                   self.PlanetHitMoon()
                   }
                
            }

            
            DispatchQueue.main.async {
                contact.nodeA.removeFromParentNode()
                 // contact.nodeA.removeFromParentNode()
                contact.nodeB.removeFromParentNode()
               // contact.ear
                //LETS GOOOOOOOOOOOOOOOOOO This it ******************
//               self.scoreLabel.text = String(self.scoreL)
                if (contact.nodeA.name! == "mo" || contact.nodeB.name! == "mo"){
                    

//                    DispatchQueue.main.async {
//
//
//                    self.PlanetHitMoon()
//                    }
                    
//                    if (!self.nodeArray.isEmpty){
//                                    for r in self.nodeArray {
////                                        if r == contact.nodeA{
////
////                                        }
//                                   //     r.removeFromParentNode()
////                                        r.childNodes.filter({ $0.name == "shark" }).forEach({ $0.removeFromParentNode() })
//                                    }
//                    }
                    
                    //level complete .....numbers add up restart VC
                    
                }
                
                else if (contact.nodeA.name! == "shark" || contact.nodeB.name! == "shark"){
                    if let Jes = self.sceneView.scene.rootNode.childNode(withName: "shark", recursively: true) {
              
                                                        self.Coins+=1
                            self.scoreL+=2
                           // self.AllnodeArray.removeLast()
                            print("\(self.scoreL) scoreL")
                           print("\(self.Coins)Coins")
                        print("\(contact.nodeA.name!)")
                    } else{
                        DispatchQueue.main.async {
                            self.resetTimer()
                                         
                                         self.BeatLevel()
                                         }
                        
                    }
                      
                                           // SS1copy.scn
                    }
                else { //if  (contact.nodeA.name! == "SS1copy.scn" || contact.nodeB.name! == "SS1copy.scn"){
                        //  if !self.AllnodeArray.isEmpty{
                          //should be blue***
                                                                      self.Coins+=1
                                          self.scoreL+=1

                   // }
                }
                
                  self.scoreLabel.text = String(self.scoreL)
            }
//
//            playSound(sound: "explosion", format: "wav")
//                       let  explosion = SCNParticleSystem(named: "Fire", inDirectory: nil)
//                       contact.nodeB.addParticleSystem(explosion!)
            //Fire, react, star
             let  explosion = SCNParticleSystem(named: "Fire", inDirectory: nil)

            explosion?.particleLifeSpan = 4
            explosion?.emitterShape = contact.nodeB.geometry
            contact.nodeB.addParticleSystem(explosion!)
 
        }
    }
    
    
    func planet(geometry: SCNGeometry, diffuse: UIImage, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode {
           let planet = SCNNode(geometry: geometry)
           planet.geometry?.firstMaterial?.diffuse.contents = diffuse
           planet.geometry?.firstMaterial?.specular.contents = specular
           planet.geometry?.firstMaterial?.emission.contents = emission
           planet.geometry?.firstMaterial?.normal.contents = normal
           planet.position = position
           return planet
           
       }
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
        let audioPlayer = SCNAudioPlayer(source: audioSource)
        
        audioNode.addAudioPlayer(audioPlayer)
        
        let play = SCNAction.playAudio(audioSource, waitForCompletion: true)
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
