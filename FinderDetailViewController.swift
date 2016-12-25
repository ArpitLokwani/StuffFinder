//
//  FinderDetailViewController.swift
//  StuffFinder
//
//  Created by Arpit Lokwani on 23/12/16.
//  Copyright © 2016 Arpit Lokwani. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation
class FinderDetailViewController: UIViewController,AVAudioRecorderDelegate,AVAudioPlayerDelegate {
   
    var stuffDetails:NSManagedObject? = nil
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    
    @IBOutlet weak var stuffImage: UIImageView!
    
    @IBOutlet weak var stuffLabel: UILabel!
    
    @IBOutlet weak var stuffDetailLabel: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBAction func playButtonPressed(_ sender: Any) {
        let stuff =  stuffDetails

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let stuff =  stuffDetails
        //print(stuff?.value(forKey: "name"))
        stuffLabel.text = stuff?.value(forKey: "name") as! String?
        let image : UIImage = UIImage(data: (stuff!.value(forKey: "imageData") as! Data))!

        stuffImage.image = image
        
        do {
            let url = NSURL(string: (stuff?.value(forKey: "recorder") as! String))
            
            try audioPlayer = AVAudioPlayer(contentsOf:url as! URL)
            audioPlayer!.delegate = self
            audioPlayer!.prepareToPlay()
            audioPlayer!.play()
        } catch let error as NSError {
            print("audioPlayer error: \(error.localizedDescription)")
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
