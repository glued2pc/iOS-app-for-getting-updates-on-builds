//
//  sysInsTableViewCell.swift
//  systemInsightsWofilter
//
//  Created by Development on 19/04/17.
//  Copyright © 2017 Development. All rights reserved.
//

import UIKit

class sysInsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cidsid: UILabel!
    @IBOutlet weak var tier: UILabel!
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var solName: UILabel!
    @IBOutlet weak var cddDate: UILabel!
    @IBOutlet weak var opprId: UILabel!
    @IBOutlet weak var spcPerc: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
