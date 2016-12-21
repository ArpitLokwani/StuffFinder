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
       // let next = self.storyboard?.instantiateViewController(withIdentifier: "FinderViewController") as! FinderViewController
        //self.navigationController?.pushViewController(next, animated: true)
        //1
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //2
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StuffDetail")
        
        //3
        do {
           let results =
             try managedContext.fetch(fetchRequest)
            
          stuffDetails = results as! [NSManagedObject]
            
         let stuff = stuffDetails[0]
            
          print(stuff.value(forKey: "name"))
            
           
            // let person
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
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

