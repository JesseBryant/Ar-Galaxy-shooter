//
//  FBLoadController.swift
//  Shoot N' Guns
//
//  Created by Zaini on 27/05/2020.
//  Copyright © 2020 Jesse Bryant. All rights reserved.
//

import UIKit
import FBAudienceNetwork

class FBLoadController: UIViewController,FBInterstitialAdDelegate {

    var interstitial: FBInterstitialAd!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       InterstitialAd()
        // Do any additional setup after loading the view.
    }
    
    func InterstitialAd(){
        interstitial = FBInterstitialAd(placementID: "229174575034368_230531631565329")
        interstitial.delegate = self
        interstitial.load()
    }
    
    @IBAction func fbBtutton(){
       //  interstitial.delegate = self
         interstitial.show(fromRootViewController: self)
    }
    
    
    func interstitialAd(_ interstitialAd: FBInterstitialAd, didFailWithError error: Error) {
        print("not loaded")
    }
    
    func interstitialAdDidLoad(_ interstitialAd: FBInterstitialAd) {
       // interstitial.show(fromRootViewController: self)
    }

    func interstitialAdWillClose(_ interstitialAd: FBInterstitialAd) {
        InterstitialAd()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
