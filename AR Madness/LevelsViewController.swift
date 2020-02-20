//
//  LevelsViewController.swift
//  AR Madness
//
//  Created by Jesse Bryant on 2/9/20.

//

//import UIKit
//import SceneKit
//import ARKit
//class LevelsViewController: UIViewController, ARSCNViewDelegate {
//    var target: SCNNode?
//      var earN: SCNNode?
//       var nodeArray : [SCNNode] = []
//       var SSnodeArray : [SCNNode] = []
//       var SecGroupNodeArray : [SCNNode] = []
//        var ThirdGroupNodeArray : [SCNNode] = []
//    //create an bool! Check before every game!
//    //save game score and how many won games(may have to win 4 games before moving Up) in User defaults for now!
//    //also for a level add shooting certain ones that if you shoot more are created..competion has animation... i can add reg explode(blast) and some noise!!
//    //also colors changed each level!!!!!!!!*** might subtract blue
//
//    //ads required before each new level.
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//    func SECaddTargetNodes(){
//            //2nd phase
//            //when points get to a certain point like 40 means 1 left and 37 means 2 may be left
//            //when game finish congrat them
//            //kill certain ship and certain amount of points
//            //when time run out
//            //next take code from here appl to brd version
//
//            //**immediate goals**
//            //save won games in default
//            //make blue lke small ships so it be so easy and more black and white
//            //reward coins
//            //add new level. (next one blue ships but a lil faster)
//
//                                        let venusParent = SCNNode()
//                                      let msun = SCNNode(geometry: SCNSphere(radius: 0.15))
//              let earthParent = SCNNode()
//            let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.2 ,0 , 0))
//         //   venusParent
//             earth.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
//                                earth.physicsBody?.isAffectedByGravity = false
//             earthParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
//                                earthParent.physicsBody?.isAffectedByGravity = false
//
//
//
//
//           // venusParent
//            venusParent.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
//                                      venusParent.physicsBody?.isAffectedByGravity = false
//                venusParent.position = SCNVector3(0,0,-1)
//
//            // venusParent.name = "earth"
//    //         earth.addChildNode(Shoonode)
//            //8328579
//            earN = earthParent
//              earth.name = "earth"
//             earthParent.name = "earthParent"
//                                      earth.position = SCNVector3(0,0,-1)
//                                       earthParent.position = SCNVector3(0,0,-1)
//            earth.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
//            earth.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
//            earthParent.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
//            earthParent.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
//            venusParent.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
//                 venusParent.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
//          //  let frame = self.sceneView.session.currentFrame
//          //  let frame = self.sceneView.
//            // let mat = SCNMatrix4(frame.camera.transform)
//                    for index in 0...6 {
//                        //need to create an array of nodes..each time you shoot check name and if it right one remove 5 reg nodes and the one hit make sure it explode. Make strings var make  this func shorter
//                        //make node array empty in the end of the game func
//                        //decent increase number of ships still seem a bit easy but that might be fine
//                        var Shoonode = SCNNode()
//                        //make it to where it dont kill so many
//                    //var ShoonodeSec = SCNNode()
//                        // var ShoonodeCloserEarP = SCNNode()
//    //                     let earthParent = SCNNode()
//                                      var ssShoonode = SCNNode()
//                                    var ssThShoonode = SCNNode()
//                                    var FourthShoonode = SCNNode()
//    //frts one!!!
//                        let SpaceShscene = SCNScene(named: "art.scnassets/SS1copy.scn")
//                                                ssShoonode = (SpaceShscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
//                                                 ssShoonode.scale = SCNVector3(0.02,0.02,0.02)
//                      //  ssShoonode.
//                        ssShoonode.name = "shark"
//                        //second one
//
//                        let Spacehscene = SCNScene(named: "art.scnassets/SS1copy.scn")
//                                                ssThShoonode = (Spacehscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
//                                                 ssThShoonode.scale = SCNVector3(0.02,0.02,0.02)
//                        ssThShoonode.name = "shark"
//                        // third one
//
//                        let SpacehFscene = SCNScene(named: "art.scnassets/SS1copy.scn")
//                                                                   FourthShoonode = (SpacehFscene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
//                                                                    FourthShoonode.scale = SCNVector3(0.02,0.02,0.02)
//                                           FourthShoonode.name = "shark"
//
//                        //ThirdGroupNodeArray
//                        //name
//    //                    for v in name {
//    //
//    //                        ssShoonode.name = v
//    //                    }
//    //                    name.removeAll()
//                            let moonParent = SCNNode()
//
//                       if (index > 1) && (index % 3 == 0) {
//                        //this good for a level 2.. speed of red shps and white hard to finish in 30 sec
//                       // red
//    //                                  let scene = SCNScene(named: "art.scnassets/spaceARcopy.scn")
//    //                                 Shoonode = (scene?.rootNode.childNode(withName: "SS1redcopy", recursively: true)!)!
//    //                                  Shoonode.scale = SCNVector3(0.03,0.03,0.03)
//    //                                 Shoonode.name = "shark"
//
//
//                        let scene = SCNScene(named: "art.scnassets/SS1copy.scn")
//                                                         FourthShoonode = (scene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
//                                                          FourthShoonode.scale = SCNVector3(0.03,0.03,0.03)
//                                                          FourthShoonode.name = "shark"
//                                  }else{
//                       // blue
//    //                                  let scene = SCNScene(named: "art.scnassets/SS1copy.scn")
//    //                                  FourthShoonode = (scene?.rootNode.childNode(withName: "SS1copy", recursively: true)!)!
//    //                                   FourthShoonode.scale = SCNVector3(0.03,0.03,0.03)
//    //                                   FourthShoonode.name = "shark"
//                        let scene = SCNScene(named: "art.scnassets/spaceARcopy.scn")
//                                                       Shoonode = (scene?.rootNode.childNode(withName: "SS1redcopy", recursively: true)!)!
//                                                        Shoonode.scale = SCNVector3(0.03,0.03,0.03)
//                                                       Shoonode.name = "shark"
//                                  }
//
//
//                        Shoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
//                                           Shoonode.physicsBody?.isAffectedByGravity = false
//                      //  ShoonodeSec.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
//                                           //ShoonodeSec.physicsBody?.isAffectedByGravity = false
//                        Shoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
//                                                              Shoonode.physicsBody?.isAffectedByGravity = false
//                                           ssShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
//                                                             ssShoonode.physicsBody?.isAffectedByGravity = false
//                        FourthShoonode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
//                                                                               FourthShoonode.physicsBody?.isAffectedByGravity = false
//
//                   //    venusParent.addChildNode(Shoonode)
//                        earth.addChildNode(Shoonode)
//                            earth.addChildNode(ssShoonode)
//                                            earth.addChildNode(ssThShoonode)
//                                            earth.addChildNode(FourthShoonode)
//    //                     earth.name = "earth"
//    //                    earthParent.name = "earthParent"
//                      //  earth.addChildNode(ShoonodeSec)
//                        nodeArray.append(Shoonode)
//                     //   nodeArray.append(ShoonodeSec)
//                        ThirdGroupNodeArray.append(FourthShoonode)
//                       SSnodeArray.append(ssShoonode)
//                        SecGroupNodeArray.append(ssThShoonode)
//    //                    let r = ssShoonode
//    //                     let b = ssShoonode
//    //                     let c = ssShoonode
//    //                       Shoonode.addChildNode(ssShoonode)
//    //                     Shoonode.addChildNode(ssThShoonode)
//    //                    Shoonode.addChildNode(FourthShoonode)
//    //                     Shoonode.addChildNode(b)
//    //                    Shoonode.addChildNode(c)
//                    //      ShoonodeSec.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: -0.8, max: 0.5)) -0.8, max: 0.3
//                        Shoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.5))
//
//
//                        //changed this one!!!
//                        ssShoonode.position = SCNVector3(randomFloat(min: -0.1, max: -0.8),randomFloat(min: -0.8, max: 0.3), randomFloat(min: -0.8, max: 0.5))
//
//
//
//                        ssThShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.5))
//                         FourthShoonode.position = SCNVector3(randomFloat(min: -0.8, max: 0.3),randomFloat(min: -0.8, max: 0.3), randomFloat(min: 0.1, max: 0.5))
//
//
//
//                               moonParent.position = SCNVector3(0 ,0 , -1)
//
//                        Shoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
//                              Shoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
//                        //ShoonodeSec.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
//                                               //ShoonodeSec.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
//                        //ssShoonode
//                        ssShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
//                                                                 ssShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
//                        ssThShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
//                                                                                   ssThShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
//                         FourthShoonode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
//                                                                                                     FourthShoonode.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
//
//                        // -0.8
//                               self.sceneView.scene.rootNode.addChildNode(earth)
//                               self.sceneView.scene.rootNode.addChildNode(earthParent)
//                               self.sceneView.scene.rootNode.addChildNode(venusParent)
//
//                               self.sceneView.scene.rootNode.addChildNode(Shoonode)
//                        //self.sceneView.scene.rootNode.addChildNode(ShoonodeSec)
//                        self.sceneView.scene.rootNode.addChildNode(ssShoonode)
//                          self.sceneView.scene.rootNode.addChildNode(ssThShoonode)
//                         self.sceneView.scene.rootNode.addChildNode(FourthShoonode)
//
//
//
//                               let SecRotation = XRotation(time: 300)
//                          let SecRo = XRotation(time: 6)
//                                  let sunAction = Rotation(time: 20)
//                                let earthParentRotation = Rotation(time: 10)
//                        let VRotation = Rotation(time: 6)
//                                let venusParentRotation = XRotation(time: 20)
//                                let earthRotation = Rotation(time: 20)
//                                let moonRotation = Rotation(time: 5)
//                        // decent rotations a bit to easy.. need to make harder to kill big blue and red--show blast hitting maybe with fire but instead ship dont disappear
//                          //  make big ships spin as it Rotate
//                        Shoonode.runAction(SecRo)
//    //                  //  ShoonodeSec.runAction(SecRotation)
//                       ssShoonode.runAction(SecRotation)
//    //                    //FourthShoonode
//                       ssThShoonode.runAction(SecRotation)
//                        FourthShoonode.runAction(SecRotation)
//    //                        ssThShoonode
//                               earthParent.runAction(earthParentRotation)
//                               venusParent.runAction(VRotation)
//                               moonParent.runAction(moonRotation)
//
//
//                               earth.runAction(sunAction)
//                       // earthParent.addChildNode(venusParent)
//                        venusParent.addChildNode(Shoonode)
//
//                        ////****** and ven name*/
//                           //    earthParent.addChildNode(Shoonode)
//                       // earthParent.addChildNode(ShoonodeSec)
//                        earthParent.addChildNode(ssShoonode)
//                      //  ssThShoonode.addChildNode(ssShoonode)
//                        earthParent.addChildNode(ssThShoonode)
//                        earthParent.addChildNode(FourthShoonode)
//                               earthParent.addChildNode(moonParent)
//    //                    for n in SSnodeArray {
//    //                        print("\(n.name) jessss")
//    //                    }
//
//                    }
//                }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
