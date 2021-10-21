//
//  ViewController.swift
//  Calqulist
//
//  Created by Ioannis Karagogos on 25/1/19.
//  Copyright © 2019 Ioannis Karagogos. All rights reserved.
//

import UIKit
import MessageUI
import StoreKit
import SwiftKeychainWrapper
import AVFoundation





public class ViewController: UIViewController, AVAudioPlayerDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, MFMailComposeViewControllerDelegate, CellSubclassDelegate {
    
   
    struct GlobalVariable{
        static var myOwnFactor = String()
    }
    var audioPlayer = AVAudioPlayer()
    var timesEnter: Int = 0
    var arrayOfNumbers = [Double]()
    var arrayOfFactors = [String]()
    var arrayOfPerCent = [String]()
    var arrayOfPososto = [Double]()
    var arrayOfDots = [String]()
    var numberEntered: Double = 0
    var factorEntered: String = "+"
    var previousFactor: String = "+"
    var outcome: Double = 0
    var resultDisplayed: Double = 0
    var activeCell: TextInputTableViewCell? = nil
    var row: Int = 0
    var perCentWasPressed: Bool = false
    var secondEnterPerCentPressed: Bool = false
    var resultBeforePerCent: Double = 0
    var mailMessage: String = ""
    var arrayOfParenthesis = [String]()
    var leftParenthesis : String = ""
    var lastAvailableDeleted: Bool = false
    var factorsAreVisible: Bool = true
    var pressedPlus: Bool = false
    var pressedMinus: Bool = false
    var pressedTimes: Bool = false
    var pressedDivide: Bool = false
    //Attention
    var paidVersionisOn: Bool = false
     //Attention
    var functionPadisHiden: Bool = true
    var secondFuncIsOn: Bool = false
    var enterWasNeverPessed: Bool = true
    var enterWasPressedOnlyOnce: Bool = false
    var displayWasNeverPressed: Bool = true
    var factorsWereNeverRevealedSoFar: Bool = true
    var myProductOnShelf: SKProduct?
    var myProductTitle = String()
    var myProductDescripton = String()
    var myProductPrice = String()
    var listOfProducts = [SKProduct]()
    var maximumCellsForFree = 15
    var isFirstDotPressed: Bool = true
    var firstNumberToCompare: Double = 0
    var secondNumberToCompare: Double = 0
    var indexFirstChosen: Double = 0
    var isMathematicalOn: Bool = false
    
    
     //var delegate: ViewModelDelegate?
     //private let model = Model()
    
    // var rowBeingEdited : Int? = nil
    
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var buttonResult: UIButton!
    @IBOutlet weak var entryField: UITextField!
    @IBOutlet weak var buttonDot: UIButton!
    @IBOutlet weak var buttonTransparent: UIButton!
    @IBOutlet weak var buttonDotComma: UIButton!
    @IBOutlet weak var buttonEdit: UIButton!
    @IBOutlet weak var buttonMail: UIButton!
    
    
    @IBOutlet weak var buttonFuncPerCent: UIButton!
    
    
    @IBOutlet weak var buttonEraseLast: UIButton!
    
    
    
    
    
    
    @IBOutlet weak var buttonF1: UIButton!
    @IBOutlet weak var buttonF2: UIButton!
    @IBOutlet weak var buttonF3: UIButton!
    @IBOutlet weak var buttonF4: UIButton!
    @IBOutlet weak var buttonF5: UIButton!
    @IBOutlet weak var buttonF6: UIButton!
    @IBOutlet weak var buttonF7: UIButton!
    @IBOutlet weak var buttonF8: UIButton!
    @IBOutlet weak var buttonF9: UIButton!
    @IBOutlet weak var buttonF10: UIButton!
    @IBOutlet weak var buttonF11: UIButton!
    @IBOutlet weak var buttonF12: UIButton!
    @IBOutlet weak var buttonF13: UIButton!
    @IBOutlet weak var buttonF14: UIButton!
    @IBOutlet weak var buttonF15: UIButton!
    @IBOutlet weak var buttonF16: UIButton!
    @IBOutlet weak var buttonF17: UIButton!
    @IBOutlet weak var buttonF18: UIButton!
    @IBOutlet weak var buttonF19: UIButton!
    @IBOutlet weak var buttonF20: UIButton!
    @IBOutlet weak var buttonF21: UIButton!
    @IBOutlet weak var buttonF22: UIButton!
    @IBOutlet weak var buttonF23: UIButton!
    @IBOutlet weak var buttonF24: UIButton!
    
    
    
    
    @IBOutlet weak var buttonNumber7: UIButton!
    @IBOutlet weak var buttonNumber8: UIButton!
    @IBOutlet weak var buttonNumber9: UIButton!
    @IBOutlet weak var buttonNumber4: UIButton!
    @IBOutlet weak var buttonNumber5: UIButton!
    @IBOutlet weak var buttonNumber6: UIButton!
    @IBOutlet weak var buttonNumber1: UIButton!
    @IBOutlet weak var buttonNumber2: UIButton!
    @IBOutlet weak var buttonNumber3: UIButton!
    @IBOutlet weak var buttonNumber0: UIButton!
    
    
    
    @IBOutlet weak var buttonShow: UIButton!
    @IBOutlet weak var buttonPlus: UIButton!
    @IBOutlet weak var buttonMinus: UIButton!
    @IBOutlet weak var buttonTimes: UIButton!
    @IBOutlet weak var buttonDivide: UIButton!
    
    @IBOutlet weak var constraintPadTrailing: NSLayoutConstraint!
    @IBOutlet weak var constraintFactorsLeading: NSLayoutConstraint!
    @IBOutlet weak var constraintFactorViewLeading: NSLayoutConstraint!
    @IBOutlet weak var contraintEditLeading: NSLayoutConstraint!
    
   
    @IBOutlet weak var constraintEditTrailing: NSLayoutConstraint!
    @IBOutlet weak var constraintMailTrailing: NSLayoutConstraint!
    @IBOutlet weak var constraintTransparentLead: NSLayoutConstraint!
    @IBOutlet weak var constraintEntryLead: NSLayoutConstraint!
    @IBOutlet weak var constraintPerCentLead: NSLayoutConstraint!
    @IBOutlet weak var constraintEraseWidth: NSLayoutConstraint!
    @IBOutlet weak var constraintEditHeight: NSLayoutConstraint!
    @IBOutlet weak var constraintMailHeight: NSLayoutConstraint!
    
    
    //FactorButtonsUnited
    
    
    @IBOutlet weak var conMinusToPlus: NSLayoutConstraint!
    @IBOutlet weak var conTimesToMinus: NSLayoutConstraint!
    @IBOutlet weak var conDivideToTimes: NSLayoutConstraint!
    
    
    //MARK: Actions of Buttons
    @IBAction func editTable(_ sender: Any) {
        playSound(file: "ClickSmall")
       //myTableView.isEditing = !myTableView.isEditing
        
        if myTableView.isEditing {
            // self.buttonEdit.titleLabel?.text = "Edit"
              myTableView.isEditing = false
        } else {
           // self.buttonEdit.titleLabel?.text = "Done"
             myTableView.isEditing = true
        }
      
       
        switch myTableView.isEditing {
        case true:
            self.buttonEdit.setTitle("Done", for: .normal)
            let rgbColor = #colorLiteral(red: 0.9995599389, green: 0.6582826972, blue: 0.001935746637, alpha: 1)
            self.buttonEdit.setTitleColor(rgbColor, for: .normal)
           
        case false:
           self.buttonEdit.setTitle("Edit", for: .normal)
             let rgbColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.buttonEdit.setTitleColor(rgbColor, for: .normal)
        }
        
        
    }
    
    
    
    
    
    @IBAction func plusPressed(_ sender: Any) {
        playSound(file: "ClickEnter")
        bePlusReady()
    }
    
    
    
    @IBAction func minusPressed(_ sender: Any) {
        playSound(file: "ClickEnter")
       beMinusReady()
    }
    
   
    
    @IBAction func timesPressed(_ sender: Any) {
        playSound(file: "ClickEnter")
       beTimesReady()
        
    }
    
    
    @IBAction func dividePressed(_ sender: Any) {
        playSound(file: "ClickEnter")
       beDivideReady()
    }
    
    @IBAction func enter(_ sender: Any) {
        playSound(file: "ClickEnter")
        performEnter()
    }//FunctionEnds
    
    
    
    @IBAction func makeNegativeOrPositive(_ sender: Any) {
        playSound(file: "Flip")
        reverseNumber()
        
    }
    
    
    
    

    @IBAction func reCalculate(_ sender: Any) {
        //when the blue Factor is pressed
        playSound(file: "ClickSmall")
        if let indexPath = self.myTableView.indexPathForView(sender as! UIView) {
            print("REbefore\(arrayOfFactors)")
            print("Button tapped at indexPath \(indexPath.row)")
            
            if  self.arrayOfFactors[indexPath.row] == "+" {
                self.arrayOfFactors[indexPath.row] = "-"
            } else if self.arrayOfFactors[indexPath.row] == "-" {
                self.arrayOfFactors[indexPath.row] = "✕"
            } else if self.arrayOfFactors[indexPath.row] == "✕" {
                self.arrayOfFactors[indexPath.row] = "÷"
            } else {
                 self.arrayOfFactors[indexPath.row] = "+"
            }
            
            print("REafter\(arrayOfFactors)")
            
            
                calculateNow()
        
            
            
            
            
            self.mailMessage = ""
        }
        else {
            print("Button indexPath not found")
        }
        
        
    }//END
    
    

    func buttonTapped(cell: TextInputTableViewCell) {
        guard let indexPath = self.myTableView.indexPath(for: cell) else {
            // Note, this shouldn't happen - how did the user tap on a button that wasn't on screen?
            return
        }
        //  Do whatever you need to do with the indexPath
        
        
        
       // self.arrayOfFactors[indexPath.row] =
        print("Button tapped on my row \(indexPath.row)")
        
    }//END
    
    

    
    @IBAction func clearAll(_ sender: Any) {
        playSound(file: "Delete")
        self.outcome = 0
        self.resultDisplayed = 0
        self.buttonResult.setTitle(String(describing: 0), for: .normal)
         self.buttonTransparent.setTitle("⏎", for: .normal)
        
       
        //Empty Array
        self.arrayOfNumbers = []
        self.arrayOfFactors = []
        self.arrayOfPerCent = []
        
        self.arrayOfPososto = []
        self.arrayOfDots = []
        
        
        self.timesEnter = 0
        self.numberEntered = 0
        self.entryField.text = ""
        self.buttonTransparent.titleLabel?.text = "⏎"
        self.mailMessage = ""
        self.arrayOfParenthesis = []
       
        print("array: \(arrayOfNumbers)")
        print("arrayFactor: \(arrayOfFactors)")
        print("arrayPerCent: \(arrayOfPerCent)")
        
        hideEditMail()
        hidePerCent()
        hideFunctionsPad()
        entitleButtonShowCorrectly()
        isFirstDotPressed = true
        self.myTableView.reloadData()
    }
    
    
    @IBAction func clearAllAndLoadResult(_ sender: Any) {
        playSound(file: "ClickEnter")
        self.displayWasNeverPressed = false
       
        
      
        hideEditMail()
        hidePerCent()
        hideFunctionsPad()
        entitleButtonShowCorrectly()
        
        if arrayOfNumbers.count > 0 {
            
       // let index = IndexPath(row: 0, section: 0)
      //  let cell: TextInputTableViewCell  = self.myTableView.cellForRow(at: index) as! TextInputTableViewCell
      //  cell.myTextField.text = String(describing: self.resultDisplayed)
            
            self.buttonResult.setTitle(String(describing: 0), for: .normal)
            
            //Empty Array
            self.arrayOfNumbers = []
            self.arrayOfFactors = []
            self.arrayOfPerCent = []
            self.arrayOfPososto = []
             self.arrayOfDots = ["○"]
            
           
            //Load Result
            self.arrayOfFactors.append("+")
            self.arrayOfPerCent.append("")
            self.arrayOfPososto.append(100)
            self.arrayOfNumbers.append(self.resultDisplayed)
           //Compare fix so that it will compare with 0
            self.resultDisplayed = 0
            
            self.numberEntered = 0
             self.entryField.text = ""
            
            self.timesEnter = 0
            self.mailMessage = ""
            isFirstDotPressed = true
            
            //let index = IndexPath(row: 0, section: 0)
           // let cell: TextInputTableViewCell  = self.myTableView.cellForRow(at: index) as! TextInputTableViewCell
           // cell.myTextField.text = String(describing: self.resultDisplayed)
            
            
            
            
            print("array: \(arrayOfNumbers)")
            print("arrayFactor: \(arrayOfFactors)")
            print("arrayPerCent: \(arrayOfPerCent)")
            
            self.myTableView.reloadData()
       
        } else {
            //clearAll
            self.buttonResult.setTitle(String(describing: 0), for: .normal)
            
            //Empty Array
            self.arrayOfNumbers = []
            self.arrayOfFactors = []
            self.arrayOfPerCent = []
            
            self.arrayOfPososto = []
             self.arrayOfDots = []
            isFirstDotPressed = true
            
            self.timesEnter = 0
            self.numberEntered = 0
            self.entryField.text = ""
            
            
            print("array: \(arrayOfNumbers)")
            print("arrayFactor: \(arrayOfFactors)")
            print("arrayPerCent: \(arrayOfPerCent)")
            self.myTableView.reloadData()
        }
        self.buttonTransparent.setTitle("⏎", for: .normal)
       
    }
    
    
    
    
    
    
    
    @IBAction func showMathematicalResult(_ sender: Any) {
        playSound(file: "Flip")
        
       
        
        if isMathematicalOn {
            self.buttonResult.backgroundColor = UIColor.black
            self.buttonResult.setTitleColor(.systemOrange, for: .normal)
            
            
        } else {
            
            self.buttonResult.backgroundColor = UIColor.white
            self.buttonResult.setTitleColor(.blue, for: .normal)
            
        }
        
        
         self.isMathematicalOn = !isMathematicalOn
        if arrayOfNumbers.count > 0 {
            calculateNow()
        }
         
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func numberClicked(_ sender: Any) {
        playSound(file: "ClickSmall")
        showPerCent()
        secondEnterPerCentPressed = false
        
        
        
        if perCentWasPressed {
            
        } else {
        
       // self.buttonShow.setTitle("⁺∕-", for: .normal)
       // self.buttonShow.setTitleColor(UIColor.white, for: .normal)
        self.buttonPlus.setTitleColor(UIColor.white, for: .normal)
        self.buttonMinus.setTitleColor(UIColor.white, for: .normal)
        self.buttonTimes.setTitleColor(UIColor.white, for: .normal)
        self.buttonDivide.setTitleColor(UIColor.white, for: .normal)
        self.buttonPlus.isEnabled = true
        self.buttonMinus.isEnabled = true
        self.buttonTimes.isEnabled = true
        self.buttonDivide.isEnabled = true
        
        }
        
        
        
        
        
        
        
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
        
        
        self.buttonTransparent.setTitle("", for: .normal)
        if self.enterWasNeverPessed {
             //pulseEntryField()
            self.buttonTransparent.setTitle("⏎", for: .normal)
            flashEntryField()
            
        }
        
       
        
          
       
        
        //is it the dot?
        if (sender as AnyObject).tag == 11 {
            
            //is it the 1st dot?
            if (self.entryField.text?.contains("."))! ||  (self.entryField.text?.contains(","))! {
                  //Do nothing
            } else {
                
           
            if Locale.current.decimalSeparator == "." {
                    self.entryField.text = (self.entryField?.text)! + "."
            } else {
                    self.entryField.text = (self.entryField?.text)! + ","
            }
             
                
                
                
            }
        
        } else {
             self.entryField.text =  (self.entryField?.text)! + String((sender as AnyObject).tag - 1)
        }
     
       
    }//End
    

    
    
    
    @IBAction func plusMinusClicked(_ sender: Any) {
        playSound(file: "Sweep")
        revealOrHideFactorPad()
        
        /*
        if self.entryField.text == "" || entryField.text == "."  || entryField.text == "," {
        revealOrHideFactorPad()
       
              
        } else {
            self.buttonTransparent.titleLabel!.text = ""
            
            
            let numberInField = entryField.text?.doubleValue
            let mirrorNumber = numberInField! - 2 * numberInField!
            
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 9
            formatter.numberStyle = .decimal
            self.entryField.text = formatter.string(from: mirrorNumber as NSNumber)
        }*/
        
    }//End
    
    
    
    
    @IBAction func dragOutsideToMirrorNumber(_ sender: Any) {
        playSound(file: "Flip")
        if self.entryField.text == "" || entryField.text == "."  || entryField.text == "," {
                        //Do nothing
                     
                            
                      } else {
                          self.buttonTransparent.titleLabel!.text = ""
                          
                          
                          let numberInField = entryField.text?.doubleValue
                          let mirrorNumber = numberInField! - 2 * numberInField!
                          
                          let formatter = NumberFormatter()
                          formatter.minimumFractionDigits = 0
                          formatter.maximumFractionDigits = 9
                          formatter.numberStyle = .decimal
                          self.entryField.text = formatter.string(from: mirrorNumber as NSNumber)
                      }
               
               
    }
    
    
    
    
    
    @IBAction func dragInsideToMirrorNumber(_ sender: Any) {
        if self.entryField.text == "" || entryField.text == "."  || entryField.text == "," {
                               //Do nothing
                            
                                   
                             } else {
                                 self.buttonTransparent.titleLabel!.text = ""
                                 
                                 
                                 let numberInField = entryField.text?.doubleValue
                                 let mirrorNumber = numberInField! - 2 * numberInField!
                                 
                                 let formatter = NumberFormatter()
                                 formatter.minimumFractionDigits = 0
                                 formatter.maximumFractionDigits = 9
                                 formatter.numberStyle = .decimal
                                 self.entryField.text = formatter.string(from: mirrorNumber as NSNumber)
                             }
                      
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func touchUpOutside(_ sender: Any) {
        playSound(file: "Flip")
        if self.entryField.text == "" || entryField.text == "."  || entryField.text == "," {
                 //Do nothing
              
                     
               } else {
                   self.buttonTransparent.titleLabel!.text = ""
                   
                   
                   let numberInField = entryField.text?.doubleValue
                   let mirrorNumber = numberInField! - 2 * numberInField!
                   
                   let formatter = NumberFormatter()
                   formatter.minimumFractionDigits = 0
                   formatter.maximumFractionDigits = 9
                   formatter.numberStyle = .decimal
                   self.entryField.text = formatter.string(from: mirrorNumber as NSNumber)
               }
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func dragInsideToMakeMirrorNumber(_ sender: Any) {
        if self.entryField.text == "" || entryField.text == "."  || entryField.text == "," {
                 //Do nothing
              
                     
               } else {
                   self.buttonTransparent.titleLabel!.text = ""
                   
                   
                   let numberInField = entryField.text?.doubleValue
                   let mirrorNumber = numberInField! - 2 * numberInField!
                   
                   let formatter = NumberFormatter()
                   formatter.minimumFractionDigits = 0
                   formatter.maximumFractionDigits = 9
                   formatter.numberStyle = .decimal
                   self.entryField.text = formatter.string(from: mirrorNumber as NSNumber)
               }
        
        
        
    }
    
    
    
    
    
    
    
    
    @IBAction func eraseOneDigit(_ sender: Any) {
        playSound(file: "ClickSmall")
        let textToShrink = self.entryField.text
        let textLittle = String((textToShrink?.dropLast())!)
        self.entryField.text = textLittle
        
        if self.entryField.text == "" {
           self.buttonTransparent.setTitle("⏎", for: .normal)
            hidePerCent()
            hideFunctionsPad()
            entitleButtonShowCorrectly()
        }
        
    }//End
    
    
    @IBAction func clearEntryField(_ sender: Any) {
        playSound(file: "ClickSmall")
        self.entryField.text = ""
        self.buttonTransparent.setTitle("⏎", for: .normal)
        hidePerCent()
        hideFunctionsPad()
        entitleButtonShowCorrectly()
    }//End
    
    
    
    
    
    
    
    @IBAction func perCentClicked(_ sender: Any) {
        playSound(file: "ClickSmall")
        if self.paidVersionisOn == false {
            perCentCalculatedAndArranged()
        } else {
            self.buttonFuncPerCent.setTitle("f", for: .normal)
            if functionPadisHiden {
                showFunctionsPad()
                
            } else {
                loadFirstFunctionBlock()
                hideFunctionsPad()
            }
           
            
        }
    }
    
    
    
    
    @IBAction func secondFuncClicked(_ sender: Any) {
        playSound(file: "ClickSmall")
        if self.secondFuncIsOn {
            loadFirstFunctionBlock()
            self.secondFuncIsOn = false
        } else {
            loadSecondFunctionBlock()
            self.secondFuncIsOn = true
        }
    }//Action
    
    
    
    @IBAction func applyF1(_ sender: Any) {//%
        playSound(file: "ClickSmall")
        perCentCalculatedAndArranged()
        hideFunctionsPad()
        
    }
    
    
    
    
    @IBAction func applyF2(_ sender: Any) {//x2
        playSound(file: "ClickSmall")
        let stringOfEvolvingNumber = self.entryField.text
        let x = stringOfEvolvingNumber!.doubleValue
        let resultNumber = x * x
        enterResultInField(result: resultNumber)
    }
    
    
    @IBAction func applyF3(_ sender: Any) {//x3
        playSound(file: "ClickSmall")
        let stringOfEvolvingNumber = self.entryField.text
        let x = stringOfEvolvingNumber!.doubleValue
        let resultNumber = x * x * x
        enterResultInField(result: resultNumber)
    }
    
    
    
    @IBAction func applyF4(_ sender: Any) {//2x
        playSound(file: "ClickSmall")
      let stringOfEvolvingNumber = self.entryField.text
      let x = stringOfEvolvingNumber!.doubleValue
      let resultNumber = pow(2, x)
      enterResultInField(result: resultNumber)
        
    }//Action
    
    
    
    
  
    
    
    @IBAction func appllyF5(_ sender: Any) {//10x
        playSound(file: "ClickSmall")
        let stringOfEvolvingNumber = self.entryField.text
        let x = stringOfEvolvingNumber!.doubleValue
        let resultNumber = pow(10, x)
        enterResultInField(result: resultNumber)
    }
    
    
    
    @IBAction func appllyF6(_ sender: Any) { //ex
        playSound(file: "ClickSmall")
        let stringOfEvolvingNumber = self.entryField.text
        let x = stringOfEvolvingNumber!.doubleValue
        let resultNumber = pow(2.718281828459045, x)
        enterResultInField(result: resultNumber)
    }
    
    
    
    @IBAction func appllyF7(_ sender: Any) {//‰
        playSound(file: "ClickSmall")
        let stringOfEvolvingNumber = self.entryField.text
        let x = stringOfEvolvingNumber!.doubleValue
        let resultNumber = x / 1000
        enterResultInField(result: resultNumber)
        
    }
    
    
    
    @IBAction func appllyF8(_ sender: Any) { ///x
        playSound(file: "ClickSmall")
        let stringOfEvolvingNumber = self.entryField.text
               let x = stringOfEvolvingNumber!.doubleValue
               let resultNumber = x.squareRoot()
               enterResultInField(result: resultNumber)
        
    }
    
    
    
    @IBAction func appllyF9(_ sender: Any) {//3/x
        playSound(file: "ClickSmall")
        let stringOfEvolvingNumber = self.entryField.text
        let x = stringOfEvolvingNumber!.doubleValue
        let resultNumber = pow(x, 1 / 3)
        enterResultInField(result: resultNumber)
        
    }
    
    
    
    
    @IBAction func appllyF10(_ sender: Any) {//log2
        playSound(file: "ClickSmall")
        let stringOfEvolvingNumber = self.entryField.text
        let x = stringOfEvolvingNumber!.doubleValue
        let resultNumber = log2(x)
        enterResultInField(result: resultNumber)
    }
    
    
    
    @IBAction func appllyF11(_ sender: Any) {//log10
        playSound(file: "ClickSmall")
        let stringOfEvolvingNumber = self.entryField.text
        let x = stringOfEvolvingNumber!.doubleValue
        let resultNumber = log10(x)
        enterResultInField(result: resultNumber)
    }
    
    
    
    @IBAction func appllyF12(_ sender: Any) {//ln
        playSound(file: "ClickSmall")
        let stringOfEvolvingNumber = self.entryField.text
               let x = stringOfEvolvingNumber!.doubleValue
        let resultNumber = log2(x) / log2(2.718281828459045)
               enterResultInField(result: resultNumber)

    }
    
    
    
    
    
    @IBAction func appllyF13(_ sender: Any) {//1/x
        playSound(file: "ClickSmall")
       let stringOfEvolvingNumber = self.entryField.text
        let x = stringOfEvolvingNumber!.doubleValue
        let resultNumber = 1 / x
        enterResultInField(result: resultNumber)
    }
    
    
    
    
    @IBAction func appllyF14(_ sender: Any) {//e
        playSound(file: "ClickSmall")
        enterConstantInField(constant: "2.718281828459045")
      
    }
    
    
    
    @IBAction func appllyF15(_ sender: Any) {//sin
        playSound(file: "ClickSmall")
        enterTrigonometricResult(trigon: "sin", aTrigon: "asin")
        
    }
    
    
    
    @IBAction func appllyF16(_ sender: Any) {//cos
        playSound(file: "ClickSmall")
        enterTrigonometricResult(trigon: "cos", aTrigon: "acos")
    }
    
    
    
    
    @IBAction func appllyF17(_ sender: Any) {//tan
        playSound(file: "ClickSmall")
        enterTrigonometricResult(trigon: "tan", aTrigon: "atan")
    }
    
    
    
    @IBAction func appllyF18(_ sender: Any) {//DEG
        playSound(file: "ClickSmall")
        if self.buttonF18.titleLabel!.text == "Deg"{
            
                       self.buttonF18.setTitle("Rad", for: .normal)
                   } else if self.buttonF18.titleLabel!.text == "Rad"  {
                       self.buttonF18.setTitle("Deg", for: .normal)
                   }
        
    }//End
    
    
    
    @IBAction func appllyF19(_ sender: Any) {//φ
        playSound(file: "ClickSmall")
       enterConstantInField(constant: "1.61803398874")
       
       
    }
    
    
    
    @IBAction func appllyF20(_ sender: Any) {//π
        playSound(file: "ClickSmall")
        enterConstantInField(constant: "3.14159265358979")
    }
    
    
    
    
    @IBAction func appllyF21(_ sender: Any) {//sinh
        playSound(file: "ClickSmall")
        enterTrigonometricResult(trigon: "sinh", aTrigon: "asinh")
    }
    
    
    
    @IBAction func appllyF22(_ sender: Any) {
        playSound(file: "ClickSmall")
        enterTrigonometricResult(trigon: "cosh", aTrigon: "acosh")
    }
    
    
    
    
    @IBAction func appllyF23(_ sender: Any) {
        playSound(file: "ClickSmall")
        enterTrigonometricResult(trigon: "tanh", aTrigon: "atanh")
    }
    
    
   
      //MARK: Repeated Functions
    
    func enterResultInField(result: Double){
        let localizedEvolvingNumber = result
        
             let formatter = NumberFormatter()
                  formatter.minimumFractionDigits = 0
                  formatter.maximumFractionDigits = 9
                  formatter.numberStyle = .decimal
                  
             self.entryField.text = formatter.string(from: localizedEvolvingNumber as NSNumber)
             
              self.buttonTransparent.setTitle("", for: .normal)
              hideFunctionsPad()
    }

    
    
    func enterConstantInField(constant: String){
        
        let stringOfEvolvingNumber = constant
        let localizedEvolvingNumber = stringOfEvolvingNumber.doubleValue
        
        let formatter = NumberFormatter()
             formatter.minimumFractionDigits = 0
             formatter.maximumFractionDigits = 9
             formatter.numberStyle = .decimal
             
        self.entryField.text = formatter.string(from: localizedEvolvingNumber as NSNumber)
        
         self.buttonTransparent.setTitle("", for: .normal)
         hideFunctionsPad()
        //putCorrectSymbolInButtonShow()
    }
    
       
    func enterTrigonometricResult(trigon: String, aTrigon: String){
        if secondFuncIsOn {
                         
                          if self.buttonF18.titleLabel?.text == "Deg" {
                              calculateTrigonomentricDegrees(trig: aTrigon)
                          } else {
                              calculateTrigonomentricRads(trig:  aTrigon)
                          }
                       
                          
                           
                          
                      } else {
                   
                           if self.buttonF18.titleLabel?.text == "Deg" {
                               calculateTrigonomentricDegrees(trig: trigon)
                          } else {
                               calculateTrigonomentricRads(trig: trigon)
                           }
                   
                   
                   
                     }
                      hideFunctionsPad()
    }//end
       
       
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        activeCell?.myTextField.text = ""
        self.arrayOfNumbers.append(numberEntered)
    }
    
    
   
    @IBAction func payOrMailorSelect(_ sender: Any) {
        playSound(file: "ClickSmall")
            if self.buttonMail.titleLabel?.text == "ℹ︎"{
                
                if self.paidVersionisOn {
                    showCompany()
                } else {
                     showKiosk()
                }
            
           
        } else if self.buttonMail.titleLabel?.text == "○" {
                
                self.secondNumberToCompare = self.resultDisplayed
                arrangeBigDot()
                
                 self.myTableView.reloadData()
                 showComparisonViewAfterLoadingTheTwoNumbers()
                
        } else {
        
        exportEquation()
            
        }//DO Something
    }//function
    
    
   
    
    @IBAction func showFactorButtons(_ sender: Any) {
        playSound(file: "Sweep")
           revealOrHideFactorPad()
        
    }//EndFunction
    
   
    
    
    @IBAction func markAndshowComparingView(_ sender: Any) {
        playSound(file: "ClickSmall")
        if paidVersionisOn {
            if self.isFirstDotPressed {
                
                if let indexPath = self.myTableView.indexPathForView(sender as! UIView) {
                    self.firstNumberToCompare = self.arrayOfNumbers[indexPath.row]
                    print("this is the one : \(firstNumberToCompare)")
                }

               showMailOnlyWithDotAndWhite()
               self.isFirstDotPressed = false
            } else {
                if let indexPath = self.myTableView.indexPathForView(sender as! UIView) {
                               self.secondNumberToCompare = self.arrayOfNumbers[indexPath.row]
                     print("this is the Two : \(secondNumberToCompare)")
                }
                
                arrangeBigDot()
                
                
                self.myTableView.reloadData()
               
                
                if self.firstNumberToCompare == self.secondNumberToCompare {
                   //Do nothing
                } else {
                showComparisonViewAfterLoadingTheTwoNumbers()
                }
                
                
            }//isfirstDotPressed
            
           
            
        } else {//Free version
            
            showKiosk()
            
        }
        
        
        
        
       
    }//Func
    
    
    
    
    
    
    
    
    
    
    
    
    func loadFreeOrPaid(){
        let isPaid = KeychainWrapper.standard.bool(forKey: myProductList.calqulistPro) ?? false
               if isPaid {
                   self.paidVersionisOn = true
                   self.buttonFuncPerCent?.setTitle("f", for: .normal)
                print("we loaded the Pro")
               }
        print("No Pro")
    }//Func
    
    
    
    func playSound(file: String){
        
        let soundURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: file, ofType: "wav")!)

               do{
                   audioPlayer = try AVAudioPlayer(contentsOf: soundURL as URL)

               }catch {
                   print("there was some error. The error was \(error)")
               }
               audioPlayer.play()
        
    }
    
    
    
  
    

    override public func viewDidLoad() {
        super.viewDidLoad()
        
        loadFreeOrPaid()
        putDotOrComma()
        hideEditMail()
        hidePerCent()
        hideFunctionsPad()
        
        self.entryField.isUserInteractionEnabled = false
        //let Factors be seen or not (remeber to change the BOOL too)
        //self.constraintPadTrailing.constant = 0
        
        let numberOfVisibleCells = self.myTableView.visibleCells.count
        print("This tablewView shows \(numberOfVisibleCells) cells")
        
    }//didLoad
    
    
  


}//Final







//Extremelly useful extention for dot comma decimal separator
//it takes the text(e.g. 2,45 or 3.56) and gives back the correct locale doubleValue
//in Greece  "2,45".doubleValue = 2,45 and "3.56".doubleValue = 3,56
extension String {
    static let numberFormatter = NumberFormatter()
    var doubleValue: Double {
        String.numberFormatter.decimalSeparator = "."
        if let result =  String.numberFormatter.number(from: self) {
            return result.doubleValue
        } else {
            String.numberFormatter.decimalSeparator = ","
            if let result = String.numberFormatter.number(from: self) {
                return result.doubleValue
            }
        }
        return 0
    }
}



extension UIResponder {
    func next<T: UIResponder>(_ type: T.Type) -> T? {
        return next as? T ?? next?.next(type)
    }
}


extension UIColor {
    open class var myBlue: UIColor {
        return UIColor(red: 2/255, green: 100/255,  blue: 100/255, alpha: 1)
    }
    
    
}


extension UIColor {
   
    open class var myOrange: UIColor {
        return UIColor(red: 255, green: 169, blue: 0, alpha: 1)
    }
    
}




extension ViewController: RefreshViewDelegate {
    func updatePurchasedItemsInTheView() {
       // let extraWasJustBought = ProductDelivery.isProductAvailable(identifier: myProductList.extraTrials)
        let proWasJustBought = ProductDelivery.isProductAvailable(identifier: myProductList.calqulistPro)
        
        if proWasJustBought {
            KeychainWrapper.standard.set(true, forKey: myProductList.calqulistPro )
            
            self.buttonFuncPerCent.setTitle("f", for: .normal)
            self.paidVersionisOn = true
            /*
            DispatchQueue.main.async {
           self.buttonFuncPerCent.setTitle("f", for: .normal)
           self.paidVersionisOn = true
           }*/
        }
        
    
        
        print("DELEGATE Refreshhing RULES")
    }//func
    
   
    
}//ext
