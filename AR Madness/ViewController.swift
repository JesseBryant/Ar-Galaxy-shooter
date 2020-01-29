//
//  ViewController.swift
//  AR Madness
//
//  Created by O'Sullivan, Andy on 25/05/2018.
//  Copyright © 2018 O'Sullivan, Andy. All rights reserved.
//

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
    
    //used to store the score
    var score = 0
    
    //MARK: - buttons
    
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
        
        //add objects to shoot at
        addTargetNodes()
        
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
         var node = SCNNode()
              
              //using case statement to allow variations of scale and rotations
              switch type {
              case "banana":
                  let scene = SCNScene(named: "art.scnassets/missile.dae")
                  node = (scene?.rootNode.childNode(withName: "missile", recursively: true)!)!
                  node.scale = SCNVector3(0.2,0.2,0.2)
                  node.name = "banana"
              case "axe":
                  let scene = SCNScene(named: "art.scnassets/missile.dae")
                  node = (scene?.rootNode.childNode(withName: "missile", recursively: true)!)!
                  node.scale = SCNVector3(0.2,0.2,0.2)
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

                                  //  let venusParent = SCNNode()
                                  let msun = SCNNode(geometry: SCNSphere(radius: 0.15))
          let earthParent = SCNNode()
        let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.2 ,0 , 0))
         earth.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                            earth.physicsBody?.isAffectedByGravity = false
         earthParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                            earthParent.physicsBody?.isAffectedByGravity = false
        
//         earth.addChildNode(Shoonode)
          earth.name = "earth"
         earthParent.name = "earthParent"
                                  earth.position = SCNVector3(0,0,-1)
                                   earthParent.position = SCNVector3(0,0,-1)
        earth.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
        earth.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
        earthParent.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
        earthParent.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                for index in 0...6 {
                    var Shoonode = SCNNode()
                   // var ShoonodeSec = SCNNode()
                    // var ShoonodeCloserEarP = SCNNode()
//                     let earthParent = SCNNode()
                                //  var ssShoonode = SCNNode()
                      
//                    let SpaceShscene = SCNScene(named: "art.scnassets/SS1copy.scn")
//                                            Shoonode = (SpaceShscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
//                                             Shoonode.scale = SCNVector3(0.02,0.02,0.02)
//                                            //Shoonode.name = "shark"
//                    msun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "moon Diffuse")
//                                          let moon = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "moon Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0,0,-0.3))
//                                                    moon.name = "moon"//Shoonode
                        let moonParent = SCNNode()
        //             let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.2 ,0 , 0))
                   if (index > 3) && (index % 3 == 0) {
                                  let scene = SCNScene(named: "art.scnassets/spaceARblcopy.scn")
                                 Shoonode = (scene?.rootNode.childNode(withName: "spaceARbl", recursively: true)!)!
                                  Shoonode.scale = SCNVector3(0.03,0.03,0.03)
                                 Shoonode.name = "shark"
                              }else{
                                  let scene = SCNScene(named: "art.scnassets/SS1copy.scn")
                                 Shoonode = (scene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
                                  Shoonode.scale = SCNVector3(0.03,0.03,0.03)
                                  Shoonode.name = "SS1copy.scn"
                              }
                    
                   
                    Shoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                       Shoonode.physicsBody?.isAffectedByGravity = false
                  //  ShoonodeSec.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                                       //ShoonodeSec.physicsBody?.isAffectedByGravity = false
//                      let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.2 ,0 , 0))
//                    earth.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
//                                       earth.physicsBody?.isAffectedByGravity = false
//                    earthParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
//                                       earthParent.physicsBody?.isAffectedByGravity = false
//
                   earth.addChildNode(Shoonode)
//                     earth.name = "earth"
//                    earthParent.name = "earthParent"
                    //earth.addChildNode(ShoonodeSec)
                       //Shoonode.addChildNode(ssShoonode)
                     //  ShoonodeSec.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.5))
                    Shoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.5))
           
                    
                    
                    
//                           earth.position = SCNVector3(0,0,-1)
//                           earthParent.position = SCNVector3(0,0,-1)
                          // venusParent.position = SCNVector3(0,0,-1)
                           moonParent.position = SCNVector3(0 ,0 , -1)
                    //earth earthParent
//                    earth.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
//                    earth.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
//                    earthParent.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
//                    earthParent.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                    Shoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                          Shoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                   // ShoonodeSec.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
                                           //ShoonodeSec.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                           self.sceneView.scene.rootNode.addChildNode(earth)
                           self.sceneView.scene.rootNode.addChildNode(earthParent)
                           //self.sceneView.scene.rootNode.addChildNode(venusParent)

                           self.sceneView.scene.rootNode.addChildNode(Shoonode)
                    //self.sceneView.scene.rootNode.addChildNode(ShoonodeSec)

        //                   let moon = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "moon Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0,0,-0.3))
        //             moon.name = "moon"

                           let SecRotation = XRotation(time: 10)
                              let sunAction = Rotation(time: 9)
                            let earthParentRotation = Rotation(time: 10)
                            let venusParentRotation = XRotation(time: 20)
                            let earthRotation = Rotation(time: 10)
                            let moonRotation = Rotation(time: 5)
                         //   let venusRotation = Rotation(time: 8)
                            
                         //now just have a few rotating x-asis
                           //  Shoonode.runAction(earthRotation)
                    Shoonode.runAction(SecRotation)
                //    ShoonodeSec.runAction(SecRotation)
                            // Shoonode.runAction(venusRotation)
                    
                         // Shoonode.runAction(earthRotation)
                          // Shoonode.runAction(venusRotation)
                           earthParent.runAction(earthParentRotation)
                        //   venusParent.runAction(venusParentRotation)
                           moonParent.runAction(moonRotation)

                           
                           earth.runAction(sunAction)
                   // earthParent.addChildNode(venusParent)
//                     venusParent.addChildNode(ShoonodeSec)
                           earthParent.addChildNode(Shoonode)
                           earthParent.addChildNode(moonParent)
                          // venusParent.addChildNode(venus)
        //                   Shoonode.addChildNode(msun)
                          // moonParent.addChildNode(moon)
                           
                   // Shoonode.position = SCNVector3(randomFloat(min: -10, max: 10),randomFloat(min: -4, max: 5),randomFloat(min: -10, max: 10))
                    
                    //rotate
        //            let action : SCNAction = SCNAction.rotate(by: .pi, around: SCNVector3(0, 1, 0), duration: 1.0)
        //            let forever = SCNAction.repeatForever(action)
        //            Shoonode.runAction(forever)
                    
                    //for the collision detection
//                    Shoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
//                   Shoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
//                    ShoonodeSec.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
//                                     ShoonodeSec.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
                    //add to scene
        //            sceneView.scene.rootNode.addChildNode(Shoonode)
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
        
         print("** Collision!! " + contact.nodeA.name! + " hit " + contact.nodeB.name!)
        
        if contact.nodeA.physicsBody?.categoryBitMask == CollisionCategory.targetCategory.rawValue
            || contact.nodeB.physicsBody?.categoryBitMask == CollisionCategory.targetCategory.rawValue {
            
            if (contact.nodeA.name! == "shark" || contact.nodeB.name! == "shark") {
                score+=5
            } else if (contact.nodeA.name! == "earth" || contact.nodeB.name! == "earth") {
            
              //  contact.nodeA.removeFromParentNode()
                            //  contact.nodeB.removeFromParentNode()
               // gameOver()
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                    self.score=0
                    let defaults = UserDefaults.standard
                    defaults.set(self.score, forKey: "score")

                    //go back to the Home View Controller
                    //maybe add popup that ask if you want to play again
                    
                    self.dismiss(animated: true, completion: nil)
                })
            }
                else{
                score+=1
            }
            
            DispatchQueue.main.async {
                contact.nodeA.removeFromParentNode()
                contact.nodeB.removeFromParentNode()
                self.scoreLabel.text = String(self.score)
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
