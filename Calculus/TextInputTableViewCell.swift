//
//  TextInputTableViewCell.swift
//  Calqulist
//
//  Created by Ioannis Karagogos on 25/1/19.
//  Copyright © 2019 Ioannis Karagogos. All rights reserved.
//

import UIKit

protocol CellSubclassDelegate: class {
    func buttonTapped(cell: TextInputTableViewCell)
}



public class TextInputTableViewCell: UITableViewCell {

   
    
    @IBOutlet weak var buttonFactor: UIButton!
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var labelPerCent: UILabel!
    @IBOutlet weak var btnSelect: UIButton!
    
    
    weak var delegate: CellSubclassDelegate?
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        self.delegate = nil
    }
    
    
    
     public func configure(text: String?, placeholder: String) {
       
        
        myTextField.text = text
      //  myTextField.placeholder = placeholder
        
        myTextField.accessibilityValue = text
       // myTextField.accessibilityLabel = placeholder
        
        
       
    }
    
    public func configureButton(factor: String?) {
        buttonFactor.setTitle(ViewController.GlobalVariable.myOwnFactor, for: .normal)
    }
    
    
    @IBAction func changeFactor(_ sender: Any) {
        self.delegate?.buttonTapped(cell: self)
        
        if self.buttonFactor.titleLabel!.text == "+"  {
            self.buttonFactor.setTitle("-", for: .normal)
        } else if self.buttonFactor.titleLabel!.text == "-" {
            self.buttonFactor.setTitle("✕", for: .normal)
        } else if self.buttonFactor.titleLabel!.text == "✕" {
            self.buttonFactor.setTitle("÷", for: .normal)
        } else {
             self.buttonFactor.setTitle("+", for: .normal)
        }
    }
    
    
   
    @IBAction func markToCompare(_ sender: Any) {
        
        
    
              self.btnSelect.setTitle("◉", for: .normal)
      
           
    }
    
   
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        myTextField.isUserInteractionEnabled = false
        // Initialization code
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


public extension UITableView {
    
    /**
     This method returns the indexPath of the cell that contains the specified view
     
     - Parameter view: The view to find.
     
     - Returns: The indexPath of the cell containing the view, or nil if it can't be found
     
     */
    
    func indexPathForView(_ view: UIView) -> IndexPath? {
        let center = view.center
        let viewCenter = self.convert(center, from: view.superview)
        let indexPath = self.indexPathForRow(at: viewCenter)
        return indexPath
    }
}
