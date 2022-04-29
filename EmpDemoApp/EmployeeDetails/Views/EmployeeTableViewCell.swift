//
//  EmployeeTableViewCell.swift
//  EmpDemoApp
//
//  Created by Nitesh on 29/04/22.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var memberIdLabel: UILabel!
    @IBOutlet weak var memberNameLabel: UILabel!
    
    static let cellIdentifier = "EmployeeCell"
    
    var employee: EmployeeDetails!{
        didSet{
            self.memberIdLabel.text = employee.memberID.string
            self.memberNameLabel.text = employee.memberName
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
