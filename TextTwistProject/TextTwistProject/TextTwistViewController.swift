import UIKit

class TextTwistViewController: UIViewController {

    // MARK: -IBOutlets
    
    @IBOutlet var scrambledWordLabel: UILabel!
    @IBOutlet var lettersTextField: UITextField!
    @IBOutlet var nextWordButton: UIButton!
    
    // MARK: -Private Properties
    
    private var word = Word.getRandomWord() {
        didSet {
            scrambledWordLabel.text = word.scrambled
            remainingLetters = word.scrambled.map { $0 }
            resetBoard()
        }
    }
    
    private var remainingLetters: [Character]!
    
    // MARK: -Lifecycle Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        word = Word.getRandomWord()
        lettersTextField.delegate = self
    }
    
    // MARK: -IBActions
    
    @IBAction func showNextWord(_ sender: UIButton) {
        word = Word.getRandomWord()
    }
    
    // MARK: -Private Methods
        
    private func removeFirstInstance(of char: Character, fromLabel label: UILabel) {
        var text = label.text
        let firstIndexOfChar = text?.firstIndex { $0 == char }
        text?.remove(at: firstIndexOfChar!)
        label.text = text
    }
    
    private func handleGuessedWord() {
        view.backgroundColor = .green
        nextWordButton.isHidden = false
    }
    
    private func resetBoard() {
        nextWordButton.isHidden = true
        lettersTextField.text = ""
        view.backgroundColor = .white
    }
}

extension TextTwistViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Ensure that one character was added or characters were deleted
        guard string.count == 1 || string.count == 0 else {
            return false
        }

        // Handle deleting a character
        guard string != "" else {
            let oldString = textField.text ?? ""
            let deletedCharStartIndex = oldString.index(oldString.startIndex, offsetBy: range.lowerBound)
            let deletedCharEndIndex = oldString.index(oldString.startIndex, offsetBy: range.upperBound)
            let deletedChars = oldString[deletedCharStartIndex..<deletedCharEndIndex].map { $0 }
            
            remainingLetters += deletedChars
            scrambledWordLabel.text = (scrambledWordLabel.text ?? "") + deletedChars
            return true
        }
                        
        // Handle adding a character
        let char = Character(string)

        if remainingLetters.contains(char) {
            removeFirstInstance(of: char, fromLabel: scrambledWordLabel)
            remainingLetters.remove(at: remainingLetters.firstIndex { $0 == char }! )
            return true
        } else {
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == word.unscrambled {
            handleGuessedWord()
        }
        return true
    }
}

