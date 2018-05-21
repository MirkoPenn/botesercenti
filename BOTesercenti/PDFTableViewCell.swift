//
//  PDFTableViewCell.swift
//  Pdf
//
//  Created by Simone Penna on 20/05/2018.
//  Copyright © 2018 Simone Penna. All rights reserved.
//

import UIKit

class PDFTableViewCell: UITableViewCell {

    @IBOutlet weak var documentImage: UIImageView!
    @IBOutlet weak var documentTitle: UILabel!
    @IBOutlet weak var documentDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
