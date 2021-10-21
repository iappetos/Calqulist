//
//  myModel.swift
//  Calqulist
//
//  Created by Ioannis Karagogos on 14/1/20.
//  Copyright © 2020 Ioannis Karagogos. All rights reserved.
//

import Foundation
import UIKit


extension ViewController {
    
       func bePlusReady(){
           self.pressedPlus = true
           self.pressedMinus = false
           self.pressedTimes = false
           self.pressedDivide = false
           performEnterLike(what: "+")
       }
    
    func beMinusReady(){
        self.pressedPlus = false
        self.pressedMinus = true
        self.pressedTimes = false
        self.pressedDivide = false
        performEnterLike(what: "-")
    }
    
    
    
       func beTimesReady(){
           self.pressedPlus = false
           self.pressedMinus = false
           self.pressedTimes = true
           self.pressedDivide = false
           performEnterLike(what: "✕")
       }
    
    
    func beDivideReady(){
           self.pressedPlus = false
           self.pressedMinus = false
           self.pressedTimes = false
           self.pressedDivide = true
           performEnterLike(what: "÷")
       }
    
    
    
    func performEnter(){
        if self.entryField.text == "" {
                   //Do nothing
               } else {
                   self.enterWasNeverPessed = false
               }
              
              
               if secondEnterPerCentPressed == true &&  entryField.text == "" {
                   
                   
                   let lastPerCentIndex = self.arrayOfNumbers.count - 1
                   let pososto = self.arrayOfNumbers[lastPerCentIndex] * 100
                   
                   let perCentFormatter = NumberFormatter()
                   perCentFormatter.minimumFractionDigits = 0
                   perCentFormatter.maximumFractionDigits = 2
                   perCentFormatter.numberStyle = .decimal
                   
                   
                   
                   let formattedPerCent = perCentFormatter.string(from: pososto as NSNumber)
                   
                   
                   self.arrayOfPerCent[lastPerCentIndex] = "(" + /*String(pososto)*/formattedPerCent! + "%)"
                   self.arrayOfNumbers[lastPerCentIndex] = self.resultDisplayed
                   self.arrayOfFactors[lastPerCentIndex] = "+"
                   self.arrayOfPososto[lastPerCentIndex] = pososto
                   
                   
                   print("%%%%%%%%%%%%%%\(arrayOfPerCent)")
                   print("%%%%%%%%%%%%%%\(arrayOfPososto)")
                   self.myTableView.reloadData()
                   calculateNow()
                   secondEnterPerCentPressed = false
                   
               } else {// I am not after PerCent
                   
                   
                   if (entryField.text == "" || entryField.text == "." || entryField.text == ",") && self.arrayOfNumbers.count == 0 {
                       //No text & No Any Entry
                       //Do nonthing
                       print("IDONOTHING")
                   } else {
                       //Something is Done
                       
                       if entryField.text == ""   {
                           
                           //No text but there is at least one entry
                           let lastItem = self.arrayOfNumbers.count - 1
                           let lastEnteredNumber = self.arrayOfNumbers[lastItem]
                           
                        
                        if self.paidVersionisOn {
                           takeNumberEntered(myNumber: lastEnteredNumber)
                         } else if self.arrayOfNumbers.count < maximumCellsForFree {
                            takeNumberEntered(myNumber: lastEnteredNumber)
                        } else {
                        showKiosk()
                        }
                        
                        
                        
                          
                        
                        
                        
                        
                        
                           
                       } else if entryField.text == "." || entryField.text == ","  {
                           //Do nothing
                       } else {
                           //text there is
                           
                           //I take the correct locale for decimal separator
                           let numberSchematized = entryField.text?.doubleValue
                        
                        if self.paidVersionisOn {
                            takeNumberEntered(myNumber: numberSchematized!)
                        } else if self.arrayOfNumbers.count < maximumCellsForFree {
                            takeNumberEntered(myNumber: numberSchematized!)
                        } else {
                            showKiosk()
                        }
                        
                      
                        
                        
                        
                        
                           
                           
                       }
                       
                   }//2nd if ends here(empty text without entries)
                   
               }//1st if ends here(perCent)
               
               
               self.entryField.text = ""
               self.buttonTransparent.setTitle("⏎", for: .normal)
               
               hidePerCent()
               hideFunctionsPad()
               entitleButtonShowCorrectly()
    }//Enter
    
    
    
    
    func performEnterLike(what: String){
        
        if secondEnterPerCentPressed == true &&  entryField.text == "" {
            
            
            let lastPerCentIndex = self.arrayOfNumbers.count - 1
            let pososto = self.arrayOfNumbers[lastPerCentIndex] * 100
            
            let perCentFormatter = NumberFormatter()
            perCentFormatter.minimumFractionDigits = 0
            perCentFormatter.maximumFractionDigits = 2
            perCentFormatter.numberStyle = .decimal
            
            
            
            let formattedPerCent = perCentFormatter.string(from: pososto as NSNumber)
            
            
            self.arrayOfPerCent[lastPerCentIndex] = "(" + /*String(pososto)*/formattedPerCent! + "%)"
            self.arrayOfNumbers[lastPerCentIndex] = self.resultDisplayed
            self.arrayOfFactors[lastPerCentIndex] = what//"-"
            self.arrayOfPososto[lastPerCentIndex] = pososto
            
            
            print("%%%%%%%%%%%%%%\(arrayOfPerCent)")
            print("%%%%%%%%%%%%%%\(arrayOfPososto)")
            self.myTableView.reloadData()
            calculateNow()
            secondEnterPerCentPressed = false
            
        } else {// I am not after PerCent
            
            
            if (entryField.text == "" || entryField.text == "." || entryField.text == ",") && self.arrayOfNumbers.count == 0 {
                //No text & No Any Entry
                //Do nonthing
                print("IDONOTHING")
            } else {
                //Something is Done
                
                if entryField.text == ""   {
                   /*
                    //No text but there is at least one entry
                    let lastItem = self.arrayOfNumbers.count - 1
                    let lastEnteredNumber = self.arrayOfNumbers[lastItem]
                    
                    takeNumberEntered(myNumber: lastEnteredNumber)
                    */
                } else if entryField.text == "." || entryField.text == ","  {
                    //Do nothing
                } else {
                    //text there is
                    
                    //I take the correct locale for decimal separator
                    let numberSchematized = entryField.text?.doubleValue
                   // takeNumberEntered(myNumber: numberSchematized!)
                    
                    if self.paidVersionisOn {
                    takeNumberEnteredAndFactorized(myNumber: numberSchematized!, myFactor: what)
                } else if self.arrayOfNumbers.count < maximumCellsForFree {
                      takeNumberEnteredAndFactorized(myNumber: numberSchematized!, myFactor: what)
                } else {
                     showKiosk()
                }
                    
                    
                    
                    
                    
                    
                    
                }
                
            }//2nd if ends here(empty text without entries)
            
        }//1st if ends here(perCent)
        
        
        self.entryField.text = ""
        self.buttonTransparent.setTitle("⏎", for: .normal)
        hidePerCent()
        hideFunctionsPad()
        entitleButtonShowCorrectly()
    }//Func
    
    
    
    
    func takeNumberEnteredAndFactorized(myNumber: Double, myFactor: String){
       
        self.numberEntered = myNumber
        self.arrayOfNumbers.append(numberEntered)
        self.arrayOfPerCent.append(" ")
        self.arrayOfPososto.append(100)
        self.arrayOfDots.append("○")
        
        if perCentWasPressed == true {
            self.arrayOfFactors.append("✕")
            self.secondEnterPerCentPressed = true
            
        } else {//NO perCent
            
            
            //automatic factor entry
            if  timesEnter <= 1 {
                
                self.arrayOfFactors.append(myFactor)
                showMailOnly()
                
                
            } else {
                
                if lastAvailableDeleted {
                    
                   self.arrayOfFactors.append(myFactor)
                   hideEditMail()
                   lastAvailableDeleted = false
                    
                } else {
                    
                self.arrayOfFactors.append(myFactor)
                    
            
                showEditMail()
                    if self.displayWasNeverPressed {
                   // pulseResultDisplay()
                    flashResultDisplay()
                      }
                
                }
                
            }
            
        }//perCent
        
        self.timesEnter += 1
        self.perCentWasPressed = false
        
        calculateNow()
        
        //scoll to last and erase entryField
        let lastIndex = IndexPath(row: arrayOfNumbers.count - 1, section: 0)
        self.myTableView.scrollToRow(at: lastIndex,at: .middle, animated: true)
        self.entryField.text = ""
    }
    
    
    
    
    
    
    func takeNumberEntered(myNumber: Double){
        
        self.numberEntered = myNumber
        self.arrayOfNumbers.append(numberEntered)
        self.arrayOfPerCent.append(" ")
        self.arrayOfPososto.append(100)
        self.arrayOfDots.append("○")
        
        
        if perCentWasPressed == true {
           self.arrayOfFactors.append("✕")
           self.secondEnterPerCentPressed = true
            
        } else {//NO perCent
        
           
        //automatic factor entry
            if  timesEnter <= 1 {
                  self.arrayOfFactors.append(factorEntered)
                showMailOnly()
                
                
        } else {
                
            if lastAvailableDeleted {
                self.arrayOfFactors.append("+")
                hideEditMail()
                lastAvailableDeleted = false
                
             } else {
                  
              let lastIndex = arrayOfFactors.count - 1
              self.arrayOfFactors.append(self.arrayOfFactors[lastIndex])
                
             
              showEditMail()
              if self.displayWasNeverPressed {
               // pulseResultDisplay()
                flashResultDisplay()
              }
            }
        }
            
        }//perCent
            
        self.timesEnter += 1
        self.perCentWasPressed = false
        
        calculateNow()
        
        //scoll to last and erase entryField
        let lastIndex = IndexPath(row: arrayOfNumbers.count - 1, section: 0)
        self.myTableView.scrollToRow(at: lastIndex,at: .middle, animated: true)
        self.entryField.text = ""
        
    }//Func
    
    
    
    func calculateNow(){
        
        if isMathematicalOn {
            performMathematicalCalculationUsingShuntingYardAndRPN()
        } else {
             performCasualCalculator()
        }
       
    
   
    }//Func
    
    
    func performCasualCalculator(){
       
            //CALCULATE
            //create array with lifted factors
        
            var arrayOfOperators = [String]()
            arrayOfOperators = self.arrayOfFactors
        
           print("factorArray: \(self.arrayOfFactors)")
            arrayOfOperators[0] = "+"
            print("liftedArray: \(arrayOfOperators)")
            
            
            if arrayOfNumbers.count == 0 {
                
            self.outcome = arrayOfNumbers[0]
                
            } else {
                
                print("Numbers: \(self.arrayOfNumbers)")
                print("Factors: \(self.arrayOfFactors)")
                
                
                    
                      for i in 0...arrayOfNumbers.count - 1  {
                                     
                             //if + ADD, if - deduct, if X multiply
                                     if arrayOfOperators[i] == "+" {
                                         self.outcome = self.outcome + arrayOfNumbers[i]
                                        print("The \(i) time i add)")
                                     } else if arrayOfOperators[i] == "-" {
                                         self.outcome = self.outcome - arrayOfNumbers[i]
                                         print("The \(i) time i deduct)")
                                     } else if arrayOfOperators[i] == "✕" {
                                         self.outcome = self.outcome * arrayOfNumbers[i]
                                          print("The \(i) time i multiply)")
                                     } else {
                                         self.outcome = self.outcome / arrayOfNumbers[i]
                                          print("The \(i) time i devide)")
                                     }
                             print("outcome\(i): \(self.outcome)")
                                 }
                    
                    
                    
              
            
                
            }
            
            //...display Outcome and...
            self.resultDisplayed = self.outcome
            
            //prepare for the next enter
            self.outcome = 0
            
            
            
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 9
            formatter.numberStyle = .decimal
            
            
            let stringToShow = formatter.string(from: self.resultDisplayed as NSNumber)
            //...and display the result on Title
            
            //self.buttonResult.setTitle(String(describing: self.resultDisplayed), for: .normal)
            
             self.buttonResult.setTitle(stringToShow, for: .normal)
            self.buttonResult.titleLabel?.adjustsFontSizeToFitWidth = true
            
            
            self.myTableView.reloadData()
            
        
    }
    
    
    
    
    func performMathematicalCalculationUsingShuntingYardAndRPN(){
        let arrayOfCalculationInStrings = getArrayWithStrings(arrNumbers: self.arrayOfNumbers, arrOperands: self.arrayOfFactors)
        
         print("arrayOfCalculationInStrings: \(arrayOfCalculationInStrings)")
        //let testArray = ["1.0","+", "1.0", "*" , "2.0"]
       //  print("testArray: \(testArray)")
        
        let arrayOfRPN = getRPNArray(calculationArray: arrayOfCalculationInStrings)
        
         print("RPNArray: \(arrayOfRPN)")
        
        self.outcome = getResultFromRPNarray(myArray: arrayOfRPN)
        
        //...display Outcome and...
                   self.resultDisplayed = self.outcome
                   
                   //prepare for the next enter
                   self.outcome = 0
                   
                   
                   
                   let formatter = NumberFormatter()
                   formatter.minimumFractionDigits = 0
                   formatter.maximumFractionDigits = 9
                   formatter.numberStyle = .decimal
                   
                   
                   let stringToShow = formatter.string(from: self.resultDisplayed as NSNumber)
                   //...and display the result on Title
                   
                   //self.buttonResult.setTitle(String(describing: self.resultDisplayed), for: .normal)
                   
                    self.buttonResult.setTitle(stringToShow, for: .normal)
                   self.buttonResult.titleLabel?.adjustsFontSizeToFitWidth = true
                   
                   
                   self.myTableView.reloadData()
        
        
        
        
    }
    
    
    
    func getArrayWithStrings(arrNumbers: [Double], arrOperands: [String]) -> [String] {
        var myArray = [String]()
        var arrStringsFromNumbers = [String]()
        var arrNormsalisedOperands = arrOperands
        
         print("operands: \(arrOperands)")

        
        
        
        for i in 0...arrNumbers.count - 1 {
            arrStringsFromNumbers.append(String(arrNumbers[i]))
        }
        
        print("numbers: \(arrStringsFromNumbers)")
        print("operands: \(arrOperands)")
        
        
        arrNormsalisedOperands.remove(at: 0)
        
        

        for i in 0...arrStringsFromNumbers.count - 1 {
            myArray.append(arrStringsFromNumbers[i])
            if i < arrStringsFromNumbers.count - 1 {
                myArray.append(arrNormsalisedOperands[i])
            }
        }
        
        
        //correct Multiple and devide sign
        
        for i in 0...myArray.count - 1 {
            if myArray[i] == "✕" {
                myArray[i] = "*"
            } else if myArray[i] == "÷" {
                myArray[i] = "/"
            }
        }
        
        
        
        
         print("myArrayCalcCreated: \(myArray)")
        return myArray
    }//Func
    
    
    
    
    func getRPNArray(calculationArray: [String]) -> [String]{
        
         let c = calculationArray
         var myRPNArray = [String]()
         var operandArray = [String]()
         
          



          for i in 0...c.count - 1 {
              
              if c[i] != "+" && c[i] != "-" && c[i] != "*" && c[i] != "/" {
                  //push number
                  let number = c[i]
                  myRPNArray.append(number)
              
              } else  {
                  //if this is the first operand put it on the opStack
                  if operandArray.count == 0 {
                      let firstOperand = c[i]
                      operandArray.append(firstOperand)
                  } else {
                      //if I have +  -
                      
                      if  c[i] == "+" || c[i] == "-" {
                          
                          
                              operandArray.reverse()
                              myRPNArray.append(contentsOf: operandArray)
                              operandArray = []
                              
                              let uniqOperand = c[i]
                              operandArray.append(uniqOperand)
                              
                      
                          
                      } else if c[i] == "*" || c[i] == "/" {
                        
                        let strongOperand = c[i]
                        
                        //multDevide from the right
                        //--------------------------------
                        //      operandArray.append(strongOperand)
                       //----------------------------------
                        
                        //so that multDevide from the left
                        let lastOperand = operandArray[operandArray.count - 1]
                        
                        if lastOperand == "+" || lastOperand == "-" {
                            operandArray.append(strongOperand)
                        } else {
                            myRPNArray.append(lastOperand)
                            operandArray.removeLast()
                            operandArray.append(strongOperand)
                            
                        }
                        
                
                        
                      }
                  
                      
                  }
              }//operator
              
          }//iterating
          
        //when I have no more numbers I append the reversed operant array
          operandArray.reverse()
          myRPNArray.append(contentsOf: operandArray)
          operandArray = []
          
          
          print("RPN: \(myRPNArray)")
        return myRPNArray
    }//Func

    
    
    

    func getResultFromRPNarray(myArray: [String]) -> Double {
        var a = [String]()
        a = myArray
         print("a: \(a)")
        var result = Double()
        let n = a.count
        
        
        
        for i in 0...n - 1 {
            if n < 2 {
                result = Double(a[0])!
            } else {
                if a[i] == "p" {
                 //Do nothing else. Calculations are over and the result is in your hands!!!
                  // result = Double(a[i-1])!
                } else {
                    if a[i] == "+" {
                        print("a: \(a)")
                       result = Double(a[i-2])! + Double(a[i-1])!
                        a.insert(String(result), at: i-2)
                        a.remove(at: i - 1)
                        a.remove(at: i - 1)
                        a.remove(at: i - 1)
                        a.insert("p", at: 0)
                        a.insert("p", at: 0)
                    
                    } else if a[i] == "-" {
                       result = Double(a[i-2])! - Double(a[i-1])!
                        a.insert(String(result), at: i-2)
                        a.remove(at: i - 1)
                        a.remove(at: i - 1)
                        a.remove(at: i - 1)
                        a.insert("p", at: 0)
                        a.insert("p", at: 0)
                        
                    } else if a[i] == "*" {
                       result = Double(a[i-2])! * Double(a[i-1])!
                        a.insert(String(result), at: i-2)
                        a.remove(at: i - 1)
                        a.remove(at: i - 1)
                        a.remove(at: i - 1)
                        a.insert("p", at: 0)
                        a.insert("p", at: 0)
                
                    } else if a[i] == "/" {
                       result = Double(a[i-2])! / Double(a[i-1])!
                        a.insert(String(result), at: i-2)
                        a.remove(at: i - 1)
                        a.remove(at: i - 1)
                        a.remove(at: i - 1)
                        a.insert("p", at: 0)
                        a.insert("p", at: 0)
                    } else {
                        // it is a number so do nothing and go the next one
                    }
                    
                    
                }//no over yet
            }//n>2
        }//iterating
        return result
    }//Func



    
   
    
    
    
    
    func createArrayPososto(){
        var arrayOfStringPososto = self.arrayOfPerCent
        var arrayOfNetPososto = self.arrayOfPerCent
        var arrayOfDoublePososto = self.arrayOfNumbers
        
        for i in 0...arrayOfPerCent.count - 1 {
            arrayOfStringPososto[i].append( String(self.arrayOfPerCent[i].dropFirst()))
            arrayOfStringPososto[i].append( String(self.arrayOfPerCent[i].dropLast()))
        }
        
        print("STRINGPOSOSTO\(arrayOfStringPososto)")
        for i in 0...arrayOfStringPososto.count - 1 {
            arrayOfNetPososto[i].append(String(arrayOfStringPososto[i].dropLast()))
           // arrayOfDoublePososto[i] = Double(arrayOfStringPososto[i].dropLast())!
           
        }
        
        
        for i in 0...arrayOfNetPososto.count - 1 {
            if arrayOfNetPososto[i] == "" {
                arrayOfDoublePososto.append(0.0)
            } else{
                let double = Double(arrayOfNetPososto[i])
            arrayOfDoublePososto.append(double!)
            }
        }
        
       self.arrayOfPososto = arrayOfDoublePososto
        
        
    }//End
    
    
    //MARK: Mathematic Functions
    
      func perCentCalculatedAndArranged(){
          self.perCentWasPressed = true
                 
                
                 let inactiveFactorColor = #colorLiteral(red: 0.9981611371, green: 0.7537821531, blue: 0, alpha: 1)
                 self.buttonPlus.setTitleColor(inactiveFactorColor, for: .normal)
                 self.buttonMinus.setTitleColor(inactiveFactorColor, for: .normal)
                 self.buttonTimes.setTitleColor(UIColor.white, for: .normal)
                 self.buttonDivide.setTitleColor(inactiveFactorColor, for: .normal)
                 self.buttonPlus.isEnabled = false
                 self.buttonMinus.isEnabled = false
                 self.buttonTimes.isEnabled = true
                 self.buttonDivide.isEnabled = false
                 
                 
                 
                 if self.entryField.text == "" ||  self.entryField.text == "."  || self.entryField.text == ","{
                     
                      self.perCentWasPressed = false
                     
                 } else {
                     let stringOfOutcome = String(self.outcome)
                     let localizedDoubleOutcome = stringOfOutcome.doubleValue
                     
                     self.resultBeforePerCent = localizedDoubleOutcome
                     
                     let numberInField = entryField.text?.doubleValue //Double(entryField.text!)!
                     let perCentNumber = numberInField! / 100
                     
                     
                     let stringOfPerCentage = String(perCentNumber)
                     let localizedPerCent = stringOfPerCentage.doubleValue
                    
                     
                     let formatter = NumberFormatter()
                     formatter.minimumFractionDigits = 0
                     formatter.maximumFractionDigits = 9
                     formatter.numberStyle = .decimal
                     
                     
                     
                     self.entryField.text = formatter.string(from: localizedPerCent as NSNumber)
                     
                    
                     
                 }
      }//Func
      
      
      
      
      
      
      
    
    func calculateTrigonomentricRads(trig: String){
            var resultNumber = Double()
            let numberInField = (entryField.text?.doubleValue)! //Double(entryField.text!)!
           
           
           if trig == "sin" {
               resultNumber = sin(numberInField)
           } else if trig == "cos" {
               resultNumber = cos(numberInField)
           } else if trig == "tan" {
               resultNumber = tan(numberInField)
           } else if trig == "sinh" {
               resultNumber = sinh(numberInField)
           } else if trig == "cosh" {
               resultNumber = cosh(numberInField)
           } else if trig == "tanh" {
               resultNumber = tanh(numberInField)
           } else if trig == "asin" {
               resultNumber = asin(numberInField)
           } else if trig == "acos" {
               resultNumber = acos(numberInField)
           } else if trig == "atan" {
               resultNumber = atan(numberInField)
           } else if trig == "asinh" {
               resultNumber = asinh(numberInField)
           } else if trig == "acosh" {
               resultNumber = acosh(numberInField)
           } else if trig == "atanh" {
               resultNumber = atanh(numberInField)
           }
           
         
         
          
            
           
            
            let stringOfEvolvingNumber = String(resultNumber)
            let localizedEvolvingNumber = stringOfEvolvingNumber.doubleValue
           
            
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 9
            formatter.numberStyle = .decimal
            
            
            
            self.entryField.text = formatter.string(from: localizedEvolvingNumber as NSNumber)
       }
       
    func calculateTrigonomentricDegrees(trig: String){
         var resultNumber = Double()
         let numberInField = (entryField.text?.doubleValue)! //Double(entryField.text!)!
        
        
        if trig == "sin" {
            resultNumber = sin(numberInField * 3.14159265358979 / 180)
        } else if trig == "cos" {
            resultNumber = cos(numberInField * 3.14159265358979 / 180)
        } else if trig == "tan" {
            resultNumber = tan(numberInField * 3.14159265358979 / 180)
        } else if trig == "sinh" {
            resultNumber = sinh(numberInField)
        } else if trig == "cosh" {
            resultNumber = cosh(numberInField)
        } else if trig == "tanh" {
            resultNumber = tanh(numberInField)
        } else if trig == "asin" {
            resultNumber = asin(numberInField) * 180 / 3.14159265358979
        } else if trig == "acos" {
            resultNumber = acos(numberInField) * 180 / 3.14159265358979
        } else if trig == "atan" {
            resultNumber = atan(numberInField) * 180 / 3.14159265358979
        } else if trig == "asinh" {
            resultNumber = asinh(numberInField)
        } else if trig == "acosh" {
            resultNumber = acosh(numberInField)
        } else if trig == "atanh" {
            resultNumber = atanh(numberInField)
        }
        
      
      
       
         
        
         
         let stringOfEvolvingNumber = String(resultNumber)
         let localizedEvolvingNumber = stringOfEvolvingNumber.doubleValue
        
         
         let formatter = NumberFormatter()
         formatter.minimumFractionDigits = 0
         formatter.maximumFractionDigits = 9
         formatter.numberStyle = .decimal
         
         
         
         self.entryField.text = formatter.string(from: localizedEvolvingNumber as NSNumber)
    }
    
       
    func reverseNumber(){
        if self.entryField.text == "" || entryField.text == "."  || entryField.text == "," {
                                      //Do nothing
                                   
                                          
                                    } else {
                                        self.buttonTransparent.titleLabel!.text = ""
                                        
                                        
                                        let numberInField = entryField.text?.doubleValue
                                        let mirrorNumber = numberInField! - 2 * numberInField!
                                        
                                        let formatter = NumberFormatter()
                                        formatter.minimumFractionDigits = 0
                                        formatter.maximumFractionDigits = 9
                                       // formatter.numberStyle = .decimal
                                        self.entryField.text = formatter.string(from: mirrorNumber as NSNumber)
                                    }
    }//Func
    
    
    
    
    
    
    
    
    
    
    
}//Class
