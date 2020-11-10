//
//  ComplexCalculator.swift
//  GraphicComplexCalculator
//
//  Created by Alberto González Hernández on 10/11/20.
//

import Foundation

class ComplexNumber {

    // Computed properties

    public var polarNumber: (mod: Double, arg: Double) {
        get {
            return basePolarNumber
        }
        set(cartNumb) {
            basePolarNumber = (0, 0)
            let realNumber = cartNumb.mod
            let imagNumber = cartNumb.arg
            basePolarNumber.mod = sqrt((realNumber * realNumber) + (imagNumber * imagNumber))
            basePolarNumber.arg = atan2(imagNumber, realNumber)
        }
    }

    public var cartesianNumber: (real: Double, imag: Double) {
        get {
            return baseCartesianNumber
        }
        set(polarNumber) {
            baseCartesianNumber = (0, 0)
            let mod = polarNumber.real
            let arg = polarNumber.imag
            baseCartesianNumber.real = mod * cos(arg)
            baseCartesianNumber.imag = mod * sin(arg)
        }
    }

    private var basePolarNumber: (mod: Double, arg: Double) = (0, 0)
    private var baseCartesianNumber: (real: Double, imag: Double) = (0, 0)

    // Constructor

    public init() {
        print("Complex calculator module initated")
    }

    // Functions for basic operations

    public func addNumbers(complexA: (real: Double, imag: Double), complexB: (real: Double, imag: Double)) -> (cartesianRes: String, polarRes: String) {
        let cartesianRes = (complexA.real + complexB.real, complexA.imag + complexB.imag)
        polarNumber = cartesianRes
        let polarRes = polarNumber
        return (formatCartesianResult(result: cartesianRes), formatPolarResult(result: polarRes))
    }

    public func subNumbers(complexA: (real: Double, imag: Double), complexB: (real: Double, imag: Double)) -> (cartesianRes: String, polarRes: String) {
        let cartesianRes = (complexA.real - complexB.real, complexA.imag - complexB.imag)
        polarNumber = cartesianRes
        let polarRes = polarNumber
        return (formatCartesianResult(result: cartesianRes), formatPolarResult(result: polarRes))
    }

    public func multNumbers(complexA: (real: Double, imag: Double), complexB: (real: Double, imag: Double)) -> (cartesianRes: String, polarRes: String) {
        let cartesianRes = ((complexA.real * complexB.real) - (complexA.imag * complexB.imag), (complexA.real * complexB.imag) + (complexA.imag * complexB.real))
        polarNumber = cartesianRes
        let polarRes = polarNumber
        return (formatCartesianResult(result: cartesianRes), formatPolarResult(result: polarRes))
    }

    public func divNumbers(complexA: (mod: Double, arg: Double), complexB: (mod: Double, arg: Double)) -> (cartesianRes: String, polarRes: String) {
        let polarRes = ((complexA.mod / complexB.mod), (complexA.arg - complexB.arg))
        cartesianNumber = polarRes
        let cartesianRes = cartesianNumber
        return (formatCartesianResult(result: cartesianRes), formatPolarResult(result: polarRes))
    }
    
    // Format functions to display

    public func formatCartesianResult(result: (real: Double, imag: Double)) -> String {
        let operChar = (result.imag > 0) ? "+" : "-"
        return "\(Double(round(result.real * 100) / 100)) \(operChar) \(abs(Double(round(result.imag * 100) / 100)))i"
    }

    public func formatPolarResult(result: (mod: Double, arg: Double)) -> String {
        return "Mod: \(Double(round(result.mod * 100) / 100)), Arg: \(Double(round(result.arg * 100) / 100))"
    }
}
