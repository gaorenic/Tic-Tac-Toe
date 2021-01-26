//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Student on 1/12/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var gridLabel0: Gridlabel!
    @IBOutlet weak var gridLabel1: Gridlabel!
    @IBOutlet weak var gridLabel2: Gridlabel!
    @IBOutlet weak var gridLabel3: Gridlabel!
    @IBOutlet weak var gridLabel4: Gridlabel!
    @IBOutlet weak var gridLabel5: Gridlabel!
    @IBOutlet weak var gridLabel6: Gridlabel!
    @IBOutlet weak var gridLabel7: Gridlabel!
    @IBOutlet weak var gridLabel8: Gridlabel!
    var labelsArray = [Gridlabel]()
    var xTurn = true
    var gameOver = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelsArray.append(gridLabel0)
        labelsArray.append(gridLabel1)
        labelsArray.append(gridLabel2)
        labelsArray.append(gridLabel3)
        labelsArray.append(gridLabel4)
        labelsArray.append(gridLabel5)
        labelsArray.append(gridLabel6)
        labelsArray.append(gridLabel7)
        labelsArray.append(gridLabel8)
        
    }
    
    @IBAction func ontappedGridLabel(_ sender: UITapGestureRecognizer) {
        if gameOver {
            return
        }
        var canPlay = false
        for label in labelsArray{
            if label.frame.contains(sender.location(in: backgroundView)) {
                if label.canTap {
                    if xTurn {
                        label.text = "X"
                    }
                    else {
                        label.text = "O"
                    }
                    xTurn = !xTurn
                    label.canTap = false
                    checkForWinner()
                }
            }
            if label.canTap {
                canPlay = true
            }
        }
        if !canPlay && !gameOver {
            displayWinningMessage(message: "Cat's game!")
        }
    }
    
    func checkForWinner() {
        // Check the top row
        checkLine(a: 0, b: 1, c: 2)
        // Check the middle row
        checkLine(a: 3, b: 4, c: 5)
        // Check the bottom row
        checkLine(a: 6, b: 7, c: 8)
        // Check the left collum
        checkLine(a: 0, b: 3, c: 6)
        // Check the middle collum
        checkLine(a: 1, b: 4, c: 7)
        // Check the right collum
        checkLine(a: 2, b: 5, c: 8)
        // Check the upper left to lower right diagonal line
        checkLine(a: 0, b: 4, c: 8)
        // Check the upper right to lower left diagonal line
        checkLine(a: 2, b: 4, c: 6)
    }
    
    func checkLine(a: Int, b: Int, c: Int) {
        if (labelsArray[a].text != "" &&
                labelsArray[a].text == labelsArray[b].text &&
                labelsArray[b].text == labelsArray[c].text) {
            displayWinningMessage(message: "\(labelsArray[a].text!) is the winner")
        }
    }
    
    func displayWinningMessage(message:String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Reset", style: .default) {
            (action) -> Void in self.resetGame()
        }
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
        gameOver = true
    }
    
    func resetGame() {
        for label in labelsArray {
            label.text = ""
            label.canTap = true
        }
        xTurn = true
        gameOver = false
    }
}

