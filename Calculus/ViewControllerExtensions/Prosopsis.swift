//
//  File.swift
//  Calqulist
//
//  Created by Ioannis Karagogos on 14/1/20.
//  Copyright © 2020 Ioannis Karagogos. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {
    
    //MARK: 
    
    func putDotOrComma(){
        if Locale.current.decimalSeparator == "." {
            self.buttonDotComma.titleLabel?.text = "."
        } else {
            self.buttonDotComma.titleLabel?.text = ","
        }
    }
    
    
    
    
    
    
    
    //MARK: Buttons in & out
    
    
    func hideEditMail(){
        self.constraintMailTrailing.constant = 55
        self.constraintEditTrailing.constant = 55
        self.myTableView.isEditing = false
        self.buttonEdit.setTitle("Edit", for: .normal)
        self.buttonEdit.setTitleColor(UIColor.white, for: .normal)
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func showEditMail(){
        self.constraintMailTrailing.constant = 0
        self.constraintEditTrailing.constant = 0
         self.constraintEditHeight.constant = 35
        self.constraintMailHeight.constant = 35
        self.buttonMail.setTitle("↑", for: .normal)
        self.buttonMail.setTitleColor(.white, for: .normal)
        self.buttonMail.backgroundColor = UIColor.black
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func showMailOnly(){
        self.constraintMailTrailing.constant = 0
        self.constraintEditTrailing.constant = 0
        self.constraintEditHeight.constant = 0
        self.constraintMailHeight.constant = 70
        self.buttonMail.setTitle("ℹ︎", for: .normal)
        self.buttonMail.setTitleColor(.white, for: .normal)
        self.buttonMail.backgroundColor = UIColor.black
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func showMailOnlyWithDotAndWhite(){
        self.constraintMailTrailing.constant = 0
               self.constraintEditTrailing.constant = 0
               self.constraintEditHeight.constant = 0
               self.constraintMailHeight.constant = 70
               self.buttonMail.setTitle("○", for: .normal)
               self.buttonMail.backgroundColor = UIColor.white
               self.buttonMail.setTitleColor(.blue, for: .normal)
               UIView.animate(withDuration: 0.3, animations: {
                   self.view.layoutIfNeeded()
               })
        
    }
    
    
    func arrangeBigDot() {
        isFirstDotPressed = true
                          
        //cleanSelections
        
        if arrayOfDots.count < 1 {
            self.arrayOfDots[0] = "○"
        } else {
            for i in 0...arrayOfDots.count - 1 {
                       self.arrayOfDots[i] = "○"
                   }
            
        }
        
        
        if self.arrayOfNumbers.count > 2 {
            showEditMail()
        } else {
            showMailOnly()
        }
        
        
    }
    
    
    
    
    
    func hidePerCent(){
       // self.constraintTransparentLead.constant = 0
       // self.constraintEntryLead.constant = 0
        self.constraintEraseWidth.constant = 0
        self.constraintPerCentLead.constant = -55
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func showPerCent(){
       // self.constraintTransparentLead.constant = 0
      //  self.constraintEntryLead.constant = 0
        self.constraintEraseWidth.constant = 55
        self.constraintPerCentLead.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        
        
        
    }
    
    
    //MARK: Animations
    
      func pulseEntryField(){
          let pulse = CASpringAnimation(keyPath: "transform.scale")
          pulse.duration = 0.6
          pulse.fromValue = 0.95
          pulse.toValue = 1.0
          pulse.autoreverses = true
          pulse.repeatCount = 2
          pulse.initialVelocity = 0.5
          pulse.damping = 1.0
          
          self.entryField.layer.add(pulse, forKey: nil)
      }
      
      
      func pulseResultDisplay(){
          let pulse = CASpringAnimation(keyPath: "transform.scale")
          pulse.duration = 0.6
          pulse.fromValue = 0.95
          pulse.toValue = 1.0
          pulse.autoreverses = true
          pulse.repeatCount = 2
          pulse.initialVelocity = 0.5
          pulse.damping = 1.0
          
          self.buttonResult.layer.add(pulse, forKey: nil)
      }
    
    func flashEntryField(){
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash.toValue = 0.4
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        
        self.entryField.layer.add(flash, forKey: nil)
        self.buttonTransparent.titleLabel?.layer.add(flash, forKey: nil)
    }
    
    
    func flashResultDisplay(){
       let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash.toValue = 0.4
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        
        self.buttonResult.layer.add(flash, forKey: nil)
        
    }
    
    
    func flashNumberButtons(){
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash.toValue = 0.4
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        
        self.buttonNumber0.layer.add(flash, forKey: nil)
        self.buttonNumber1.layer.add(flash, forKey: nil)
        self.buttonNumber2.layer.add(flash, forKey: nil)
        self.buttonNumber3.layer.add(flash, forKey: nil)
        self.buttonNumber4.layer.add(flash, forKey: nil)
        self.buttonNumber5.layer.add(flash, forKey: nil)
        self.buttonNumber6.layer.add(flash, forKey: nil)
        self.buttonNumber7.layer.add(flash, forKey: nil)
        self.buttonNumber8.layer.add(flash, forKey: nil)
        self.buttonNumber9.layer.add(flash, forKey: nil)
        
    }
    
    
    
    
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
    
    
    
    
    
    
    
    //MARK: FactorPad
 
    
    func revealOrHideFactorPad(){
       
        factorsAreVisible = !factorsAreVisible
        
        if factorsAreVisible {
            //make them invisible
            self.constraintPadTrailing.constant = -110
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
            
          self.buttonShow.setTitle("⇥", for: .normal)
            
          
            
            if self.arrayOfFactors.count == 0 {
                self.buttonPlus.setTitle("", for: .normal)
                self.buttonMinus.setTitle("Enter", for: .normal)
                self.buttonTimes.setTitle("⏎", for: .normal)
                self.buttonDivide.setTitle("", for: .normal)
                
                self.conMinusToPlus.constant = 0
                self.conTimesToMinus.constant = 0
                self.conDivideToTimes.constant = 0
                
                
            } else {
                self.buttonPlus.setTitle("+", for: .normal)
                self.buttonMinus.setTitle("-", for: .normal)
                self.buttonTimes.setTitle("✕", for: .normal)
                self.buttonDivide.setTitle("÷", for: .normal)
                
                self.conMinusToPlus.constant = 1
                self.conTimesToMinus.constant = 1
                self.conDivideToTimes.constant = 1
                
                
            }
            if factorsWereNeverRevealedSoFar {
                flashNumberButtons()
                factorsWereNeverRevealedSoFar = false
            }
            
            
            
            
        } else {
            //No Visible Factors so REVEAL them
            self.constraintPadTrailing.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
            
            //...and change the arrow on ButtonShow
            self.buttonShow.setTitle("⇤", for: .normal)
            
            //  self.buttonTransparent.setTitle(GlobalVariable.myOwnFactor, for: .normal)
           // self.buttonTransparent.setTitle("⏎", for: .normal)
            self.pressedPlus = false
            self.pressedMinus = false
            self.pressedTimes = false
            self.pressedDivide = false
            
            
            
        }
        
     
    }//Func
    
    func revealFactorsPad(){
        //REVEAL them
        self.constraintPadTrailing.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        
        //...and change the arrow on ButtonShow
        self.buttonShow.setTitle("⇤", for: .normal)
        
        //  self.buttonTransparent.setTitle(GlobalVariable.myOwnFactor, for: .normal)
        self.buttonTransparent.setTitle("⏎", for: .normal)
        self.pressedPlus = false
        self.pressedMinus = false
        self.pressedTimes = false
        self.pressedDivide = false
    }
    
    
    
    
    
    
    
    
    
    
    
    func entitleButtonShowCorrectly(){
        
        if factorsAreVisible {
             self.buttonShow.setTitle("⇥", for: .normal)
        } else {
             self.buttonShow.setTitle("⇤", for: .normal)
        }
        
        let rgbColor = #colorLiteral(red: 0.9995599389, green: 0.6582826972, blue: 0.001935746637, alpha: 1)
        self.buttonShow.setTitleColor(rgbColor, for: .normal)
       
        let inactiveFactorColor = #colorLiteral(red: 0.9981611371, green: 0.7537821531, blue: 0, alpha: 1)
        self.buttonPlus.setTitleColor(inactiveFactorColor, for: .normal)
        self.buttonMinus.setTitleColor(inactiveFactorColor, for: .normal)
        self.buttonTimes.setTitleColor(inactiveFactorColor, for: .normal)
        self.buttonDivide.setTitleColor(inactiveFactorColor, for: .normal)
        
        
        self.buttonPlus.isEnabled = false
        self.buttonMinus.isEnabled = false
        self.buttonTimes.isEnabled = false
        self.buttonDivide.isEnabled = false
        
        
        
        
    }
    
    
    func putCorrectSymbolInButtonShow(){
        if self.entryField.text == ""{
            entitleButtonShowCorrectly()
        } else {
            self.buttonShow.setTitleColor(UIColor.white, for: .normal)
            self.buttonShow.setTitle("⁺∕-", for: .normal)
        }
        
       
    }
    
    //MARK: FunctionsPad
    
    
    
    
    func showFunctionsPad(){
        self.buttonF1.isHidden = false
        self.buttonF2.isHidden = false
        self.buttonF3.isHidden = false
        self.buttonF4.isHidden = false
        self.buttonF5.isHidden = false
        self.buttonF6.isHidden = false
        self.buttonF7.isHidden = false
        self.buttonF8.isHidden = false
        self.buttonF9.isHidden = false
        self.buttonF10.isHidden = false
        self.buttonF11.isHidden = false
        self.buttonF12.isHidden = false
        self.buttonF13.isHidden = false
        self.buttonF14.isHidden = false
        self.buttonF15.isHidden = false
        self.buttonF16.isHidden = false
        self.buttonF17.isHidden = false
        self.buttonF18.isHidden = false
        self.buttonF19.isHidden = false
        self.buttonF20.isHidden = false
        self.buttonF21.isHidden = false
        self.buttonF22.isHidden = false
        self.buttonF23.isHidden = false
        self.buttonF24.isHidden = false
        
        
        
        
        
        
        
        
        
        self.buttonNumber7.isHidden = true
        self.buttonNumber8.isHidden = true
        self.buttonNumber9.isHidden = true
        self.buttonNumber4.isHidden = true
        self.buttonNumber5.isHidden = true
        self.buttonNumber6.isHidden = true
        self.buttonNumber1.isHidden = true
        self.buttonNumber2.isHidden = true
        self.buttonNumber3.isHidden = true
        self.buttonNumber0.isHidden = true
        self.buttonDotComma.isHidden = true
        self.buttonShow.isHidden = true
        
        
        
        self.functionPadisHiden = false
        
        
        //and hide factors anyway
        self.constraintPadTrailing.constant = 0
       
        
    }
    
    
    
    func hideFunctionsPad(){
        self.buttonF1.isHidden = true
        self.buttonF2.isHidden = true
        self.buttonF3.isHidden = true
        self.buttonF4.isHidden = true
        self.buttonF5.isHidden = true
        self.buttonF6.isHidden = true
        self.buttonF7.isHidden = true
        self.buttonF8.isHidden = true
        self.buttonF9.isHidden = true
        self.buttonF10.isHidden = true
        self.buttonF11.isHidden = true
        self.buttonF12.isHidden = true
        self.buttonF13.isHidden = true
        self.buttonF14.isHidden = true
        self.buttonF15.isHidden = true
        self.buttonF16.isHidden = true
        self.buttonF17.isHidden = true
        self.buttonF18.isHidden = true
        self.buttonF19.isHidden = true
        self.buttonF20.isHidden = true
        self.buttonF21.isHidden = true
        self.buttonF22.isHidden = true
        self.buttonF23.isHidden = true
        self.buttonF24.isHidden = true
        
        
        
        
        
        
        
        self.buttonNumber7.isHidden = false
        self.buttonNumber8.isHidden = false
        self.buttonNumber9.isHidden = false
        self.buttonNumber4.isHidden = false
        self.buttonNumber5.isHidden = false
        self.buttonNumber6.isHidden = false
        self.buttonNumber1.isHidden = false
        self.buttonNumber2.isHidden = false
        self.buttonNumber3.isHidden = false
        self.buttonNumber0.isHidden = false
        self.buttonDotComma.isHidden = false
        self.buttonShow.isHidden = false
        
        
        
        self.functionPadisHiden = true
       
        //if factors were visible before show them else show them not
        if factorsAreVisible {
            self.constraintPadTrailing.constant = -110
        } else {
            self.constraintPadTrailing.constant = 0
        }
        
        
        
        
        
    }
    
    
    
    func loadFirstFunctionBlock(){
              self.buttonF15.setTitle("sin", for: .normal)
              self.buttonF16.setTitle("cos", for: .normal)
              self.buttonF17.setTitle("tan", for: .normal)
              self.buttonF21.setTitle("sinh", for: .normal)
              self.buttonF22.setTitle("cosh", for: .normal)
              self.buttonF23.setTitle("tanh", for: .normal)
              
          
              
           self.buttonF15.setTitleColor(UIColor.orange, for: .normal)
           self.buttonF16.setTitleColor(UIColor.orange, for: .normal)
           self.buttonF17.setTitleColor(UIColor.orange, for: .normal)
           self.buttonF21.setTitleColor(UIColor.orange, for: .normal)
           self.buttonF22.setTitleColor(UIColor.orange, for: .normal)
           self.buttonF23.setTitleColor(UIColor.orange, for: .normal)
              
           
              //self.buttonF24.backgroundColor = UIColor.black
              self.buttonF24.setTitleColor(UIColor.white, for: .normal)
              
       }
       
       func loadSecondFunctionBlock(){
             
                     self.buttonF15.setTitle("sin⁻¹", for: .normal)
                     self.buttonF16.setTitle("cos⁻¹", for: .normal)
                     self.buttonF17.setTitle("tan⁻¹", for: .normal)
                     self.buttonF21.setTitle("sinh⁻¹", for: .normal)
                     self.buttonF22.setTitle("cosh⁻¹", for: .normal)
                     self.buttonF23.setTitle("tanh⁻¹", for: .normal)
           
           
           
           
             
                       self.buttonF15.setTitleColor(UIColor.white, for: .normal)
                      self.buttonF16.setTitleColor(UIColor.white, for: .normal)
                      self.buttonF17.setTitleColor(UIColor.white, for: .normal)
                      self.buttonF21.setTitleColor(UIColor.white, for: .normal)
                      self.buttonF22.setTitleColor(UIColor.white, for: .normal)
                      self.buttonF23.setTitleColor(UIColor.white, for: .normal)
           
             
             //self.buttonF24.backgroundColor = UIColor.orange//(red: 0.4, green: 1.0, blue: 0.2, alpha: 0.5)
             self.buttonF24.setTitleColor(UIColor.orange, for: .normal)
             
       }
       
    
    
    
    
    
    
    func showKiosk(){
            let myKiosk = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUpCounter") as! KioskViewController
            self.addChild(myKiosk)
            myKiosk.view.frame = self.view.frame
            self.view.addSubview(myKiosk.view)
            myKiosk.didMove(toParent: self)
    }
    
    func showCompany() {
             let myProKiosk = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUpProCounter") as! PKioskViewController
             self.addChild(myProKiosk)
             myProKiosk.view.frame = self.view.frame
             self.view.addSubview(myProKiosk.view)
             myProKiosk.didMove(toParent: self)
    }
    
    func  showComparisonViewAfterLoadingTheTwoNumbers(){
        let compareView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUpCompare") as! CompareViewController
        
        //important
        compareView.firstNumber = self.firstNumberToCompare
        compareView.secondNumber = self.secondNumberToCompare
        compareView.delta = self.secondNumberToCompare - self.firstNumberToCompare
        compareView.perCentDelta = 100 * compareView.delta / compareView.firstNumber
        
        //important
        
        self.addChild(compareView)
        compareView.view.frame = self.view.frame
        self.view.addSubview(compareView.view)
        compareView.didMove(toParent: self)
        

    }
    
    
    
    
    
    
    
    
    
    
   
    
    
    
    
    
    
}//End

      
      
