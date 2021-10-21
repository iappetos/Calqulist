//
//  ExportingFunctions.swift
//  Calqulist
//
//  Created by Ioannis Karagogos on 14/1/20.
//  Copyright © 2020 Ioannis Karagogos. All rights reserved.
//

import Foundation
import UIKit
import MessageUI


extension ViewController{
    
    func exportEquation(){

          let exportAlert = UIAlertController(title: nil,
                                                    message: nil/*"What do you want to do?"*/,
                                                    preferredStyle: UIAlertController.Style.actionSheet)
          
          
          
          
          
          
          
          //ACTION 1: κοινή χρήση
          exportAlert.addAction(UIAlertAction(title:"Share"/*"Κοινή χρήση"*/, style: .default, handler:{(action) in
              
              
              
              
              if MFMailComposeViewController.canSendMail() {
                  let mail = MFMailComposeViewController()
                  mail.mailComposeDelegate = self
                  //mail.setToRecipients(["ikaragogos@gmail.com"])
                  mail.setSubject("my calculations with Calqulist")
                  
                  
                  
                  let formatter = NumberFormatter()
                  formatter.minimumFractionDigits = 0
                  formatter.maximumFractionDigits = 9
                  formatter.numberStyle = .decimal
                  
                  
                
                
                
                //if Math
                if self.isMathematicalOn {
                    self.createMathematicalArrayToCopy()
                } else {
                     self.createArrayToCopy()
                }
               
                
                
                
                  let lastIndex = self.arrayOfNumbers.count - 1
                  let stringOfLastNumber = formatter.string(from: self.arrayOfNumbers[lastIndex] as NSNumber)
                  let result = formatter.string(from: self.resultDisplayed as NSNumber)
                  
                  
                  
                  mail.setMessageBody("Hi,</br><p> <p>" + self.mailMessage + stringOfLastNumber! + " = " + result! + "</br></br>" + " my calculations with Calqulist" , isHTML: true)
                  
                  
                  //Mail
                  self.present(mail, animated: true)
                  
                  
                  
                  //Share
                  let sharedMessage =  self.mailMessage + stringOfLastNumber! + " = " + result! + "my calculations with Calqulist"
                     let activityVC = UIActivityViewController(activityItems: [sharedMessage], applicationActivities: [])
                     activityVC.popoverPresentationController?.sourceView = self.view
                     self.present(activityVC, animated: true, completion: nil)
                  
              } else {
                  print("Mail services are not available")
              }
              
              
              self.mailMessage = ""
              
              
              
              
              
              
          }))
          
          //ACTION 2: Αντιγραφή πλήρους εξίσωσης
          exportAlert.addAction(UIAlertAction(title:"Copy complete equation"/*"Αντιγραφή πλήρους εξίσωσης"*/, style: .default, handler:{(action) in
              let pasteBoard = UIPasteboard.general
              
              let formatter = NumberFormatter()
              formatter.minimumFractionDigits = 0
              formatter.maximumFractionDigits = 9
              formatter.numberStyle = .decimal
              
              
               //if Math
                if self.isMathematicalOn {
                    self.createMathematicalArrayToCopy()
                } else {
                    self.createArrayToCopy()
                       }
            
              let lastIndex = self.arrayOfNumbers.count - 1
              let stringOfLastNumber = formatter.string(from: self.arrayOfNumbers[lastIndex] as NSNumber)
              let result = formatter.string(from: self.resultDisplayed as NSNumber)
              
              
              pasteBoard.string = self.mailMessage + stringOfLastNumber! + " = " + result!
              
              self.mailMessage = ""
           }))
          
          //ACTION 3 : Αντιγραφή αποτελέσματος
          exportAlert.addAction(UIAlertAction(title:"Copy Result"/*"Αντιγραφή αποτελέσματος"*/, style: .default, handler:{(action) in
              let pasteBoard = UIPasteboard.general
              
              let formatter = NumberFormatter()
              formatter.minimumFractionDigits = 0
              formatter.maximumFractionDigits = 9
              formatter.numberStyle = .decimal
              
              let result = formatter.string(from: self.resultDisplayed as NSNumber)
              
              
              pasteBoard.string = result!
              
              self.mailMessage = ""
              
              
          }))
          
          
          exportAlert.addAction(UIAlertAction(title:"Cancel", style: .cancel, handler:{(action) in
              print("Canceled ")
              
          }))
          
          
          
          //in order to present the alert while in search
          if let presentedVC = presentedViewController {
              presentedVC.present(exportAlert, animated:true, completion: nil)
          } else {
              present(exportAlert, animated:true, completion: nil)
          }
          
          
        
          
          
    }//FuncExportEquation
    
    
    
    
    
       public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
           controller.dismiss(animated: true, completion: nil)
       }
       
     
       
       
       
       func createArrayToCopy(){
          
           createArrayOfParenthesis()
           
           let formatter = NumberFormatter()
           formatter.minimumFractionDigits = 0
           formatter.maximumFractionDigits = 9
           formatter.numberStyle = .decimal
           
           for i in 0...self.arrayOfNumbers.count - 2 {
           let stringOfNumber = formatter.string(from: self.arrayOfNumbers[i] as NSNumber)
               
               //let stringForMessage = String(self.arrayOfNumbers[i]) + par + String(self.arrayOfFactors[i+1])
               let stringForMessage = stringOfNumber! + String(self.arrayOfParenthesis[i+1])
               
               self.mailMessage = self.mailMessage + stringForMessage
           }

           self.mailMessage = self.leftParenthesis + self.mailMessage
          
           self.leftParenthesis = ""
           self.arrayOfParenthesis = []
           
           
       }
       
       
       
       
       func createArrayOfParenthesis(){
           var countPar: Int = 0
           
           self.arrayOfParenthesis = self.arrayOfFactors
           print("arrayOfParentBefore: \(self.arrayOfParenthesis)")
           
           for i in 0...self.arrayOfParenthesis.count - 2 {
               if self.arrayOfParenthesis[i] ==  "+" && self.arrayOfParenthesis[i+1] == "✕"  {
                   self.arrayOfParenthesis[i+1] = ")✕"
                   countPar += 1
               } else if self.arrayOfParenthesis[i] ==  "+" && self.arrayOfParenthesis[i+1] == "÷"  {
                   self.arrayOfParenthesis[i+1] = ")/"
                   countPar += 1
               } else if self.arrayOfParenthesis[i] ==  "-" && self.arrayOfParenthesis[i+1] == "✕"  {
                   self.arrayOfParenthesis[i+1] = ")✕"
                   countPar += 1
               } else if self.arrayOfParenthesis[i] ==  "-" && self.arrayOfParenthesis[i+1] == "÷"  {
                   self.arrayOfParenthesis[i+1] = ")/"
                   countPar += 1
               }
            
           }
           
           
           
           if countPar == 0 {
               //DO Nothing
           } else {
               for _ in 0...countPar - 1 {
                   self.leftParenthesis = self.leftParenthesis + "("
               }
           }
           
       
           print("00000000000arrayOfParent: \(self.arrayOfParenthesis)")
           print("lefty: \(self.leftParenthesis)")
           
       }//Func
       
       
    
    func createMathematicalArrayToCopy(){
        let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 9
            formatter.numberStyle = .decimal
                 
                 for i in 0...self.arrayOfNumbers.count - 2 {
                 let stringOfNumber = formatter.string(from: self.arrayOfNumbers[i] as NSNumber)
                 let stringForMessage = stringOfNumber! + String(self.arrayOfFactors[i+1])
                 self.mailMessage = self.mailMessage + stringForMessage
                 }

        
    }//Func
    
    
    
    
    
    
    
    
    
    
}//EndAll
