/// Copyright (c) 2018 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import StoreKit
var CoinsAvaa = 0
public typealias ProductIdentifier = String
public typealias ProductsRequestCompletionHandler = (_ success: Bool, _ products: [SKProduct]?) -> Void

extension Notification.Name {
  static let IAPHelperPurchaseNotification = Notification.Name("IAPHelperPurchaseNotification")
}
var r: ViewController!
 let defaultss = UserDefaults.standard
 func showPremiumQuotes() {
        //NEXT
        //next Ar capabili
        //master waves
        //finish in app menu
        //test test test( for perfec(lke bes games) and monetize
        //APPLE approval test
        // vid and screenshot
         let productID = "786978678678678"
        UserDefaults.standard.set(true, forKey: productID)
        
        //   quotesToShow.append(contentsOf: premiumQuotes)
        // tableView.reloadData()
        //self.Coins = Coins + 10
        //in app works... Transaction successful!
        //need to sub or add less cuz it goes too next level
        //well do add 5 for now.. for 1.99 look at other games in app purchases
       CoinsAvaa+=600
        //defaultss.set(self.Coins, forKey: "Coins")
        defaultss.set(CoinsAvaa, forKey: "CoinsAva")
        print("\(CoinsAvaa) Coins")
        //        self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
        //                                  node.removeFromParentNode()
        //                              }
        //next make sure message correspond to score probably be better to have wave that lead to next level. increase game play and help better solve issue of not having to shoot every ship. help with points because unless score met ill just keep redoing level(on average 2) and message label = wave 4 ect...or can keep simple but risk consistency...Ar shoot sim to first but even session..My solution=== reward right amount of points crete large range fr levels. Make sure with the way points rewarded user cant skip levels --leaderboard/ach ---dope ui --- bugs --approval req/doc
        //
//        if Time {
//            r.self.resetTimer(time: 45)
//            r.self.runTimer()
//        } else {
////            self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
////                node.removeFromParentNode()
////            }
////            //make sure cancel ends game and every scenerio
////            self.resetTimer(time: 45)
////
////            self.play()
//        }
//        
//        Time = false
        
    }
open class IAPHelper: NSObject  {
    private let productIdentifiers: Set<ProductIdentifier>
    private var purchasedProductIdentifiers: Set<ProductIdentifier> = []
    private var productsRequest: SKProductsRequest?
    private var productsRequestCompletionHandler: ProductsRequestCompletionHandler?
    public init(productIds: Set<ProductIdentifier>) {
        productIdentifiers = productIds
    super.init()
  }
}

// MARK: - StoreKit API

extension IAPHelper {
  
  public func requestProducts(completionHandler: @escaping ProductsRequestCompletionHandler) {
    productsRequest?.cancel()
    productsRequestCompletionHandler = completionHandler

    productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
    productsRequest!.delegate = self
    productsRequest!.start()
  }

  public func buyProduct(_ product: SKProduct) {
  }

  public func isProductPurchased(_ productIdentifier: ProductIdentifier) -> Bool {
    return false
  }
  
  public class func canMakePayments() -> Bool {
    return true
  }
  
  public func restorePurchases() {
  }
}
// MARK: - SKProductsRequestDelegate

extension IAPHelper: SKProductsRequestDelegate {

  public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
    print("Loaded list of products...")
    let products = response.products
    productsRequestCompletionHandler?(true, products)
    clearRequestAndHandler()

    for p in products {
      print("Found product: \(p.productIdentifier) \(p.localizedTitle) \(p.price.floatValue)")
    }
  }
  
  public func request(_ request: SKRequest, didFailWithError error: Error) {
    print("Failed to load list of products.")
    print("Error: \(error.localizedDescription)")
    productsRequestCompletionHandler?(false, nil)
    clearRequestAndHandler()
  }

  private func clearRequestAndHandler() {
    productsRequest = nil
    productsRequestCompletionHandler = nil
  }
}
