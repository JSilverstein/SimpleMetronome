//
//  CountView.swift
//  Metronome
//
//  Created by Jacob Silverstein on 3/11/18.
//  Copyright © 2018 Jacob Silverstein. All rights reserved.
//

import UIKit

class CountView: UIView {
    @IBOutlet var button1: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        print(sender.tag)
    }
}
