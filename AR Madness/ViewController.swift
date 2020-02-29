//
//  ViewController.swift
//  AR Madness
//
//  Created by O'Sullivan, Andy on 25/05/2018.
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

enum BitMaskCategory: Int {
    case target  = 3
}

class ViewController: UIViewController, ARSCNViewDelegate, SCNPhysicsContactDelegate {
    
    //MARK: - variables

    @IBOutlet var sceneView: ARSCNView!
    
    //used to display timer to player
    @IBOutlet weak var timerLabel: UILabel!
    
    //used to display score to player
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    
    @IBOutlet weak var levelJB: UILabel!
    //used to store the scoreP:>L)_________________________________________________________________________________________________________________________[…≥π÷{{Ú∏˘::
    var score = 0
     var scoreL = 0
    var target: SCNNode?
   var earN: SCNNode?
    var nodeArray : [SCNNode] = []
    var SSnodeArray : [SCNNode] = []
    var SecGroupNodeArray : [SCNNode] = []
     var EarGroupNodeArray : [SCNNode] = []
     var ThirdGroupNodeArray : [SCNNode] = []
      var name : [String] = ["1","1","1","2"]
    
//   messageLabel.isHidden = true
    //MARK: - buttons
  //make blue and red(esp) clse!!!
    //axe button
    @IBAction func onAxeButton(_ sender: Any) {
        fireMissile(type: "axe")
    }
    
    //banana button
    @IBAction func onBananaButton(_ sender: Any) {
        fireMissile(type: "banana")
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
    
    //MARK: - view functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        //sceneView.showsStatistics = true
        
        //set the physics delegate
        sceneView.scene.physicsWorld.contactDelegate = self
//        messageLabel.text = "Shoot all the spaceships. Do not shoot earth"
//        messageLabel.isHidden = false
//            messageLabel.text = "Shoot all the spaceships. Do not shoot earth"
//        UIView.animate(withDuration: 2.5, animations: { () -> Void in
//            self.messageLabel.alpha = 0
//        })
        //messageLabel
        
        //add objects to shoot at
        //scoreL
      //  if scoreL
        
        
//        if self.nodeArray.isEmpty && self.SSnodeArray.isEmpty && self.SecGroupNodeArray.isEmpty && self.ThirdGroupNodeArray.isEmpty {
//                               print("Empty!!!!!!!!")
//        }
        let defaults = UserDefaults.standard
            if let gameScore = defaults.value(forKey: "scoreL"){
                let score = gameScore as! Int
                if 90...189 ~= score {
                    //make levels crazyyyyyyyyyyyy!!
                    //score and coins not the same because score is infinite.
                    //everyone will end up with same score!!
                    //add glow things or some that with time determine coin amount
                    //need a pop up for when game is done.. or shot everything
                    //planet must explode if not saved
                  
                   // sceneView.backgroundColor = UIColor.red
                           messageLabel.isHidden = true
                    levelJB.text = "level 2"
                          SecaddTargetNodes()
                          PlayInstructions()
                          //play background music
                          playBackgroundMusic()
                          
                          //start tinmer
                          runTimer()
//                    if self.nodeArray.isEmpty && self.SSnodeArray.isEmpty && self.SecGroupNodeArray.isEmpty && self.ThirdGroupNodeArray.isEmpty {
//                                                 print("Empty!!!!!!!! in level 2")
//                          }
                    print("\(score): welcome to level 2")
                } else if 190...700 ~= score{
                  //  sceneView.backgroundColor = UIColor.red
                           messageLabel.isHidden = true
                    levelJB.text = "level 3"
                          addTargetNodes()
                    //FsaddTargetNodes()
                    // FsaddTargetNodes()
                          PlayInstructions()
                          //play background music
                          playBackgroundMusic()
                          
                          //start tinmer
                          runTimer()
                      print("\(score): welcome to level 3 jess")
                 //   print("\(score): still on level 1")
//                    if self.nodeArray.isEmpty && self.SSnodeArray.isEmpty && self.SecGroupNodeArray.isEmpty && self.ThirdGroupNodeArray.isEmpty {
//                                                                    print("Empty!!!!!!!! in level 3")
//                                             }
                }
                else if 700...731 ~= score{
                                  //  sceneView.backgroundColor = UIColor.red
                                           messageLabel.isHidden = true
                                    levelJB.text = "level 4"
                                          addTargetNodesFour()
                                    //FsaddTargetNodes()
                                    // FsaddTargetNodes()
                                          PlayInstructions()
                                          //play background music
                                          playBackgroundMusic()
                                          
                                          //start tinmer
                                          runTimer()
                                      print("\(score): welcome to level 4 jess")
                                 //   print("\(score): still on level 1")
                //                    if self.nodeArray.isEmpty && self.SSnodeArray.isEmpty && self.SecGroupNodeArray.isEmpty && self.ThirdGroupNodeArray.isEmpty {
                //                                                                    print("Empty!!!!!!!! in level 3")
                //                                             }
                                }       else if 732...750 ~= score{
                                                            //  sceneView.backgroundColor = UIColor.red
                                                                     messageLabel.isHidden = true
                                                              levelJB.text = "level 5"
                    
                    //Will need to add other nodes give a more real effect. For smaller ships
                                                                    addTargetNodesFive()
                                                              //FsaddTargetNodes()
                                                              // FsaddTargetNodes()
                                                                    PlayInstructions()
                                                                    //play background music
                                                                    playBackgroundMusic()
                                                                    
                                                                    //start tinmer
                                                                    runTimer()
                                                                print("\(score): welcome to level 5 jess")
                                                           //   print("\(score): still on level 1")
                                          //                    if self.nodeArray.isEmpty && self.SSnodeArray.isEmpty && self.SecGroupNodeArray.isEmpty && self.ThirdGroupNodeArray.isEmpty {
                                          //                                                                    print("Empty!!!!!!!! in level 3")
                                          //                                             }
                                                          } else if 751...762 ~= score{
                                                                                                  //  sceneView.backgroundColor = UIColor.red
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
                                                                                                      print("\(score): welcome to level 6 jess")
                                                                                                 //   print("\(score): still on level 1")
                                                                                //                    if self.nodeArray.isEmpty && self.SSnodeArray.isEmpty && self.SecGroupNodeArray.isEmpty && self.ThirdGroupNodeArray.isEmpty {
                                                                                //                                                                    print("Empty!!!!!!!! in level 3")
                                                                                //                                             }
                                                                                                }
                
                //addTargetNodesSaturn()
                else if 763...800 ~= score{
                                                        //  sceneView.backgroundColor = UIColor.red
                                                                 messageLabel.isHidden = true
                                                          levelJB.text = "level 7"
                
                //Will need to add other nodes give a more real effect. For smaller ships
                                                                addTargetNodesSaturn()
                                                          //FsaddTargetNodes()
                                                          // FsaddTargetNodes()
                                                                PlayInstructions()
                                                                //play background music
                                                                playBackgroundMusic()
                                                                
                                                                //start tinmer
                                                                runTimer()
                                                            print("\(score): welcome to level 7 jess")
                                                       //   print("\(score): still on level 1")
                                      //                    if self.nodeArray.isEmpty && self.SSnodeArray.isEmpty && self.SecGroupNodeArray.isEmpty && self.ThirdGroupNodeArray.isEmpty {
                                      //                                                                    print("Empty!!!!!!!! in level 3") addTargetNodesNeptune()
                                      //                                             }
                                                      }
                else if 807...850 ~= score{
                                                                       //  sceneView.backgroundColor = UIColor.red
                                                                                messageLabel.isHidden = true
                                                                         levelJB.text = "level 8"
                               
                               //Will need to add other nodes give a more real effect. For smaller ships
                                                                               addTargetNodesNeptune()
                                                                         //FsaddTargetNodes()
                                                                         // FsaddTargetNodes()
                                                                               PlayInstructions()
                                                                               //play background music
                                                                               playBackgroundMusic()
                                                                               
                                                                               //start tinmer
                                                                               runTimer()
                                                                           print("\(score): welcome to level 8 jess")
                                                                      //   print("\(score): still on level 1")
                                                     //                    if self.nodeArray.isEmpty && self.SSnodeArray.isEmpty && self.SecGroupNodeArray.isEmpty && self.ThirdGroupNodeArray.isEmpty {
                                                     //                                                                    print("Empty!!!!!!!! in level 3") addTargetNodesNeptune()
                                                     //                                             }
                                                                     }
//                //scoreLabel.text = "Score: \(String(score))"
         } 
        else{
          //  sceneView.backgroundColor = UIColor.red
                   messageLabel.isHidden = true
            levelJB.text = "level 1"
                  //addTargetNodes()
                FsaddTargetNodes()
                  PlayInstructions()
                  //play background music
                  playBackgroundMusic()
                  
                  //start tinmer
                  runTimer()
            print("\(score): still on level 1")
//                if self.nodeArray.isEmpty && self.SSnodeArray.isEmpty && self.SecGroupNodeArray.isEmpty && self.ThirdGroupNodeArray.isEmpty {
//                                                                print("Empty!!!!!!!! in level 1")
//                                         }
        }
//        sceneView.backgroundColor = UIColor.red
//         messageLabel.isHidden = true
//        addTargetNodes()
//        PlayInstructions()
//        //play background music
//        playBackgroundMusic()
//
//        //start tinmer
//        runTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
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
    func PlayInstructions() {
        
//        messageLabel.isHidden = false
//        [self performSelector:@selector(hiddenLabel) withObject:nil afterDelay:3];
        self.messageLabel.isHidden = false
               self.messageLabel.text = "Shoot all the spaceships. Do not shoot earth"
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
              
        self.messageLabel.isHidden = true
                 })
        
        
//         messageLabel.isHidden = false
               // messageLabel.text = "Shoot all the spaceships. Do not shoot earth"
//                messageLabel.isHidden = false
                  //  messageLabel.text = "Shoot all the spaceships. Do not shoot earth"
//                UIView.animate(withDuration: 2.5, animations: { () -> Void in
//                    self.messageLabel.alpha = 1
//                })
      //  messageLabel.isHidden = true
        
    }
    
    //decrements seconds by 1, updates the timerLabel and calls gameOver if seconds is 0
    @objc func updateTimer() {
        if seconds == 0 {
            timer.invalidate()
            gameOver()
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
    

      //  }
        
//        for r in self.EarGroupNodeArray {
//        //                                        if r == contact.nodeA{
//        //
//        //                                        }
//         //   let  explosion = SCNParticleSystem(named: "Fire", inDirectory: nil)
//
//                            r.removeFromParentNode()
//                            //explosion?.particleLifeSpan = 1
//                       // explosion?.emitterShape = r.geometry
//                          //  r.addParticleSystem(explosion!)
//
//        }
////        let  explosion = SCNParticleSystem(named: "Fire", inDirectory: nil)
////
////
////                    explosion?.particleLifeSpan = 4
////                    explosion?.emitterShape = contact.nodeB.geometry
////                    contact.nodeB.addParticleSystem(explosion!)
         let defaultss = UserDefaults.standard
                    if let gameScore = defaultss.value(forKey: "scoreL"){
                         scoreJJ = gameScore as! Int
                        if score > 90 {
                            print("\(score):score >90 welcome to level 2")
                        } else{
                            print("\(score): score <90 still on level 1")
                        }
        //                //scoreLabel.text = "Score: \(String(score))"
                 }
        
        
        
        
        
     //   scoreL += score
        let fscre = scoreL
        //store the score in UserDefaults
        let defaults = UserDefaults.standard
        defaults.set(score, forKey: "score")
//        scoreL += score
      //  defaults.set(scoreL, forKey: "scoreL")
        let arrrrr = scoreJJ + fscre
        let defaultsJB = UserDefaults.standard
        defaultsJB.set(arrrrr, forKey: "scoreL")
        //go back to the Home View Controller
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - missiles & targets
    
    //creates banana or axe node and 'fires' it
    func fireMissile(type : String){
        var node = SCNNode()
            //create node
            node = createMissile(type: type)
            //fix it to where once you kill all says game won
            //have pop ups
            //use space ships and beam instead
            //shoot blast that look like beams
            //get the users position and direction
            //my competion 3d images a bit plane
            //pay close attention to my competion and the best levels, and growth of difficulty and difficulty
            //add every node to an array so i can delete right ones.
            // increase rotation speeds per level.
            //Multy player
            let (direction, position) = self.getUserVector()
            node.position = position
            var nodeDirection = SCNVector3()
            switch type {
            case "banana":
                nodeDirection  = SCNVector3(direction.x*40,direction.y*40,direction.z*40)
                node.physicsBody?.applyForce(nodeDirection, at: SCNVector3(0.1,0,0), asImpulse: true)
                playSound(sound: "monkey", format: "mp3")
                
                //this stronger make a lot easier this should be temporary and rewarded after a certain level
                //or destroying enemy ship/s
            case "axe":
                nodeDirection  = SCNVector3(direction.x*40,direction.y*40,direction.z*40)
                node.physicsBody?.applyForce(SCNVector3(direction.x,direction.y,direction.z), at: SCNVector3(0,0,0.1), asImpulse: true)
                playSound(sound: "rooster", format: "mp3")
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
                  node.name = "banana"
              case "axe":
//                  let scene = SCNScene(named: "art.scnassets/missile.dae")
//                  node = (scene?.rootNode.childNode(withName: "missile", recursively: true)!)!
//                  node.scale = SCNVector3(0.2,0.2,0.2)
                node .geometry?.firstMaterial?.diffuse.contents = UIColor.red
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
    
    
    
    func addTargetNodesFour(){
        //Need message dont shoot moon.
        //if so planet and moon destroyed

                                        let venusParent = SCNNode()
                                      let msun = SCNNode(geometry: SCNSphere(radius: 0.15))
              let earthParent = SCNNode()
         let moonParent = SCNNode()
        
            let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.2 ,0 , 0))
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
                                let earthRotation = Rotation(time: 30)
                                let moonRotation = Rotation(time: 10)
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
                        earth.addChildNode(moon)
                             moonParent.addChildNode(moon)
    //                    for n in SSnodeArray {
    //                        print("\(n.name) jessss")
    //                    }
            
                    }
                }
        
    func addTargetNodesFive(){
           //Need message dont shoot moon.
           //if so planet and moon destroyed

                                           let venusParent = SCNNode()
                                         let sun = SCNNode(geometry: SCNSphere(radius: 0.25))
        sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Sun diffuse")
               sun.position = SCNVector3(0,0,-1)
                 let earthParent = SCNNode()
            let moonParent = SCNNode()
           
               let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.2 ,0 , 0))
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
                                   let venusParentRotation = XRotation(time: 20)
                                   let earthRotation = Rotation(time: 30)
                                   let moonRotation = Rotation(time: 10)
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
           
    func addTargetNodesSixVenus(){
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
                               let VRotation = Rotation(time: 15)
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
    func addTargetNodesSaturn(){
                  //Need message dont shoot moon.
                  //if so planet and moon destroyed
           //Make ships move on dif speeds llke earlter
        
        let saturnRing = createRing(ringSize: 0.3)
              let saturn = createPlanet(radius: 0.2, image: "saturn")
              saturn.name = "saturn"
        saturn.position = SCNVector3(0.9,0,0)
              rotateObject(rotation: 0.1, planet: saturn, duration: 0.4)
              rotateObject(rotation: 0.1, planet: saturnRing, duration: 1)

//              let saturnLoop = SCNBox(width: 0.1, height: 0, length: 0.2, chamferRadius: 0)
//              let material = SCNMaterial()
//              material.diffuse.contents = UIImage(named:"saturnring.jpg")
//              saturnLoop.materials = [material]
//        let loopNode = SCNNode(geometry: saturnLoop)
//               loopNode.position = SCNVector3(x:0,y:0,z:0)
              //saturnLoop saturn
        

                                                  let venusParent = SCNNode()
                                                let sun = SCNNode(geometry: SCNSphere(radius: 0.25))
               sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Sun diffuse")
                      sun.position = SCNVector3(0,0,-1)
                        let earthParent = SCNNode()
                   let moonParent = SCNNode()
                  let saturnParent = SCNNode()
                      let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.2 ,0 , 0))
            let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "Venus Surface"), specular: nil, emission: #imageLiteral(resourceName: "Venus Atmosphere"), normal: nil, position: SCNVector3(0.7, 0, 0))
                     let moon = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "moon Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0,0,-0.3))
                   //   venusParent
                       earth.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                          earth.physicsBody?.isAffectedByGravity = false
                       earthParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                          earthParent.physicsBody?.isAffectedByGravity = false
saturnParent.position = SCNVector3(0,0,-1)
                      
                      
                      
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
                                         self.sceneView.scene.rootNode.addChildNode(earthParent)
                                         self.sceneView.scene.rootNode.addChildNode(venusParent)
                               // saturnParent
 self.sceneView.scene.rootNode.addChildNode(saturnParent)
                               // self.sceneView.scene.rootNode.addChildNode(saturnRing)
                                         self.sceneView.scene.rootNode.addChildNode(Shoonode)
                                 
                               
                               self.sceneView.scene.rootNode.addChildNode(sun) //self.sceneView.scene.rootNode.addChildNode(ShoonodeSec)
                                  self.sceneView.scene.rootNode.addChildNode(ssShoonode)
                                    self.sceneView.scene.rootNode.addChildNode(ssThShoonode)
                                   self.sceneView.scene.rootNode.addChildNode(FourthShoonode)
//added Saturn
                 

                                         let SecRotation = XRotation(time: 300)
                                    let SecRo = XRotation(time: 6)
                                            let sunAction = Rotation(time: 22)
                                          let earthParentRotation = Rotation(time: 20)
                                  let VRotation = Rotation(time: 24)
                                 let VJRotation = Rotation(time: 27)
                                          let venusParentRotation = XRotation(time: 30)
                                let saturnParentRotation = XRotation(time: 30)
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
                                saturnParent.runAction(VJRotation)
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
                               // sun.addChildNode(earthParent)
                                 //sun.addChildNode(saturnParent)
                                
                                saturnParent.addChildNode(saturn)
                                      saturn.addChildNode(saturnRing)
                             // sun.addChildNode(saturnRing)
                               // saturnParent.addChildNode(saturnRing)
                                earth.addChildNode(Shoonode)
                                  earth.addChildNode(ssShoonode)
                                //  ssThShoonode.addChildNode(ssShoonode)
                                  earth.addChildNode(ssThShoonode)
                                  earth.addChildNode(FourthShoonode)
                                         earth.addChildNode(moonParent)
                                  earth.addChildNode(moon)
                                       moonParent.addChildNode(moon)
              //                    for n in SSnodeArray {
              //                        print("\(n.name) jessss")
              //                    }
                      
                              }
                          }
    
    func addTargetNodesNeptune(){
       
                      //Need message dont shoot moon.
                      //if so planet and moon destroyed
               //Make ships move on dif speeds llke earlter
        let neptuneRing = createRing(ringSize: 0.3)
               let neptune = createPlanet(radius: 0.23, image: "neptune")
               neptune.name = "neptune"
               neptune.position = SCNVector3(x:1.6 , y: 0, z: 0)
               rotateObject(rotation: 0.01, planet: neptune, duration: 0.4)
               rotateObject(rotation: 0.01, planet: neptuneRing, duration: 1)
            
            let saturnRing = createRing(ringSize: 0.3)
                  let saturn = createPlanet(radius: 0.2, image: "saturn")
                  saturn.name = "saturn"
            saturn.position = SCNVector3(0.9,0,0)
                  rotateObject(rotation: 0.1, planet: saturn, duration: 0.4)
                  rotateObject(rotation: 0.1, planet: saturnRing, duration: 1)

  
            

                                                      let venusParent = SCNNode()
                                                    let sun = SCNNode(geometry: SCNSphere(radius: 0.25))
                   sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Sun diffuse")
                          sun.position = SCNVector3(0,0,-1)
                            let earthParent = SCNNode()
                       let moonParent = SCNNode()
                      let saturnParent = SCNNode()
                               let neptuneParent = SCNNode()
                          let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.2 ,0 , 0))
                let venus = planet(geometry: SCNSphere(radius: 0.15), diffuse: #imageLiteral(resourceName: "Venus Surface"), specular: nil, emission: #imageLiteral(resourceName: "Venus Atmosphere"), normal: nil, position: SCNVector3(0.5, 0, 0))
                         let moon = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "moon Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0,0,-0.3))
                       //   venusParent
                           earth.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                              earth.physicsBody?.isAffectedByGravity = false
                           earthParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                              earthParent.physicsBody?.isAffectedByGravity = false
    saturnParent.position = SCNVector3(0,0,-1)
              neptuneParent.position = SCNVector3(0,0,-1)
                          
                          
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
                 
                                      
                                      
                                          let scene = SCNScene(named: "art.scnassets/spaceARcopy.scn")
                                                                   Shoonode = (scene?.rootNode.childNode(withName: "SS1redcopy", recursively: true)!)!
                                                                    Shoonode.scale = SCNVector3(0.03,0.03,0.03)
                                                                   Shoonode.name = "shark"
                                                }else{

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
                                             self.sceneView.scene.rootNode.addChildNode(earthParent)
                                             self.sceneView.scene.rootNode.addChildNode(venusParent)
                                   // saturnParent
     self.sceneView.scene.rootNode.addChildNode(saturnParent)
                                      self.sceneView.scene.rootNode.addChildNode(neptuneParent)
//                                    neptuneParent
                                   // self.sceneView.scene.rootNode.addChildNode(saturnRing)
                                             self.sceneView.scene.rootNode.addChildNode(Shoonode)
                                     
                                   
                                   self.sceneView.scene.rootNode.addChildNode(sun) //self.sceneView.scene.rootNode.addChildNode(ShoonodeSec)
                                      self.sceneView.scene.rootNode.addChildNode(ssShoonode)
                                        self.sceneView.scene.rootNode.addChildNode(ssThShoonode)
                                       self.sceneView.scene.rootNode.addChildNode(FourthShoonode)
    //added Saturn
                     

                                             let SecRotation = XRotation(time: 300)
                                        let SecRo = XRotation(time: 6)
                                                let sunAction = Rotation(time: 25)
                                              let earthParentRotation = Rotation(time: 20)
                                      let VRotation = Rotation(time: 27)
                                     let VJRotation = Rotation(time: 25)
                                     let NeptuneRotation = Rotation(time: 28)
                                              let venusParentRotation = XRotation(time: 30)
                                    let saturnParentRotation = XRotation(time: 30)
                                              let earthRotation = Rotation(time: 30)
                                              let moonRotation = Rotation(time: 10)
                                    let venusRotation = Rotation(time: 8)
                                  
                                      Shoonode.runAction(SecRo)
                  //                  //  ShoonodeSec.runAction(SecRotation)
                                     ssShoonode.runAction(SecRotation)
                                    
                  //                    //FourthShoonode
                                     ssThShoonode.runAction(SecRotation)
                                      FourthShoonode.runAction(SecRotation)
                  //                        ssThShoonode neptuneParent
                                             earthParent.runAction(earthParentRotation)
                                    saturnParent.runAction(VJRotation)
                                    neptuneParent.runAction(NeptuneRotation)
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
                                   // sun.addChildNode(earthParent)
                                     //sun.addChildNode(saturnParent)
                                    
                                    saturnParent.addChildNode(saturn)
                                          saturn.addChildNode(saturnRing)
                                    neptuneParent.addChildNode(neptune)
                                    neptune.addChildNode(neptuneRing)
                                 // sun.addChildNode(saturnRing)
                                   // saturnParent.addChildNode(saturnRing)
                                    earth.addChildNode(Shoonode)
                                      earth.addChildNode(ssShoonode)
                                    //  ssThShoonode.addChildNode(ssShoonode)
                                      earth.addChildNode(ssThShoonode)
                                      earth.addChildNode(FourthShoonode)
                                           //  earth.addChildNode(moonParent)
                                      earth.addChildNode(moon)
                                         //  moonParent.addChildNode(moon)
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
                                      let scene = SCNScene(named: "art.scnassets/spaceARcopy.scn")
                                     Shoonode = (scene?.rootNode.childNode(withName: "SS1redcopy", recursively: true)!)!
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
            
            if (contact.nodeA.name! == "shark" || contact.nodeB.name! == "shark") {
                score+=5
                scoreL+=5
                //scoreL+=s
            } else if (contact.nodeA.name! == "earth" || contact.nodeB.name! == "earth") {
            
              //  contact.nodeA.removeFromParentNode()
                            //  contact.nodeB.removeFromParentNode()
               // gameOver()
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                    
                    //made 0 cz sh earh
                    self.score=0
                    let defaults = UserDefaults.standard
                    defaults.set(self.score, forKey: "score")
                    self.messageLabel.isHidden = false
                    self.messageLabel.text = "you destroyed the earth."
                  //  contact.nodeB.children.map{ $0.rem}
                    //go back to the Home View Controller
                    //maybe add popup that ask if you want to play again
                   // nodeArray?.rem
//                    for r in self.nodeArray {
//                        r.removeFromParentNode()
//                    }
                   // self.earN?.removeFromParentNode()
                    self.dismiss(animated: true, completion: nil)
                })
            }
                else{
                score+=1
                scoreL+=1
            }
            
            DispatchQueue.main.async {
                contact.nodeA.removeFromParentNode()
                 // contact.nodeA.removeFromParentNode()
                contact.nodeB.removeFromParentNode()
               // contact.ear
                //LETS GOOOOOOOOOOOOOOOOOO This it ******************
                self.scoreLabel.text = String(self.score)
                if (contact.nodeA.name! == "earth" || contact.nodeB.name! == "earth"){
                    
//                    if self.nodeArray.isEmpty && self.SSnodeArray.isEmpty && self.SecGroupNodeArray.isEmpty && self.ThirdGroupNodeArray.isEmpty {
//                        print("Empty!!!!!!!!")
                    
//                         let defaults = UserDefaults.standard
//                                    if let gameScore = defaults.value(forKey: "scoreL"){
//                                        let score = gameScore as! Int
//                                        if 90...189 ~= score {
//
//                                            self.SecaddTargetNodes()
//                                            print("\(score): welcome to level 2   SecaddTargetNodes() ")
//                                        } else if score > 190{
//                                          //  sceneView.backgroundColor = UIC
//
//                                                  //start tinmer
//                                            self.addTargetNodes()
//                                                              //FsaddTargetNodes()
//                                            print("\(score): still on level 1")
//                                        }
//                        //                //scoreLabel.text = "Score: \(String(score))"
//                                 }
//                                else{
//                                  //  sceneView.backgroundColor = UIColor.red
//                                        self.FsaddTargetNodes()
//                                        print("\(self.score): still on level 1")
//                                }
                 //   }
                    
                    
                    
                    if (!self.nodeArray.isEmpty){
                                    for r in self.nodeArray {
//                                        if r == contact.nodeA{
//
//                                        }
                                        r.removeFromParentNode()
//                                        r.childNodes.filter({ $0.name == "shark" }).forEach({ $0.removeFromParentNode() })
                                    }
                    }
                    
                }
                
                else if (contact.nodeA.name! == "shark" || contact.nodeB.name! == "shark"){
                    
                    //SSnodeArray
//                    if self.SSnodeArray.count > 3 {
                      if !self.SSnodeArray.isEmpty{
                    for r in self.SSnodeArray {
                    //    self.SSnodeArray.filter({ $0 == 4 }).forEach({ $0.removeFromParentNode() })
                       // if r.name != "2" {
                          //  print("\(r.name)")
                        r.removeFromParentNode()
                     //   }
                    //                                        r.childNodes.filter({ $0.name == "shark" }).forEach({ $0.removeFromParentNode() })
                                                        }
                    }
                }
                else { if  (contact.nodeA.name! == "SS1copy.scn" || contact.nodeB.name! == "SS1copy.scn"){
                    if !self.SecGroupNodeArray.isEmpty{
                    for r in self.SecGroupNodeArray {
                        //    self.SSnodeArray.filter({ $0 == 4 }).forEach({ $0.removeFromParentNode() })
                           // if r.name != "2" {
                              //  print("\(r.name)")
                     //   if !self.SecGroupNodeArray.isEmpty{
                            r.removeFromParentNode()
                        self.SecGroupNodeArray.removeAll()
                        print("\(self.SecGroupNodeArray)SecGroupNodeArray jessssssss 2 ")
                        }
                    
                    
                        } else {
                         if !self.ThirdGroupNodeArray.isEmpty{
                            for g in self.ThirdGroupNodeArray {
                                g.removeFromParentNode()
                                self.ThirdGroupNodeArray.removeAll()
                                print("\(self.ThirdGroupNodeArray)ThirdGroupNodeArray made las jessssss3")
                            }
                            
//                            if self.nodeArray.isEmpty && self.SSnodeArray.isEmpty && self.SecGroupNodeArray.isEmpty && self.ThirdGroupNodeArray.isEmpty {
//                                                                                             print("Empty!!!!!!!! in level 3")
//                                                                      }
                     //   }
                          // }
                        //                                        r.childNodes.filter({ $0.name == "shark" }).forEach({ $0.removeFromParentNode() })
                         } else if self.ThirdGroupNodeArray.isEmpty{
                              print("Empty!!!!!!!! in level 3")
                            
                            
                            
                           //Problem this for small groups...need a condition if all emp rep...depend on level set bool true based off bool youll pck correct reload func Not lke here waiting till random crew grp empty
                            
                            //or use score.. restar or dismiss when certain score met
                            
                            
                           //  self.addGGTargetNodes()
                           // self.addTargetNodes()
                            //here is where i repop or say complete than restart
                            
                        }
//                         else {
//
//                            //pop
//                        }
                    }
                    }
                }
                
                
            }
//
//            playSound(sound: "explosion", format: "wav")
//                       let  explosion = SCNParticleSystem(named: "Fire", inDirectory: nil)
//                       contact.nodeB.addParticleSystem(explosion!)
            //Fire, react, star
             let  explosion = SCNParticleSystem(named: "Fire", inDirectory: nil)
//                        contact.nodeB.addParticleSystem(explosion!)
//            Fire-3
//
//            if let particles = SKEmitterNode(fileNamed: "ff.sks") {
//                particles.position = contact.nodeB.position
////                addChild(particles)
//                contact.nodeB.addParticleSystem(particles)
//                addChild(particles)
//            }
          // explosion?.loops = false
            
            explosion?.particleLifeSpan = 4
            explosion?.emitterShape = contact.nodeB.geometry
            contact.nodeB.addParticleSystem(explosion!)
          //  contact.nodeB.addParticleSystem(explosion!)
           // let explosionNode = SCNNode()
          // explosionNode.addParticleSystem(explosion!)
          // explosionNode.position = contact.contactPoint
        //  self.sceneView.scene.rootNode.addChildNode(explosionNode)
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
        let audioNode = SCNNode()
        let audioSource = SCNAudioSource(fileNamed: "overtake.mp3")!
        let audioPlayer = SCNAudioPlayer(source: audioSource)
        
        audioNode.addAudioPlayer(audioPlayer)
        
        let play = SCNAction.playAudio(audioSource, waitForCompletion: true)
        audioNode.runAction(play)
        sceneView.scene.rootNode.addChildNode(audioNode)
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
