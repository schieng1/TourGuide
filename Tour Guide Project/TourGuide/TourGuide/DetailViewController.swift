//
//  DetailViewController.swift
//  TourGuide
//
//  Created by Stacy Chieng  on 12/5/21.
//

import Foundation
import AVKit
import WebKit
class DetailViewController : UIViewController {
    
    
    @IBOutlet weak var UILabel: UILabel!
    
    @IBOutlet weak var WKWebbView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UILabel.text = passedTourGuide.ActivityName
        loadWebKitContent()
    }
    
    func loadWebKitContent() {
        let tgSiteURL = URL(string: passedTourGuide.ActivitySite)
        let request = URLRequest(url: tgSiteURL!)
        WKWebbView.load(request)
        
    }
    
    var passedTourGuide:TourGuide = TourGuide()

}
