//
//  ViewController.swift
//  Flashcards
//
//  Created by Sydney Hatcher on 2/21/20.
//  Copyright © 2020 Sydney Hatcher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var optionOne: UIButton!
    @IBOutlet weak var optionTwo: UIButton!
    @IBOutlet weak var optionThree: UIButton!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var cardStyle: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        cardStyle.layer.cornerRadius = 20.0;
        backLabel.layer.cornerRadius = 20.0;
        frontLabel.layer.cornerRadius = 20.0;
        optionOne.layer.cornerRadius = 20.0;
        optionTwo.layer.cornerRadius = 20.0;
        optionThree.layer.cornerRadius = 20.0;
        optionOne.layer.borderWidth = 3.0;
        optionOne.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        optionTwo.layer.borderWidth = 3.0;
        optionTwo.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        optionThree.layer.borderWidth = 3.0;
        optionThree.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        backLabel.clipsToBounds = true;
        frontLabel.clipsToBounds = true;
        cardStyle.layer.shadowRadius = 15.0;
        cardStyle.layer.shadowOpacity = 0.2;
      
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        
        if (frontLabel.isHidden == false){
                 frontLabel.isHidden = false;
                 backLabel.isHidden = true;
             } else {
                 frontLabel.isHidden = true;
                 backLabel.isHidden = false;
        }
        
    }
    
    func updateFlashcard(question: String, answer: String) {
        frontLabel.text = question
        backLabel.text = answer
    }
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        optionOne.isHidden = true;
    }
    
 
   
    @IBAction func didTapOptionTwo(_ sender: Any) {
        frontLabel.isHidden = true;
        backLabel.isHidden = false;
    }
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        optionThree.isHidden = true;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
    }
}

