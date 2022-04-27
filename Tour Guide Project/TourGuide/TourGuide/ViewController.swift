//
//  ViewController.swift
//  TourGuide
//
//  Created by Stacy Chieng  on 10/6/21.
//

import UIKit
import AVKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var activityName: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelPhoneNum: UILabel!
    @IBOutlet weak var labelWebsite: UILabel!
    
    @IBOutlet weak var labelImage: UIImageView!
    @IBOutlet weak var BkgroundImage: UIImageView!
    
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var Button:UIButton!
    
    var mySound:AVAudioPlayer!
    
    @IBAction func btnVisit(_ sender: Any) {
        let app = UIApplication.shared
        let ActivityUrl = URL(string:randomGlobalObject.ActivitySite)
        app.open(ActivityUrl!)
    }
    
    var TGObjectArray = [TourGuide]()
    var passedTourGuide: TourGuide = TourGuide()
    var randomGlobalObject:TourGuide = TourGuide()
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        labelImage.alpha = 0.0
        activityName.alpha = 0.0
        labelAddress.alpha = 0.0
        labelDescription.alpha = 0.0
        labelPrice.alpha = 0.0
        labelPhoneNum.alpha  = 0.0
        labelWebsite.alpha  = 0.0
        BkgroundImage.alpha = 0.0
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        UIView.animate(withDuration:5.0, animations : {
            self.labelImage.alpha = 1.0
            self.activityName.alpha = 0.5
            self.labelAddress.alpha = 2.0
            self.labelDescription.alpha = 1.5
            self.labelPrice.alpha = 2.5
            self.labelPhoneNum.alpha  = 2.5
            self.labelWebsite.alpha  = 3.0
            self.BkgroundImage.alpha = 1.0
        })
        setLabels()
    }
    
    func setLabels() {
  //      let randomTG = TGObjectArray.randomElement()
        let randomTG = passedTourGuide
        
        randomGlobalObject = randomTG
        activityName.text = randomTG.ActivityName
        labelAddress.text = randomTG.ActivityAddress
        labelDescription.text = randomTG.ActivityDescription
        labelPrice.text = randomTG.ActivityPrice
        labelPhoneNum.text = randomTG.ActivityPhoneNum
        labelWebsite.text = randomTG.ActivitySite
        
        let imgName = randomTG.ActivityImage
        labelImage.image = convertToImage(imgURL: imgName)
        
   //     let imgBack = randomTG.BackgroundImage
        
        mySound.play()
    }
    
    func convertToImage(imgURL:String) ->UIImage {
        let imgURL2 = URL(string:imgURL)!
        
        let imgData = try? Data(contentsOf: imgURL2)
        
        print(imgData ?? "Error. Image does not exist at URL \(imgURL)")
        let img = UIImage(data:imgData!)
        return img!
    }

    
    @IBAction func btnNextTouch(_ sender: Any) {
        setLabels()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
        if segue.identifier == "showSubDetail" {
            let destController = segue.destination as! DetailViewController
            destController.passedTourGuide = self.passedTourGuide
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mySound = try? AVAudioPlayer(contentsOf:URL(fileURLWithPath: Bundle.main.path(forResource: "click", ofType: "wav")!))
        
  //      populateTourGuideInfo()
        Button.backgroundColor = .systemBlue
        Button.setTitle("Upload/take a Picture",for: .normal)
        Button.setTitleColor(.white, for: .normal)
        setLabels()
    }
    
    // Cannot open camera if it is on stimulation, it should work otherwise! But changed to photo library to avoid the source type 1 not found error
    @IBAction func didTapButton() {
        let picker = UIImagePickerController()
        // uncomment to use camera on actual app
//        picker.sourceType = .camera
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
    }
}

extension ViewController {
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            
            picker.dismiss(animated: true, completion: nil)
            }
            
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMidaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                
                picker.dismiss(animated: true, completion: nil)
                
                guard let image = info[UIImagePickerController.InfoKey.originalImage] as?
                    UIImage else {
                    return
                }
                ImageView.image = image
            }
}
