//
//  ViewController.swift
//  Calculator-Retro Style
//
//  Created by Sharon's Mac on 6/16/16.
//  Copyright © 2016 Sharon's Mac. All rights reserved.
//


import UIKit

import AVFoundation

class ViewController: UIViewController {
    

    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    

    @IBOutlet weak var displayLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
        
    
    @IBAction func numberPressed(btn: UIButton!) {
//        playSound()
        
        runningNumber += "\(btn.tag)"
        displayLbl.text = runningNumber
        
    }


    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    
    
    func processOperation(op: Operation) {
        //playSound()
            
            if currentOperation != Operation.Empty {
                //Run some math
                
                // A user selected an operatator (+ - * / =), but then selected another operator without first entering a number
                if runningNumber != "" {
                    rightValStr = runningNumber
                    runningNumber = ""
            
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
//                } else if currentOperation == Operation.Clear {
//                    leftValStr = 0
//                    rightValStr = 0
//                    result = "(\Double(leftValStr)! + Double(rightValStr)!)*0"
//                    runningNumber = ""
//                    currentOperation = op
                }
                
                leftValStr = result
                displayLbl.text = result
            }
                    
                currentOperation = op
                
        } else {
                //This is the first time an operator has been pressed
                leftValStr = runningNumber
                runningNumber = ""
                currentOperation = op
            }
        
    }
    func playSound() {
        if btnSound.playing {
        btnSound.stop()
        }
            
        btnSound.play()
    
    

    func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


  }

}