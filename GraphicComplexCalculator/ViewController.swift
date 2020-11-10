//
//  ViewController.swift
//  GraphicComplexCalculator
//
//  Created by Alberto González Hernández on 08/11/20.
//

import UIKit

enum Operation {
    case Add
    case Subtract
    case Multiply
    case Divide
}

class ViewController: UIViewController {
    
    @IBOutlet weak var firstComplexRealTextField: UITextField!
    @IBOutlet weak var firstComplexImagTextField: UITextField!
    @IBOutlet weak var secondComplexRealTextField: UITextField!
    @IBOutlet weak var secondComplexImagTextField: UITextField!
    @IBOutlet weak var firstBtnsContainer: UIStackView!
    @IBOutlet weak var secondBtnsContainer: UIStackView!
    @IBOutlet weak var formLegendContainer: UIStackView!
    @IBOutlet weak var cartesianResultLabel: UILabel!
    @IBOutlet weak var polarResultLabel: UILabel!
    @IBOutlet weak var operationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // Hide keyboard functionality
        firstComplexRealTextField.delegate = self
        firstComplexImagTextField.delegate = self
        secondComplexRealTextField.delegate = self
        secondComplexImagTextField.delegate = self
        self.hideKeyboardWhenTappedAround()

        // Init buttons hide
        changeButtonsVisibility(hideButtons: true)
    }
    
    @IBAction func addNumbers(_ sender: Any) {
        performOperation(operation: .Add)
    }
    @IBAction func subNumbers(_ sender: Any) {
        performOperation(operation: .Subtract)
    }
    @IBAction func multNumbers(_ sender: Any) {
        performOperation(operation: .Multiply)
    }
    @IBAction func divNumbers(_ sender: Any) {
        performOperation(operation: .Divide)
    }
    @IBAction func changeFirstComplexRealInput(_ sender: Any) {
        checkInputsCompletion()
    }
    @IBAction func changeFirstComplexImagInput(_ sender: Any) {
        checkInputsCompletion()
    }
    @IBAction func changeSecondComplexRealInput(_ sender: Any) {
        checkInputsCompletion()
    }
    @IBAction func changeSecondComplexImagInput(_ sender: Any) {
        checkInputsCompletion()
    }
    
    private func checkInputsCompletion() {
        if areAllFieldsCorrectAndCompleted() {
            changeButtonsVisibility(hideButtons: false)
        } else {
            changeButtonsVisibility(hideButtons: true)
        }
    }
    
    private func areAllFieldsCorrectAndCompleted() -> Bool {
        let areInputsComplete = firstComplexRealTextField.hasText && firstComplexImagTextField.hasText && secondComplexRealTextField.hasText && secondComplexImagTextField.hasText
        var areInputsCorrect = false
        if (areInputsComplete) {
            areInputsCorrect = firstComplexRealTextField.text!.isDouble && firstComplexImagTextField.text!.isDouble && secondComplexRealTextField.text!.isDouble && secondComplexImagTextField.text!.isDouble
        }
        return areInputsComplete && areInputsCorrect
    }
    
    private func changeButtonsVisibility(hideButtons: Bool) {
        firstBtnsContainer.isHidden = hideButtons
        secondBtnsContainer.isHidden = hideButtons
        formLegendContainer.isHidden = !hideButtons
    }
    
    private func performOperation(operation: Operation) {
        let complexRealA :Double? = Double(firstComplexRealTextField.text!)
        let complexImagA :Double? = Double(firstComplexImagTextField.text!)
        let complexRealB :Double? = Double(secondComplexRealTextField.text!)
        let complexImagB :Double? = Double(secondComplexImagTextField.text!)

        if complexRealA != nil && complexImagA != nil && complexRealB != nil && complexImagB != nil
        {
            let cartesianNumberA: (Double, Double) = (complexRealA!, complexImagA!)
            let cartesianNumberB: (Double, Double) = (complexRealB!, complexImagB!)
            setOperationResult(cartesianNumberA: cartesianNumberA, cartesianNumberB: cartesianNumberB, operation: operation)
        }
    }

    private func setOperationResult(cartesianNumberA: (Double, Double), cartesianNumberB: (Double, Double), operation: Operation) {
        let complexNumber = ComplexNumber()
        var result: (cartesianRes: String, polarRes: String) = ("", "")
        var operChar: String = ""
        switch operation {
            case .Add:
                operChar = "+"
                result = complexNumber.addNumbers(complexA: cartesianNumberA, complexB: cartesianNumberB)
            case .Subtract:
                operChar = "-"
                result = complexNumber.subNumbers(complexA: cartesianNumberA, complexB: cartesianNumberB)
            case .Multiply:
                operChar = "x"
                result = complexNumber.multNumbers(complexA: cartesianNumberA, complexB: cartesianNumberB)
            case .Divide:
                operChar = "÷"
                complexNumber.polarNumber = cartesianNumberA
                let polarNumberA = complexNumber.polarNumber
                complexNumber.polarNumber = cartesianNumberB
                let polarNumberB = complexNumber.polarNumber
                result = complexNumber.divNumbers(complexA: polarNumberA, complexB: polarNumberB)
        }
        let complexAFormatted: String = complexNumber.formatCartesianResult(result: cartesianNumberA)
        let complexBFormatted: String = complexNumber.formatCartesianResult(result: cartesianNumberB)

        operationLabel.text = "(" + complexAFormatted + ") " + operChar + " (" + complexBFormatted + ")"
        cartesianResultLabel.text = result.cartesianRes
        polarResultLabel.text = result.polarRes
    }
    
}

// Aditional functionality for keyboard hide

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}

// Extra string functionality to check double values

extension String {
    var isDouble: Bool { return Double(self) != nil }
}

