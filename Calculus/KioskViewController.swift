//
//  UpgradeViewController.swift
//  Calqulist
//
//  Created by Ioannis Karagogos on 27/1/20.
//  Copyright © 2020 Ioannis Karagogos . All rights reserved.
//

import UIKit
import StoreKit
import MessageUI
import SwiftKeychainWrapper


//---------for rate App---------------------
var stringOfNSURL = "itms-apps://itunes.apple.com/app/id1490575678"



class KioskViewController: UIViewController {
    
    //initializing the IAPManager I start collecting products from the store
    let storeManager = IAPManager()
    var myProductOnShelf: SKProduct?
    
    var myProductTitle = String()
    var myProductDescripton = String()
    var myProductPrice = String()
    
    var listOfProducts = [SKProduct]()
    
    var prizeTaken: String = " "// = String()
    
    
    @IBOutlet weak var imageFunc: UIImageView!
    @IBOutlet weak var viewOfUpgrade: UIView!
    @IBOutlet weak var lblPrize: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storeManager.delegate = self
        
        configureView()
        showAnimate()
    }
    
    func configureView(){
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.viewOfUpgrade.layer.cornerRadius = 10
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
            self.lblPrize.text = self.prizeTaken
        })
      
       
    }
        
    
    
    
    
    @IBAction func rateApp(_ sender: Any) {
        if let url = NSURL(string: stringOfNSURL /*"itms-apps://itunes.apple.com/app/id1490575678"*/) {
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                        
    }
    }
    
    
    @IBAction func contactUs(_ sender: Any) {
       composeMail()
    }
    
    
    
    @IBAction func cancel(_ sender: Any) {
        removeAnimate()
    }
    
    
    
    @IBAction func upgradeNow(_ sender: Any) {
        if self.lblPrize.text == "connection required!!!" || self.lblPrize.text == " " {
            showConnectionAlert()
        } else {
            //PROTOCOLS---------------------------------
            //In order the gameView labels to be informed immediatelly
            //unlimitedDelegate.didSelectUnlimited(isUnlocked: true)
            storeManager.makePaymentForProduct(myProduct: myProductOnShelf!)
            removeAnimate()
        }
       
    }//F
    
    
    @IBAction func restore(_ sender: Any) {
        storeManager.restoreCompletedTransactions()
        removeAnimate()
    }
    
 /* ιν ορδε το Restart your application ςηεν restored
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
          nonConsumablePurchaseMade7 = true
          UserDefaults.standard.set(nonConsumablePurchaseMade7, forKey: "nonConsumablePurchaseMade7")
    
          UIAlertView(title: "DeriveesPRO",
                      message: "You've successfully restored your purchase! Restart your application!",
                      delegate: nil, cancelButtonTitle: "OK").show()
      }
    
  */
    
    
    
    
   
}//class



extension KioskViewController: StoreManagerDelegate {
    
    
    func updateWithProducts(products: [SKProduct]) {
        self.myProductOnShelf = products[0]
        self.prizeTaken = "just for " + self.myProductOnShelf!.localizedPrice()
    }
}



extension KioskViewController: MFMailComposeViewControllerDelegate {
    
    func composeMail(){
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["iappetos1@gmail.com"])
            mail.setSubject("Comments about Calqulist")
            mail.setMessageBody("<p>Hi,</p>", isHTML: true)
            present(mail, animated: true)
        } else {
            print("Mail services are not available")
        }
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
           controller.dismiss(animated: true)
       }
    
    
    
}//ext




extension KioskViewController   {
     //Effects
    func showAnimate(){
           self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
           self.view.alpha = 0.0;
           UIView.animate(withDuration: 0.25, animations: {
               self.view.alpha = 1.0
               self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
           });
       }//F
       
       func removeAnimate(){
           UIView.animate(withDuration: 0.25, animations: {
               self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
               self.view.alpha = 0.0;
           }, completion:{(finished : Bool)  in
               if (finished)
               {
                  self.view.removeFromSuperview()
               
               }
           });
       }//F
    
    
     //Alerts
    func showConnectionAlert(){
    let noCnnectionAlert = UIAlertController(title: "Attention!!!",
                                    message: "Please, connect to the internet in order to upgrade.",
                                    preferredStyle: UIAlertController.Style.alert)
    let okAction = UIAlertAction(title: "Ok",
                                 style: UIAlertAction.Style.default,
                                 handler: nil)
    
    noCnnectionAlert.addAction(okAction)
    
    self.present(noCnnectionAlert, animated:true, completion: nil)
    

}

}//ext
