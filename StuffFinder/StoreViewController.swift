//
//  StoreViewController.swift
//  StuffFinder
//
//  Created by Arpit Lokwani on 12/20/16.
//  Copyright © 2016 Arpit Lokwani. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation
import MobileCoreServices
class StoreViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,AVAudioRecorderDelegate,AVAudioPlayerDelegate {

    
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    let appDelegate:AppDelegate? = nil
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stuffNameTextFiel: UITextField!
    @IBOutlet weak var imagePicked: UIImageView!
    @IBOutlet weak var locationTextViewField: UITextView!
    var stuffDetail = [NSManagedObject]()
    
    var soundRecorder: AVAudioRecorder!
    var soundPlayer:AVAudioPlayer!
    var soundFileURL:AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stuffNameTextFiel.delegate = self
        playButton.isEnabled = false
        stopButton.isEnabled = false
        locationTextViewField.layer.cornerRadius = 2
        locationTextViewField.layer.borderColor = UIColor.black.cgColor
        locationTextViewField.layer.borderWidth = 2
        let appDelegate = Helper.sharedDelegate()
        appDelegate.counter += 1
        
        let fileMgr = FileManager.default
        
        let dirPaths = fileMgr.urls(for: .documentDirectory,
                                    in: .userDomainMask)
        
        let soundString = "sound"
        let count = String(appDelegate.counter)
        let cafString = ".caf"
        
        soundFileURL = dirPaths[0].appendingPathComponent(soundString+count+cafString) as AnyObject?
        
        let recordSettings =
            [AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue,
             AVEncoderBitRateKey: 16,
             AVNumberOfChannelsKey: 2,
             AVSampleRateKey: 44100.0] as [String : Any]
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(
                AVAudioSessionCategoryPlayAndRecord)
        } catch let error as NSError {
            print("audioSession error: \(error.localizedDescription)")
        }
        
        do {
            try audioRecorder = AVAudioRecorder(url: soundFileURL! as! URL,
                                                settings: recordSettings as [String : AnyObject])
            audioRecorder?.prepareToRecord()
        } catch let error as NSError {
            print("audioSession error: \(error.localizedDescription)")
        }
        // Do any additional setup after loading the view.
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordButton.isEnabled = true
        stopButton.isEnabled = false
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print("Audio Play Decode Error")
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        print("Audio Record Encode Error")
    }
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func storeButtonPressed(_ sender: Any) {

        let managedContext = Helper.sharedDelegate().persistentContainer.viewContext
        //2
        let entity =  NSEntityDescription.entity(forEntityName: "StuffDetail",
                                                 in:managedContext)
        
        let person = NSManagedObject(entity: entity!,
                                     insertInto: managedContext)
        
        person.setValue(stuffNameTextFiel.text, forKey: "name")
        
        if locationTextViewField.text.characters.count>0 {
            person.setValue(locationTextViewField.text, forKey: "location")

        }
        
        
        var urlString: String = soundFileURL!.path
               person.setValue(urlString, forKey: "recorder")
        if imagePicked.image != nil
        {
            let image =  imagePicked.image
            let imageData = NSData(data: UIImageJPEGRepresentation(image!, 1.0)!)
            person.setValue(imageData, forKey: "imageData")
        }
        do {
            try managedContext.save()
            self.navigationController?.popViewController(animated: true)
          
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePicked.contentMode = .scaleToFill
            imagePicked.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     public func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        stuffNameTextFiel.resignFirstResponder()
        return true
        
    }
    
    @IBAction func stopButtonPressed(_ sender: Any) {
        stopButton.isEnabled = false
        playButton.isEnabled = true
        recordButton.isEnabled = true
        
        if audioRecorder?.isRecording == true {
            audioRecorder?.stop()
        } else {
            audioPlayer?.stop()
        }
    }
    @IBAction func playButtonPressed(_ sender: Any) {
        if audioRecorder?.isRecording == false {
            stopButton.isEnabled = true
            recordButton.isEnabled = false
            
            do {
                try audioPlayer = AVAudioPlayer(contentsOf:
                    (audioRecorder?.url)!)
                audioPlayer!.delegate = self
                audioPlayer!.prepareToPlay()
                audioPlayer!.play()
            } catch let error as NSError {
                print("audioPlayer error: \(error.localizedDescription)")
            }
        }
        
    }
    
    @IBAction func recorderButtonPressed(_ sender: Any) {
        if audioRecorder?.isRecording == false {
            playButton.isEnabled = false
            stopButton.isEnabled = true
            audioRecorder?.record()
        }
    }
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // for recording sound
    
    
    
}
