//
//  Helper.swift
//  StuffFinder
//
//  Created by Arpit Lokwani on 22/12/16.
//  Copyright © 2016 Arpit Lokwani. All rights reserved.
//

import UIKit

class Helper: NSObject {
  
    //  let appDelegate =    UIApplication.shared.delegate as! AppDelegate

    static func sharedDelegate() -> AppDelegate {
        return  UIApplication.shared.delegate as! AppDelegate
    }
}
