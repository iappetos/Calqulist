//
//  ReceiptRequestor.swift
//  Calqulist
//
//  Created by Ioannis on 11/1/21.
//  Copyright © 2021 Ioannis. All rights reserved.
//

import Foundation
import StoreKit


class ReceiptRequestor: NSObject, SKRequestDelegate {
    let receiptRequest = SKReceiptRefreshRequest()
    var completion: () -> Void = {}
    
    override init() {
        super.init()
        self.receiptRequest.delegate = self
        
    }
    
    
    
    
    func start(completion: @escaping () -> Void = {}) {
        self.receiptRequest.start()
        self.completion = completion
    }
    
    func requestDidFinish(_ request: SKRequest) {
        self.completion()
    }
    
    
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Refresh failed")
        print(error.localizedDescription)
    }
    
}//class
