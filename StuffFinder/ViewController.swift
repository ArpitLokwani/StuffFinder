//
//  ViewController.swift
//  StuffFinder
//
//  Created by Arpit Lokwani on 12/20/16.
//  Copyright © 2016 Arpit Lokwani. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {

    var stuffDetails = [NSManagedObject]()
    @IBAction func storeMyStuffButtonPressed(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "StoreViewController") as! StoreViewController
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    @IBAction func findMyStuffButtonPressed(_ sender: Any) {
        
    let next = self.storyboard?.instantiateViewController(withIdentifier: "FinderViewController") as! FinderViewController
       self.navigationController?.pushViewController(next, animated: true)
        //1
           }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Stuff Finder"
        self.navigationController?.navigationBar.barTintColor = UIColor.orange

     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

