//
//  PhotoController.swift
//  GWC-2016
//
//  Created by Joyce Van Drost on 7/20/16.
//  Copyright © 2016 Daily Burn. All rights reserved.
//

import UIKit
import Alamofire

var imageData: NSData? = nil
var takenImage: UIImage?

class PhotoController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var cameraAccess: UIButton!
    @IBOutlet weak var photoLibrary: UIButton!
    
    var emotions: [String] = ["anger", "contempt", "disgust", "fear", "happiness", "neutral", "sadness", "surprise"]
    var numbers: [Float] = []
    
    func getEmotions(imageData: NSData) {
        var detectedEmotion: String = ""
        var detectedIndex: Int = -1
        var detectedLevel: Float = 0.0
        let headers = ["Content-Type": "application/octet-stream",
                       "Ocp-Apim-Subscription-Key": "af3e3e8332dd40a3ba68bc570855d368"]
        
        Alamofire.upload(.POST, "https://api.projectoxford.ai/emotion/v1.0/recognize", headers: headers, data: imageData)
            .progress { bytesWritten, totalBytesWritten, totalBytesExpectedToWrite in
                print(totalBytesWritten)
                
                dispatch_async(dispatch_get_main_queue()) {
                    print("Total bytes written on main queue: \(totalBytesWritten)")
                }
            }
            .validate()
            .responseJSON { response in
                print(response)
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    if JSON.count! > 0 {
                        for a in 0..<8{
                            self.numbers.append(JSON[0]!["scores"]!![self.emotions[a]] as! Float)
                        }
                        var i: Int = 0
                        for num in self.numbers{
                            if num > detectedLevel {
                                detectedIndex = i
                                detectedLevel = num
                            }
                            i += 1
                        }
                        detectedEmotion = self.emotions[detectedIndex]
                        print(detectedEmotion)
                    }
                    //self.processEmotion()
                    self.numbers.removeAll()
                    print("Success!")
                }
        }
    }
    
    @IBAction func cameraAccessAction(sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .Camera
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                                 didFinishPickingMediaWithInfo info: [String : AnyObject]) {
                let takenImage = info[UIImagePickerControllerOriginalImage]
    }
    
    
    @IBAction func photoLibraryAction(sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func getData() {
        if takenImage != nil {
            imageData = UIImagePNGRepresentation(takenImage!)
            getEmotions(imageData!)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
        
}