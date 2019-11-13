//
//  ViewController.swift
//  TextTwistProject
//
//  Created by Benjamin Stone on 11/4/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit




class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scrambledWord: UILabel!
    
    @IBOutlet weak var enteredWord: UITextField!
    
    @IBOutlet weak var resetGame: UIButton!
    
    @IBOutlet weak var backgroundColor: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Word.getRandomWord().scrambled
        print(Word.getRandomWord().scrambled)
        
        
        enteredWord.delegate = self
//
//        scrambledWord.text =
//    }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if
//
//    }
//
//}

}
}
