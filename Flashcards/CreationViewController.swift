//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Sydney Hatcher on 3/6/20.
//  Copyright © 2020 Sydney Hatcher. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {

    
    var flashcardsController: ViewController!
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var optionOneTextField: UITextField!
    @IBOutlet weak var optionTwoTextField: UITextField!
    @IBOutlet weak var optionThreeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        
        let questionText = questionTextField.text
        let answerText = answerTextField.text
        let optionOneText = optionOneTextField.text
        let optionTwoText = optionTwoTextField.text
        let optionThreeText = optionThreeTextField.text
        
        flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, optionOne: optionOneText!, optionTwo: optionTwoText!, optionThree: optionThreeText!)
        
        
        dismiss(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
