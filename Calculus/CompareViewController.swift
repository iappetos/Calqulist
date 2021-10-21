//
//  CompareViewController.swift
//  Calqulist
//
//  Created by planB on 11/2/20.
//  Copyright © 2020 Ioannis. All rights reserved.
//

import UIKit
import AVFoundation

class CompareViewController: UIViewController, AVAudioPlayerDelegate {
    
    
    var audioPlayer = AVAudioPlayer()
    var firstNumber = Double()
    var secondNumber = Double()
    var delta = Double()
    var perCentDelta = Double()
    var btnReversalwasPressed: Bool = false
    var sD = CGFloat()
    var sRight = CGFloat()
    var sLeft = CGFloat()
    
   
    
    
    @IBOutlet weak var viewOfComparison: UIView!
    @IBOutlet weak var viewOfDiffLine: UIView!
    @IBOutlet weak var lblTopLeft: UILabel!
    @IBOutlet weak var lblBottomLeft: UILabel!
    @IBOutlet weak var lblTopRight: UILabel!
    @IBOutlet weak var lblBottomRight: UILabel!
    @IBOutlet weak var lblPerCent: UILabel!
    @IBOutlet weak var lblDelta: UILabel!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        showAnimate()
        arrangeSlidingDistance()
        
        
    }
    
    
    
    
    @IBAction func reverseComparedNumbers(_ sender: Any) {
        playSound(file: "Sweep")
        arrangeLabelsAccordingly(basis: self.firstNumber, limit: self.secondNumber)
        writeLabelsOfDeltaAndPerCent(delta: self.delta, perCent: self.perCentDelta)
    }
    
    
    @IBAction func goBack(_ sender: Any) {
        playSound(file: "ClickEnter")
        removeAnimate()
        
    }
    
    
    
    func playSound(file: String){
        
        let soundURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: file, ofType: "wav")!)

               do{
                   audioPlayer = try AVAudioPlayer(contentsOf: soundURL as URL)

               }catch {
                   print("there was some error. The error was \(error)")
               }
               audioPlayer.play()
        
    }
    
    
    
    
}//class


extension CompareViewController   {
    
    func configureView(){
           self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
           self.viewOfComparison.layer.cornerRadius = 10
           self.viewOfDiffLine.layer.cornerRadius = 10
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 9
        formatter.numberStyle = .decimal
        
        
        let perCentFormatter = NumberFormatter()
        perCentFormatter.minimumFractionDigits = 0
        perCentFormatter.maximumFractionDigits = 2
        perCentFormatter.numberStyle = .decimal
        
        if firstNumber > secondNumber {
            self.lblTopLeft.text = formatter.string(from: self.firstNumber as NSNumber)
            self.lblTopRight.text = ""
            self.lblBottomLeft.text = ""
            self.lblBottomRight.text = formatter.string(from: self.secondNumber as NSNumber)
        } else {
            self.lblTopLeft.text = ""
            self.lblTopRight.text = formatter.string(from: self.secondNumber as NSNumber)
            self.lblBottomLeft.text = formatter.string(from: self.firstNumber as NSNumber)
            self.lblBottomRight.text = ""
        }
        
        
        
           self.lblDelta.text = formatter.string(from: self.delta as NSNumber)
           self.lblPerCent.text = perCentFormatter.string(from: self.perCentDelta as NSNumber)! + "%"
        
        
        
        self.lblTopLeft.adjustsFontSizeToFitWidth = true
        self.lblTopRight.adjustsFontSizeToFitWidth = true
        self.lblBottomLeft.adjustsFontSizeToFitWidth = true
        self.lblBottomRight.adjustsFontSizeToFitWidth = true
        self.lblDelta.adjustsFontSizeToFitWidth = true
        self.lblPerCent.adjustsFontSizeToFitWidth = true
        
        
        
        
        
    }//Func
    
    
    
    
    
    func arrangeLabelsAccordingly(basis: Double, limit: Double) {
        
        if basis < limit { //I initially wanted to Know growth perCentage
            
             if !btnReversalwasPressed {
                //initially topLeft/bottomRight are Empty so TopRight & BottomLeft will move
                moveTopRightLabeltoTheLeft()
                moveBottomLeftLabeltoTheRight()
                btnReversalwasPressed = true
                self.delta *= -1
                self.perCentDelta = 100 * self.delta / limit
                
             
                
                
             } else {
                //Button was pressed once so I have to move labels back
                moveTopRightLabeltoTheRight()
                moveBottomLeftLabeltoTheLeft()
                btnReversalwasPressed = false
                self.delta *= -1
                self.perCentDelta = 100 * self.delta / basis
                
              
                
                
                
            }
            
            
            
        } else {  //I initially wanted to Know Reduction perCentage
            
            if !btnReversalwasPressed {
                //initially topRight/bottomLeft are Empty so TopLeft & BottomRight will move
                moveTopLeftLabeltoTheRight()
                moveBottomRightLabeltoTheLeft()
                btnReversalwasPressed = true
                self.delta *= -1
                self.perCentDelta = 100 * self.delta / limit
                
              
                
            } else {
                //Button was pressed once so I have to move labels back
                moveTopLeftLabeltoTheLeft()
                moveBottomRightLabeltoTheRight()
                btnReversalwasPressed = false
                self.delta *= -1
                self.perCentDelta = 100 * self.delta / basis
                
             
            }
            
        }//BasisLimit
    }//Func
    
   
       func writeLabelsOfDeltaAndPerCent(delta: Double, perCent: Double){
                  let formatter = NumberFormatter()
                  formatter.minimumFractionDigits = 0
                  formatter.maximumFractionDigits = 9
                  formatter.numberStyle = .decimal
                  
                  
                  let perCentFormatter = NumberFormatter()
                  perCentFormatter.minimumFractionDigits = 0
                  perCentFormatter.maximumFractionDigits = 2
                  perCentFormatter.numberStyle = .decimal
           
           self.lblDelta.text = formatter.string(from: delta as NSNumber)
           self.lblPerCent.text = perCentFormatter.string(from: perCent as NSNumber)! + "%"
           
       }


    
    
    func arrangeSlidingDistance(){
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        print("sWid: \(screenWidth)")
        
        if screenWidth < 700 {
            self.sD = screenWidth * 0.5
        } else {
             self.sD = screenWidth * 0.6
        }
    
        
    }//Func
    
    
    
}//ext
    
    
   
    
extension CompareViewController {
    
    
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
    
    
    //Top
       //TopRight
    func moveTopRightLabeltoTheLeft() {
        UIView.animate(withDuration: 0.3, animations: {
            self.lblTopRight.center = CGPoint(x: self.lblTopRight.center.x - self.sD, y: self.lblTopRight.center.y)
        })
    }
    
    
    func moveTopRightLabeltoTheRight() {
        UIView.animate(withDuration: 0.3, animations: {
            self.lblTopRight.center = CGPoint(x: self.lblTopRight.center.x + self.sD, y: self.lblTopRight.center.y)
        })
    }
        //TopLeft
    func moveTopLeftLabeltoTheLeft() {
        UIView.animate(withDuration: 0.3, animations: {
            self.lblTopLeft.center = CGPoint(x: self.lblTopLeft.center.x - self.sD, y: self.lblTopLeft.center.y)
        })
    }
    
    
    func moveTopLeftLabeltoTheRight() {
        UIView.animate(withDuration: 0.3, animations: {
            self.lblTopLeft.center = CGPoint(x: self.lblTopLeft.center.x+self.sD, y: self.lblTopLeft.center.y)
        })
    }
    
    //BOTTOM
          //BottomRight
    func moveBottomRightLabeltoTheRight() {
        UIView.animate(withDuration: 0.3, animations: {
            self.lblBottomRight.center = CGPoint(x: self.lblBottomRight.center.x+self.sD, y: self.lblBottomRight.center.y)
        })
    }
    
    
    func moveBottomRightLabeltoTheLeft() {
        UIView.animate(withDuration: 0.3, animations: {
            self.lblBottomRight.center = CGPoint(x: self.lblBottomRight.center.x-self.sD, y: self.lblBottomRight.center.y)
        })
    }
    
    
          //BottomLeft
    func moveBottomLeftLabeltoTheRight() {
        UIView.animate(withDuration: 0.3, animations: {
            self.lblBottomLeft.center = CGPoint(x: self.lblBottomLeft.center.x+self.sD, y: self.lblBottomLeft.center.y)
        })
    }
    
    
    func moveBottomLeftLabeltoTheLeft() {
        UIView.animate(withDuration: 0.3, animations: {
            self.lblBottomLeft.center = CGPoint(x: self.lblBottomLeft.center.x-self.sD, y: self.lblBottomLeft.center.y)
        })
    }
    
    
       

    
    
}//ext Effect







/*
 func arrangeComparison(){
        
          let formatter = NumberFormatter()
              formatter.minimumFractionDigits = 0
              formatter.maximumFractionDigits = 9
              formatter.numberStyle = .decimal
        
        
        
        let perCentFormatter = NumberFormatter()
        perCentFormatter.minimumFractionDigits = 0
        perCentFormatter.maximumFractionDigits = 2
        perCentFormatter.numberStyle = .decimal
        
        let a = self.firstNumber
        let b = self.secondNumber
       
        
        
        
        if a < b {//I wanted to Know growth perCentage
            
            
            if self.lblTopLeft.text == "" { //initially topLeft is Empty
                
                //Now topLeft must get the secondNum
                 self.lblTopLeft.text = formatter.string(from: b as NSNumber)
                //BottomRight must get the FistNumber
                self.lblBottomRight.text = formatter.string(from: a as NSNumber)
                //Both other Empty
                self.lblTopRight.text = ""
                self.lblBottomLeft.text = ""
                
                //The difference is now negative
                self.delta *= -1
                //New p calq as now I want to see the reduction Pososto
                self.perCentDelta = 100 * self.delta / b
                
                
            } else {//I have to go back to the state I entered
                
                
                
                           self.lblTopLeft.text = ""
                           self.lblBottomRight.text = ""
                           self.lblTopRight.text = formatter.string(from: b as NSNumber)
                           self.lblBottomLeft.text = formatter.string(from: a as NSNumber)
                           
                           //The difference is now positive again
                           self.delta *= -1
                           //p to a again
                            self.perCentDelta = 100 * self.delta / a
                
                
                
            }//if topLeft = ""
            
           
            
        } else {//b<a and I wanted to Know reduction perCentage
            
            if self.lblTopRight.text == "" { //initially topRight is Empty
                //Now TopRight must get the first Num
                 self.lblTopRight.text = formatter.string(from: a as NSNumber)
                //BottomLeft the second
                 self.lblBottomLeft.text = formatter.string(from: b as NSNumber)
                //other ""
                self.lblTopLeft.text = ""
                self.lblBottomRight.text = ""
                
                //The difference is now positive
                self.delta *= -1
                //New p calq as now I want to see growth Pososto
                self.perCentDelta = 100 * self.delta / b
                
                
                
            } else {//I have to go back to the state I entered
                
                self.lblTopRight.text = ""
                self.lblBottomLeft.text = ""
                self.lblTopLeft.text = formatter.string(from: a as NSNumber)
                self.lblBottomRight.text = formatter.string(from: b as NSNumber)
               
                //The difference is now negative
                self.delta *= -1
                //New p calq as now I want to see reduction Pososto
                self.perCentDelta = 100 * self.delta / a
                
    
                
            }//lbl = ""
        }//a<b
        
        self.lblDelta.text = formatter.string(from: self.delta as NSNumber)
        self.lblPerCent.text = perCentFormatter.string(from: self.perCentDelta as NSNumber)! + "%"
        
        
        
        
        
        
    }//Func
    
    
    
    
    
    
 */




 

/*
 
    
    func arrangeSlidingDistance(){
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        print("sWid: \(screenWidth)")
        
        
        
        let a: CGRect = self.lblTop.bounds
        let b: CGRect = self.lblTopRight.bounds
        let c: CGRect = self.lblBottomRight.bounds
        let d: CGRect = self.lblBottom.bounds
        
        let la = a.width
        let lb = b.width
        let lc = c.width
        let ld = d.width
        
         print("la: \(la)")
         print("lb: \(lb)")
         print("lc: \(lc)")
         print("ld: \(ld)")
        
        
        
        
        self.sD = screenWidth - 20 - la - self.lblTopRight.center.x
        self.sLeft = screenWidth - 40 - lb
        
        
        
        
        
        
        
        /*
        if screenWidth < 700 {
            self.sD = screenWidth * 0.75
        } else {
             self.sD = screenWidth * 0.90
        }
       */
    }//Func
    
    
    
    
 */



/*

 
 func changeLabelAlignment(){
     if self.lblTopRight.textAlignment == NSTextAlignment.right {
         self.lblTopRight.textAlignment = NSTextAlignment.left
         self.lblBottomLeft.textAlignment = NSTextAlignment.right
     } else {
         self.lblTopRight.textAlignment = NSTextAlignment.right
         self.lblBottomLeft.textAlignment = NSTextAlignment.left
     }
    
 }//Func
 
 */
