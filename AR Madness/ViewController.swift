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
    //used to store the score
    var score = 0
    var earN: SCNNode?
    var nodeArray : [SCNNode] = []
    var SSnodeArray : [SCNNode] = []
    var SecGroupNodeArray : [SCNNode] = []
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
        sceneView.backgroundColor = UIColor.red
         messageLabel.isHidden = true
        addTargetNodes()
        PlayInstructions()
        //play background music
        playBackgroundMusic()
        
        //start tinmer
        runTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    var seconds = 60
    
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
        //store the score in UserDefaults
        let defaults = UserDefaults.standard
        defaults.set(score, forKey: "score")

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
        
        //when points get to a certain point like 40 means 1 left and 37 means 2 may be left
        //when game finish congrat them
        //kill certain ship and certain amount of points
        //when time run out
        //next take code from here appl to brd version

                                  //  let venusParent = SCNNode()
                                  let msun = SCNNode(geometry: SCNSphere(radius: 0.15))
          let earthParent = SCNNode()
        let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.2 ,0 , 0))
         earth.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                            earth.physicsBody?.isAffectedByGravity = false
         earthParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                            earthParent.physicsBody?.isAffectedByGravity = false
        
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
      //  let frame = self.sceneView.session.currentFrame
      //  let frame = self.sceneView.
        // let mat = SCNMatrix4(frame.camera.transform)
                for index in 0...3 {
                    //need to create an array of nodes..each time you shoot check name and if it right one remove 5 reg nodes and the one hit make sure it explode. Make strings var make  this func shorter
                    //make node array empty in the end of the game func
                    var Shoonode = SCNNode()
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
                                  let scene = SCNScene(named: "art.scnassets/spaceARcopy.scn")
                                 Shoonode = (scene?.rootNode.childNode(withName: "SS1redcopy", recursively: true)!)!
                                  Shoonode.scale = SCNVector3(0.03,0.03,0.03)
                                 Shoonode.name = "shark"
                              }else{
                   // blue
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

                   earth.addChildNode(Shoonode)
//                     earth.name = "earth"
//                    earthParent.name = "earthParent"
                  //  earth.addChildNode(ShoonodeSec)
                    nodeArray.append(Shoonode)
                 //   nodeArray.append(ShoonodeSec)
                    ThirdGroupNodeArray.append(FourthShoonode)
                   SSnodeArray.append(ssShoonode)
                    SecGroupNodeArray.append(ssThShoonode)
//                    let r = ssShoonode
//                     let b = ssShoonode
//                     let c = ssShoonode
                       Shoonode.addChildNode(ssShoonode)
                     Shoonode.addChildNode(ssThShoonode)
                    Shoonode.addChildNode(FourthShoonode)
//                     Shoonode.addChildNode(b)
//                    Shoonode.addChildNode(c)
                //      ShoonodeSec.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: -0.8, max: 0.5))
                    Shoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.5))
                       
                    ssShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: -0.8, max: 0.5))
           
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
                           //self.sceneView.scene.rootNode.addChildNode(venusParent)

                           self.sceneView.scene.rootNode.addChildNode(Shoonode)
                    //self.sceneView.scene.rootNode.addChildNode(ShoonodeSec)
                    self.sceneView.scene.rootNode.addChildNode(ssShoonode)
                      self.sceneView.scene.rootNode.addChildNode(ssThShoonode)
                     self.sceneView.scene.rootNode.addChildNode(FourthShoonode)

   

                           let SecRotation = XRotation(time: 10)
                              let sunAction = Rotation(time: 30)
                            let earthParentRotation = Rotation(time: 15)
                            let venusParentRotation = XRotation(time: 20)
                            let earthRotation = Rotation(time: 10)
                            let moonRotation = Rotation(time: 5)
                        
                    Shoonode.runAction(SecRotation)
                  //  ShoonodeSec.runAction(SecRotation)
                   ssShoonode.runAction(SecRotation)
                    //FourthShoonode
                     ssThShoonode.runAction(SecRotation)
                    FourthShoonode.runAction(SecRotation)
//                        ssThShoonode
                           earthParent.runAction(earthParentRotation)
                        //   venusParent.runAction(venusParentRotation)
                           moonParent.runAction(moonRotation)

                           
                           earth.runAction(sunAction)
                   // earthParent.addChildNode(venusParent)
//                     venusParent.addChildNode(ShoonodeSec)
                           earthParent.addChildNode(Shoonode)
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
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    
    
    // MARK: - Contact Delegate
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        //can reduce by size to
         print("** Collision!! " + contact.nodeA.name! + " hit " + contact.nodeB.name!)
        
        if contact.nodeA.physicsBody?.categoryBitMask == CollisionCategory.targetCategory.rawValue
            || contact.nodeB.physicsBody?.categoryBitMask == CollisionCategory.targetCategory.rawValue {
            
            if (contact.nodeA.name! == "shark" || contact.nodeB.name! == "shark") {
                score+=5
            } else if (contact.nodeA.name! == "earth" || contact.nodeB.name! == "earth") {
            
              //  contact.nodeA.removeFromParentNode()
                            //  contact.nodeB.removeFromParentNode()
               // gameOver()
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
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
            }
            
            DispatchQueue.main.async {
                contact.nodeA.removeFromParentNode()
                 // contact.nodeA.removeFromParentNode()
                contact.nodeB.removeFromParentNode()
               // contact.ear
                //LETS GOOOOOOOOOOOOOOOOOO This it ******************
                self.scoreLabel.text = String(self.score)
                if (contact.nodeA.name! == "earth" || contact.nodeB.name! == "earth"){
                                    for r in self.nodeArray {
                                        
                                        r.removeFromParentNode()
//                                        r.childNodes.filter({ $0.name == "shark" }).forEach({ $0.removeFromParentNode() })
                                    }
                    
                    
                }
                
                else if (contact.nodeA.name! == "shark" || contact.nodeB.name! == "shark"){
                    
                    //SSnodeArray
//                    if self.SSnodeArray.count > 3 {
                    for r in self.SSnodeArray {
                    //    self.SSnodeArray.filter({ $0 == 4 }).forEach({ $0.removeFromParentNode() })
                       // if r.name != "2" {
                          //  print("\(r.name)")
                        r.removeFromParentNode()
                     //   }
                    //                                        r.childNodes.filter({ $0.name == "shark" }).forEach({ $0.removeFromParentNode() })
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
                            for g in self.ThirdGroupNodeArray {
                                g.removeFromParentNode()
                                self.ThirdGroupNodeArray.removeAll()
                                print("\(self.ThirdGroupNodeArray)ThirdGroupNodeArray made las jessssss3")
                            }
                     //   }
                          // }
                        //                                        r.childNodes.filter({ $0.name == "shark" }).forEach({ $0.removeFromParentNode() })
                                                            }
                    }
                }
                
                
            }
            
            playSound(sound: "explosion", format: "wav")
            let  explosion = SCNParticleSystem(named: "Explode", inDirectory: nil)
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
