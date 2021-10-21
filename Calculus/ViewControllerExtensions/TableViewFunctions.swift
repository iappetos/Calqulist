//
//  TableViewFunctions.swift
//  Calqulist
//
//  Created by Ioannis Karagogoson 14/1/20.
//  Copyright © 2020 Ioannis Karagogos. All rights reserved.
//

import Foundation
import  UIKit


extension ViewController {
    
       
       public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               return arrayOfNumbers.count
           }
           
       public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               let cell = tableView.dequeueReusableCell(withIdentifier: "TextInputCell") as! TextInputTableViewCell
           
           cell.delegate = self
           
           
           
          
           
            arrayOfFactors[0] = ""
            //arrayOfDots[0] = "○"
          
           let enteredNumber = self.arrayOfNumbers[indexPath.row]
           let enteredFactor = self.arrayOfFactors[indexPath.row]
           let enteredCent = self.arrayOfPerCent[indexPath.row]
          // let enteredDot = self.arrayOfDots[indexPath.row]
           
           
           let formatter = NumberFormatter()
           formatter.minimumFractionDigits = 0
           formatter.maximumFractionDigits = 9
           formatter.numberStyle = .decimal
           
           
           
           if arrayOfNumbers.count > 0 {
              // cell.myTextField.text = String(describing: enteredNumber)
               
               cell.myTextField.text = formatter.string(from: enteredNumber as NSNumber)
               cell.buttonFactor.setTitle(enteredFactor, for: .normal)
               cell.labelPerCent.text = enteredCent
               cell.btnSelect.setTitle("○", for: .normal)
           }
           
          
           
           
               return cell
           }//Function
       
       //Allows deleting
       
       public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           
           if self.arrayOfNumbers.count < 2 {
               //Do nothing
           } else {
           
           if editingStyle == .delete {
               
               //if we delete the 2nd number
               if self.arrayOfNumbers.count == 2 {
                   hideEditMail()
                   lastAvailableDeleted = true
               }
               
               self.arrayOfNumbers.remove(at: indexPath.row)
               self.arrayOfFactors.remove(at: indexPath.row)
               self.arrayOfDots.remove(at: indexPath.row)
               myTableView.deleteRows(at: [indexPath], with: .fade)
            
              //clean percentages below deleted row
              let n = indexPath.row
              for i in n...arrayOfPerCent.count - 1{
                self.arrayOfPerCent[i] = ""
              }
            
               arrangeBigDot()
            
            
               myTableView.reloadData()
            
            
                           calculateNow()
            
                       
               
               //if we delete the 2nd number
               if self.arrayOfNumbers.count == 2 {
                   
               }
               
               
               
           }//delete
               
               
           }//Do something
       }//Func
       
       //Allows moving
       public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
           return true
       }
       
       //which moves where
       public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
           let numberSource = arrayOfNumbers[sourceIndexPath.row]
           let factorSource = arrayOfFactors[sourceIndexPath.row]
           let perCentSource = arrayOfPerCent[sourceIndexPath.row]
           let posostoSource = arrayOfPososto[sourceIndexPath.row]
           let dotSource = arrayOfDots[sourceIndexPath.row]
           
           if sourceIndexPath.row == 0 {
             //Do nothing
           } else if destinationIndexPath.row == 0 {
              //Do nothing
           } else {
           
           
           arrayOfNumbers.remove(at: sourceIndexPath.row)
           arrayOfNumbers.insert(numberSource, at: destinationIndexPath.row)
           
       
           arrayOfFactors.remove(at: sourceIndexPath.row)
           arrayOfFactors.insert(factorSource, at: destinationIndexPath.row)
           
           arrayOfPerCent.remove(at: sourceIndexPath.row)
           arrayOfPerCent.insert(perCentSource, at: destinationIndexPath.row)
               
           arrayOfPososto.remove(at: sourceIndexPath.row)
           arrayOfPososto.insert(posostoSource, at: destinationIndexPath.row)
            
            arrayOfDots.remove(at: sourceIndexPath.row)
            arrayOfDots.insert(dotSource, at: destinationIndexPath.row)
          
                   
           }
          
           
           
       
      
           //clean percentages
           for i in 0...arrayOfPerCent.count - 1{
               self.arrayOfPerCent[i] = ""
           }
        
          arrangeBigDot()
    
           
           self.myTableView.reloadData()
          
                          calculateNow()
                    
                      
       }
       
    
}
