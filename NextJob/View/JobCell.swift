//
//  JobCell.swift
//  NextJob
//
//  Created by Lervin Urena on 10/28/20.
//
import UIKit

class JobCell: UITableViewCell {
    
    var onSharePressed: (() -> Void)? = nil

    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var jobShortDesc: UILabel!
    @IBOutlet weak var jobDate: UILabel!
    @IBOutlet weak var imgSquare: UIView!
    @IBOutlet var jobImage: UIImageView!
    @IBOutlet weak var shareBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgSquare.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        imgSquare.layer.shadowOpacity = 0.5
        imgSquare.layer.shadowOffset = CGSize(width: 3, height: 3)
        imgSquare.layer.shadowRadius = 1
        shareBtn.imageView?.contentMode = .scaleAspectFit

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func shareBtnPressed(_ sender: UIButton) {
        onSharePressed?()
    }
}
