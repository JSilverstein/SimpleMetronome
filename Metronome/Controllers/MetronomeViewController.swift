//
//  MetronomeViewController.swift
//  Metronome
//
//  Created by Jacob Silverstein on 2/27/18.
//  Copyright © 2018 Jacob Silverstein. All rights reserved.
//

import UIKit
import AVFoundation
import MetronomeManager

class MetronomeViewController: UIViewController, TimerManagerDelegate {
    @IBOutlet var decreaseButton: UIButton!
    @IBOutlet var increaseButton: UIButton!
    @IBOutlet var bpmLabel: UILabel!
    @IBOutlet var bpmSlider: UISlider!

    @IBOutlet weak var displayView: DisplayView!
    
    let timerManager = TimerManager()
    var player1: AVAudioPlayer?
    var player2: AVAudioPlayer?
    var player3: AVAudioPlayer?
    var player4: AVAudioPlayer?
    var player5: AVAudioPlayer?
    var player6: AVAudioPlayer?
    var player7: AVAudioPlayer?
    var player8: AVAudioPlayer?
    var player9: AVAudioPlayer?
    var count = 1
    var isLight = true
    var isIncrementing = false
    var beats = 8
    var currentBpm = 120 {
        didSet {
            if currentBpm > maxTempo {
                currentBpm = maxTempo
            }
            if currentBpm < minTempo {
                currentBpm = minTempo
            }
            bpmLabel.text = "\(currentBpm)"
            timerManager.currentBpm = Double(currentBpm)
        }
    }
    let minTempo = 60
    let maxTempo = 240
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configurePlayers()
        
        timerManager.currentBpm = Double(currentBpm)
        bpmLabel.text = "\(currentBpm)"
        
        timerManager.delegate = self
        timerManager.startTimer()
            /*
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(beatsViewTapped))
        beatsView.isUserInteractionEnabled = true
        beatsView.addGestureRecognizer(tapGestureRecognizer)
 */
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setSlider(forBpm: currentBpm)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    func configurePlayers() {
        var url = Bundle.main.url(forResource: "one", withExtension: "wav")!
        do {
            player1 = try AVAudioPlayer(contentsOf: url)
            guard let player1 = player1 else { return }
            
            player1.prepareToPlay()
        } catch let error as NSError {
            print(error.description)
        }
        
        url = Bundle.main.url(forResource: "two_1", withExtension: "wav")!
        
        do {
            player2 = try AVAudioPlayer(contentsOf: url)
            guard let player2 = player2 else { return }
            
            player2.prepareToPlay()
        } catch let error as NSError {
            print(error.description)
        }
        
        url = Bundle.main.url(forResource: "three", withExtension: "wav")!
        do {
            player3 = try AVAudioPlayer(contentsOf: url)
            guard let player3 = player3 else { return }
            
            player3.prepareToPlay()
        } catch let error as NSError {
            print(error.description)
        }
        
        url = Bundle.main.url(forResource: "four", withExtension: "wav")!
        
        do {
            player4 = try AVAudioPlayer(contentsOf: url)
            guard let player4 = player4 else { return }
            
            player4.prepareToPlay()
        } catch let error as NSError {
            print(error.description)
        }
        
        url = Bundle.main.url(forResource: "five", withExtension: "wav")!
        do {
            player5 = try AVAudioPlayer(contentsOf: url)
            guard let player5 = player5 else { return }
            
            player5.prepareToPlay()
        } catch let error as NSError {
            print(error.description)
        }
        
        url = Bundle.main.url(forResource: "six", withExtension: "wav")!
        
        do {
            player6 = try AVAudioPlayer(contentsOf: url)
            guard let player6 = player6 else { return }
            
            player6.prepareToPlay()
        } catch let error as NSError {
            print(error.description)
        }
        
        url = Bundle.main.url(forResource: "seven", withExtension: "wav")!
        do {
            player7 = try AVAudioPlayer(contentsOf: url)
            guard let player7 = player7 else { return }
            
            player7.prepareToPlay()
        } catch let error as NSError {
            print(error.description)
        }
        
        url = Bundle.main.url(forResource: "eight", withExtension: "wav")!
        
        do {
            player8 = try AVAudioPlayer(contentsOf: url)
            guard let player8 = player8 else { return }
            
            player8.prepareToPlay()
        } catch let error as NSError {
            print(error.description)
        }
        
        url = Bundle.main.url(forResource: "nine", withExtension: "wav")!
        
        do {
            player9 = try AVAudioPlayer(contentsOf: url)
            guard let player9 = player9 else { return }
            
            player9.prepareToPlay()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func timerDidFire() {
        DispatchQueue.main.async {
            
            self.displayView.handleClick()
           
            switch self.count {
            case 1:
                self.player1?.currentTime = 0
                self.player1?.play()
            case 2:
                self.player2?.currentTime = 0
                self.player2?.play()
            case 3:
                self.player3?.currentTime = 0
                self.player3?.play()
            case 4:
                self.player4?.currentTime = 0
                self.player4?.play()
            case 5:
                self.player5?.currentTime = 0
                self.player5?.play()
            case 6:
                self.player6?.currentTime = 0
                self.player6?.play()
            case 7:
                self.player7?.currentTime = 0
                self.player7?.play()
            case 8:
                self.player8?.currentTime = 0
                self.player8?.play()
            case 9:
                self.player9?.currentTime = 0
                self.player9?.play()
            default:
                break
            }
            
            self.isLight = !self.isLight
            self.count += 1
            if self.count > self.beats {
                self.count = 1
                if self.isIncrementing {
                    self.currentBpm += 2
                }
            }
        }
    }
    
    //IBActions
    @IBAction func decreaseButtonTapped(_ sender: Any) {
        currentBpm -= 1
        setSlider(forBpm: currentBpm)
    }
    
    @IBAction func increaseButtonTapped(_ sender: Any) {
        currentBpm += 1
        setSlider(forBpm: currentBpm)
    }
    

    @IBAction func sliderChanged(_ sender: UISlider) {
        let tempo = (sender.value * Float(maxTempo - minTempo)) + Float(minTempo)
        currentBpm = Int(tempo)
    }
    
    func setSlider(forBpm bpm: Int) {
        let value = Float(currentBpm - minTempo) / Float(maxTempo - minTempo)
        bpmSlider.setValue(value, animated: false)
    }
    
    var isPlaying = true
    var countIsClosed = true
    @IBOutlet var countClosedLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var countOpenLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var countWidthConstraint: NSLayoutConstraint!
    @IBOutlet var countTopConstraint: NSLayoutConstraint!
    var countOverlay: UIView?
    /*
    @objc func beatsViewTapped() {
        countIsClosed = !countIsClosed
        if countIsClosed {
            UIView.animate(withDuration: 0.3, animations: {
                self.countClosedLeadingConstraint.priority = .defaultHigh
                self.countWidthConstraint.priority = .defaultHigh
                self.countOpenLeadingConstraint.priority = .defaultLow
                self.countTopConstraint.constant = 2
                self.view.layoutIfNeeded()
                self.countOverlay?.removeFromSuperview()
                self.countOverlay = nil
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.countClosedLeadingConstraint.priority = .defaultLow
                self.countWidthConstraint.priority = .defaultLow
                self.countOpenLeadingConstraint.priority = .defaultHigh
                self.countTopConstraint.constant = -60
                self.view.layoutIfNeeded()
                
                let v = Bundle.main.loadNibNamed("CountView", owner: self, options: nil)?.first
                if let v = v as? UIView {
                    self.countOverlay = v
                    self.beatsView.addSubview(self.countOverlay!)
                    self.countOverlay!.frame = self.beatsView.bounds
                    for view in self.countOverlay!.subviews {
                        if let button = view as? UIButton {
                            button.layer.cornerRadius = (button.frame.width / 2)
                        }
                    }
                }
            })
        }
    }
 */
}
