//
//  ArticlesCell.swift
//  iOSExercise
//
//  Created by Abdullah Alhaider on 4/23/18.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//

import UIKit

class ArticlesCell: UITableViewCell {

    
    @IBOutlet weak var articleImage: UIImageView!
    
    @IBOutlet weak var titleText: UITextView!
    
    @IBOutlet weak var desText: UITextView!
    
    @IBOutlet weak var articleWebsite: UILabel!
    @IBOutlet weak var articleAuthor: UILabel!
    
    @IBOutlet weak var articleDate: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
