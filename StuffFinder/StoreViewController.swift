//
//  StoreViewController.swift
//  StuffFinder
//
//  Created by Arpit Lokwani on 12/20/16.
//  Copyright © 2016 Arpit Lokwani. All rights reserved.
//

import UIKit
import CoreData

class StoreViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var stuffNameTextFiel: UITextField!
    
    @IBOutlet weak var locationTextViewField: UITextView!
    var stuffDetail = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        stuffNameTextFiel.delegate = self
       
        // Do any additional setup after loading the view.
    }

    @IBAction func recorderButtonPressed(_ sender: Any) {
    }
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
    }
    
    @IBAction func storeButtonPressed(_ sender: Any) {
        
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //2
        let entity =  NSEntityDescription.entity(forEntityName: "StuffDetail",
                                                 in:managedContext)
        
        let person = NSManagedObject(entity: entity!,
                                     insertInto: managedContext)
        
        person.setValue(stuffNameTextFiel.text, forKey: "name")
        person.setValue(locationTextViewField.text, forKey: "location")
        
        
        do {
            try managedContext.save()
            self.navigationController?.popViewController(animated: true)
            
            //5
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     public func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        stuffNameTextFiel.resignFirstResponder()
        return true
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
