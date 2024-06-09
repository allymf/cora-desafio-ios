import Foundation

extension String {
    var unmaskedCPF: String {
        var cpf = self
        cpf.removeAll { $0 == "." || $0 == "-" || $0 == " " }
        return cpf
    }
}

protocol CPFValidating {
    func validate(cpf: String) -> Bool
}

struct CPFValidator: CPFValidating {
    func validate(cpf: String) -> Bool {
        var allDigits = extractCPFDigits(from: cpf)
        
        guard allDigits.count == 11 else {
            return false
        }
        
        guard validateForRepeatingNumbers(allDigits: allDigits) else {
            return false
        }
        
        let identificationDigits = Array(allDigits.prefix(9))
        
        guard let lastVerifyingDigit = allDigits.popLast(),
              let firstVerifyingDigit = allDigits.popLast() else {
            return false
        }
        
        guard validate(
            firstVerifyingDigit: firstVerifyingDigit,
            identificationDigits: identificationDigits
        ) else {
            return false
        }
        
        let leadingDigits = identificationDigits + [firstVerifyingDigit]
        
        return validate(
            lastVerifyingDigit: lastVerifyingDigit,
            leadingDigits: leadingDigits
        )
    }
    
    private func extractCPFDigits(from string: String) -> [Int] {
        return Array(string.unmaskedCPF).compactMap { $0.wholeNumberValue }
    }
    
    private func validateForRepeatingNumbers(allDigits: [Int]) -> Bool {
        return !allDigits.dropFirst().allSatisfy { $0 == allDigits.first }
    }
    
    private func validate(
        firstVerifyingDigit: Int,
        identificationDigits: [Int]
    ) -> Bool {
        let multipliers = Array(2...10).sorted(by: >)
        
        return validateVerifyingDigit(
            firstVerifyingDigit,
            multipliers: multipliers,
            leadingDigits: identificationDigits
        )
    }
    
    private func validate(
        lastVerifyingDigit: Int,
        leadingDigits: [Int]
    ) -> Bool {
        let multipliers = Array(2...11).sorted(by: >)
        
        return validateVerifyingDigit(
            lastVerifyingDigit,
            multipliers: multipliers,
            leadingDigits: leadingDigits
        )
    }
    
    private func validateVerifyingDigit(
        _ verifyingDigit: Int,
        multipliers: [Int],
        leadingDigits: [Int]
    ) -> Bool {
        var validationSum = 0
        for (digit, multiplier) in zip(leadingDigits, multipliers) {
            validationSum += digit * multiplier
        }
        let remainder = (validationSum * 10) % 11
        let remainderLastDigit = remainder >= 10 ? remainder % 10 : remainder
        return remainderLastDigit == verifyingDigit
    }
    
}
