//
//  ProKioskViewController.swift
//  Calqulist
//
//  Created by planB on 10/2/20.
//  Copyright © 2020 Ioannis. All rights reserved.
//

import UIKit
import MessageUI


class PKioskViewController: UIViewController {
    
    
    @IBOutlet weak var viewOfPaidKiosk: UIView!
    @IBOutlet weak var btnRate: UIView!
    @IBOutlet weak var btnContactUs: UIView!
    @IBOutlet weak var btnBack: UIButton!
    
    override func viewDidLoad() {
           super.viewDidLoad()
           
           
           
           configureView()
           showAnimate()
       }
       
    func configureView(){
           self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
           self.viewOfPaidKiosk.layer.cornerRadius = 10
          
       }
    
    
    
    
    
    @IBAction func backToCalqulist(_ sender: Any) {
        removeAnimate()
    }
    
    
    @IBAction func contactUs(_ sender: Any) {
        composeMail()
    }
    
    
    
    @IBAction func rateApp(_ sender: Any) {
        if let url = NSURL(string:"itms-apps://itunes.apple.com/app/id1490575678") {
                       UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                   }
    }
    
    
    
}


extension PKioskViewController   {
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


extension PKioskViewController: MFMailComposeViewControllerDelegate {
    
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

