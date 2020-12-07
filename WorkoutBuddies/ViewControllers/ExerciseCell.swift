//
//  ExerciseCell.swift
//  WorkoutBuddies
//
//  Created by Stephen Tan on 12/3/20.
//

import UIKit
import DropDown

class ExerciseCell: UITableViewCell {
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var chooseSetsBtn: UIButton!
    @IBOutlet weak var chooseRepsBtn: UIButton!
    
    
    let dropDown = DropDown()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func onTapChooseSets(_ sender: UIButton) {
        dropDown.dataSource = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
        dropDown.anchorView = sender
        dropDown.show()
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else {return}
            sender.setTitle(item, for: .normal)
        }
    }

    
    
    @IBAction func onTapChooseReps(_ sender: UIButton) {
        dropDown.dataSource = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15"]
        dropDown.anchorView = sender
        dropDown.show()
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else {return}
            sender.setTitle(item, for: .normal)
        }
    }
}
