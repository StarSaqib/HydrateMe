//
//  LogsTableViewCell.swift
//  Hydrate Me
//
//  Created by admin on 25/1/25.
//

import UIKit

class LogsTableViewCell: UITableViewCell {

    @IBOutlet weak var waterIntakeLabel: UILabel!
    @IBOutlet weak var intakeTargetLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var hydrationStatus: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.dropShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
