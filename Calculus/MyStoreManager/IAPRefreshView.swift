//
//  IAPRefreshView.swift
//  Calqulist
//
//  Created by Ioannis on 11/1/21.
//  Copyright © 2021 Ioannis. All rights reserved.
//

import Foundation
import StoreKit

enum ProductType {
    case nonconsumable
    case consumable
}


struct ContentItem {
    var identifier: String
    var purchaseType: ProductType
    var content: String
}

//-----------------------------------------------Dig in it--------------------------------------
struct AppContent {
    static let main = {
        ContentItem(identifier: "com.ikaragogos.Calqulist.CalqulistPro", purchaseType: .nonconsumable, content: "youBought Pro")
      //  ContentItem(identifier: "com.iappetos.LuckyPunk.ExtraTrials", purchaseType: .consumable, content: "10 extras bought")
        
    }
}
