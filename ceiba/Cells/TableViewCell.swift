//
//  TableViewCell.swift
//  ceiba
//
//  Created by Macbook on 6/02/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var mail: UILabel!
    @IBOutlet weak var viewMore: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
