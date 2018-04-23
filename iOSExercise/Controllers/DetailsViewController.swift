//
//  DetailsViewController.swift
//  iOSExercise
//
//  Created by Abdullah Alhaider on 4/23/18.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//

import UIKit
import SDWebImage

class DetailsViewController: UIViewController {

    
    @IBOutlet weak var imageHightConstraint: NSLayoutConstraint!

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titelText: UITextView!
    @IBOutlet weak var desText: UITextView!
    
    
    // Creating variables to receive the data that coming from another viewController
    var receivedArticalTitel: String?
    var receivedArticalContent: String?
    var receivedArticalImageUrl: String?
    
    
    
    // MARK - viewDidLoad
    /**************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        show()
        setUpImageHight()
    }


    
    // MARK - show
    /**************************************************************/
    fileprivate func show(){
        titelText.text = receivedArticalTitel
        desText.text = receivedArticalContent
        image.sd_setImage(with: URL(string: receivedArticalImageUrl!))
    }
    
    
    
    // MARK - setUpImageHight
    /**************************************************************/
    fileprivate func setUpImageHight(){
        // Getting the screen hight
        let screenSize: CGRect = UIScreen.main.bounds
        // Setting the constraint to a new value
        imageHightConstraint.constant = screenSize.height * 0.25
    }

    
    
    
    
    
}// class end
