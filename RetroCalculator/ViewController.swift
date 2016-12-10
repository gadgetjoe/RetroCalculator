//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Joe Mahaffey on 12/5/16.
//  Copyright © 2016 Joe Mahaffey. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
  
  @IBOutlet weak var outputLabel: UILabel!
  
  var btnSound: AVAudioPlayer!
  
  enum Operation: String {
    case Divide = "/"
    case Multiply = "*"
    case Subtract = "-"
    case Add = "+"
    case Empty = "Empty"
  }
  
  var currentOperation = Operation.Empty
  var runningNumber = ""
  var leftValStr = ""
  var rightValStr = ""
  var result = ""

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let path = Bundle.main.path(forResource: "btn", ofType: "wav")
    let soundURL = URL(fileURLWithPath: path!)
    
    do {
      
      try btnSound = AVAudioPlayer(contentsOf: soundURL)
      
    } catch let err as NSError {
      print(err.debugDescription)
    }
    
    outputLabel.text = "0"
    
    }
  
  @IBAction func numberPressed(sender: UIButton) {
    playSound()
    
    runningNumber += "\(sender.tag)"
    outputLabel.text = runningNumber
    
  }
  
  @IBAction func onDividePressed(_ sender: Any) {
    processOperation(operation: .Divide)
  }
  
  
  @IBAction func onMultiplyPressed(_ sender: Any) {
    processOperation(operation: .Multiply)
  }
  
  
  @IBAction func onSubtractPressed(_ sender: Any) {
    processOperation(operation: .Subtract)
  }
  
  
  @IBAction func onAddPressed(_ sender: Any) {
    processOperation(operation: .Add)
  }
  
  
  @IBAction func onEqualPressed(_ sender: Any) {
    processOperation(operation: currentOperation)
  }
  
  @IBAction func clearPressed(_ sender: Any) {
    
  runningNumber.removeAll()
    outputLabel.text = "0"
    playSound()
  }
  
  func playSound(){
    if btnSound.isPlaying {
      btnSound.stop()
    }
    
    btnSound.play()
    
  }
  
  func processOperation(operation: Operation) {
    playSound()
    if currentOperation != Operation.Empty {
      
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
        }
        
        leftValStr = result
        outputLabel.text = result
      }
      
      currentOperation = operation
      
    } else {
      leftValStr = runningNumber
      runningNumber = ""
      currentOperation = operation
  }
}

}
