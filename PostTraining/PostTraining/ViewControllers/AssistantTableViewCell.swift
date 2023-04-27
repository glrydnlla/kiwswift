//
//  AssistantTableViewCell.swift
//  PostTraining
//
//  Created by prk on 19/04/23.
//

import UIKit

class AssistantTableViewCell: UITableViewCell {

    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var detailTxt: UITextField!
    
    var updateHandler = {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func updateClicked(_ sender: Any) {
        updateHandler()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
