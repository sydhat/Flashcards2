//
//  ViewController.swift
//  Flashcards
//
//  Created by Sydney Hatcher on 2/21/20.
//  Copyright © 2020 Sydney Hatcher. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
    var optionOne: String
    var optionTwo: String
    var optionThree: String
    
}

class ViewController: UIViewController {

    @IBOutlet weak var optionOne: UIButton!
    @IBOutlet weak var optionTwo: UIButton!
    @IBOutlet weak var optionThree: UIButton!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var cardStyle: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    var flashcards = [Flashcard]()
    var currentIndex = 0;
    
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
        readSavedFlashcards()
        if (flashcards.count == 0) {
            updateFlashcard(question: "What is the capital of Maryland", answer: "Annapolis", optionOne: "Baltimore", optionTwo: "Annapolis", optionThree: "Ocean City")
        } else {
            updateLabels()
            updateOptions()
            updateNextPrevButtons()
        }
    }

    @IBAction func didTapOnFlashcard(_ sender: Any){
        flipFlashcard()
    }

   func flipFlashcard() {
    
    UIView.transition(with: cardStyle, duration: 0.3, options: .transitionFlipFromRight, animations: {
        if (self.frontLabel.isHidden) {
            self.frontLabel.isHidden = false;
        } else {
            self.frontLabel.isHidden = true;
        }
    })
       
    }
    
    func animateCardOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.cardStyle.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        }, completion: { finished in
            self.updateLabels()
            self.animateCardIn()
        })
    }
   
    func animateCardIn() {
        cardStyle.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        UIView.animate(withDuration: 0.3) {
            self.cardStyle.transform = CGAffineTransform.identity
        }
        
    }
    
    func updateFlashcard(question: String, answer: String, optionOne: String, optionTwo: String, optionThree: String) {
        let flashcard = Flashcard(question: question, answer: answer, optionOne: optionOne, optionTwo: optionTwo, optionThree: optionThree)
        flashcards.append(flashcard)
        print("Added new flashcard")
        print("We now have \(flashcards.count) flashcards")
        currentIndex = flashcards.count - 1
        print("Our current index is \(currentIndex)")
        updateNextPrevButtons()
        updateLabels()
        updateOptions()
        saveAllFlashcardsToDisk()
    }
    
    func updateNextPrevButtons() {
        if (currentIndex == flashcards.count - 1) {
            nextButton.isEnabled = false;
        } else {
            nextButton.isEnabled = true;
        }
        
        if (currentIndex == 0) {
            prevButton.isEnabled = false;
        } else {
            prevButton.isEnabled = true;
        }
        
    }
   func updateOptions() {
   
        let currentFlashcard = flashcards[currentIndex]
        optionOne.setTitle(currentFlashcard.optionOne, for: .normal)
        optionTwo.setTitle(currentFlashcard.optionTwo, for: .normal)
        optionThree.setTitle(currentFlashcard.optionThree, for: .normal)
        optionOne.isHidden = false
        optionThree.isHidden = false;
       
    }
    
    func updateLabels() {
        
        let currentFlashcard = flashcards[currentIndex]
        
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
        frontLabel.isHidden = false;
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
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
       // updateLabels()
        updateOptions()
        updateNextPrevButtons()
        animateCardOut()
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        //updateLabels()
        updateOptions()
        updateNextPrevButtons()
        animateCardOut()
    }
    
    func saveAllFlashcardsToDisk() {
       
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer, "optionOne": card.optionOne, "optionTwo": card.optionTwo, "optionThree": card.optionThree]
        }
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        print("Flashcards saved to UserDefaults")
        
    }
    
    func readSavedFlashcards() {
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]  {
            let savedCards = dictionaryArray.map { (dictionary) -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, optionOne: dictionary["optionOne"]!, optionTwo: dictionary["optionTwo"]!, optionThree: dictionary["optionThree"]!)
            }
            flashcards.append(contentsOf:savedCards)
        }
    }

}

