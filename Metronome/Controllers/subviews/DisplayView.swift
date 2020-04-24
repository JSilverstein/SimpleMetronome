//
//  DisplayView.swift
//  Metronome
//
//  Created by Jacob Silverstein on 3/3/20.
//  Copyright © 2020 Jacob Silverstein. All rights reserved.
//

import UIKit

class DisplayView: UIView {

    @IBOutlet var outerBorderView: UIView!
    @IBOutlet var middleBorderView: UIView!
    @IBOutlet var innerBorderView: UIView!
    @IBOutlet var mainView: UIView!
    @IBOutlet var countLabel: UILabel!
    
    var isLight = true
    var count = 1
    var beats = 8
    
    //TODO: Add initializer
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureViews()
    }

    func configureViews() {
        self.layoutIfNeeded()
        mainView.layer.cornerRadius = (mainView.frame.width / 2)
        innerBorderView.layer.cornerRadius = (innerBorderView.frame.width / 2)
        outerBorderView.layer.cornerRadius = (outerBorderView.frame.width / 2)
        self.layer.cornerRadius = (self.frame.width / 2)
        middleBorderView.layer.cornerRadius = (middleBorderView.frame.width / 2)
        self.layer.shadowRadius = 16
        self.layer.shadowOffset = CGSize(width: 2, height: 8)
        self.layer.shadowOpacity = 0.3
    }
    
    func handleClick() {
        self.countLabel.text = "\(self.count)"
        
        if self.isLight == true {
            self.countLabel.textColor = Colors.metroBlue
            self.mainView.backgroundColor = Colors.metroGray
        } else {
            self.countLabel.textColor = Colors.metroGray
            self.mainView.backgroundColor = Colors.metroBlue
        }
        self.isLight = !self.isLight
        if count > beats {
            count = 1
        } else {
            count += 1
        }
    }
}
