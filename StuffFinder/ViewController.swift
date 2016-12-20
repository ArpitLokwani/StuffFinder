//
//  ViewController.swift
//  StuffFinder
//
//  Created by Arpit Lokwani on 12/20/16.
//  Copyright © 2016 Arpit Lokwani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBAction func storeMyStuffButtonPressed(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "StoreViewController") as! StoreViewController
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    @IBAction func findMyStuffButtonPressed(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "FinderViewController") as! FinderViewController
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

