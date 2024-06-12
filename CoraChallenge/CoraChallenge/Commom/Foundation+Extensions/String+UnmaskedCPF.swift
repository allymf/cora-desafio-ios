import Foundation

extension String {
    var unmaskedCPF: String {
        var cpf = self
        cpf.removeAll { $0 == "." || $0 == "-" || $0 == " " }
        return cpf
    }
    
    var maskCPF: String {
        guard count == 11 else { return self }
        var maskedCPF = self
        let firstDotIndex = maskedCPF.index(
            maskedCPF.startIndex,
            offsetBy: 3
        )
        
        let secondDotIndex = maskedCPF.index(
            maskedCPF.startIndex,
            offsetBy: 7
        )
        
        let dashIndex = maskedCPF.index(
            maskedCPF.startIndex,
            offsetBy: 11
        )
        
        maskedCPF.insert(
            ".",
            at: firstDotIndex
        )
        maskedCPF.insert(
            ".",
            at: secondDotIndex
        )
        maskedCPF.insert(
            "-",
            at: dashIndex
        )
        
        return maskedCPF
    }
    
    var maskCNPJ: String {
        guard count == 14 else { return self }
        var maskedCNPJ = self
        let firstDotIndex = maskedCNPJ.index(
            maskedCNPJ.startIndex,
            offsetBy: 2
        )
        
        let secondDotIndex = maskedCNPJ.index(
            maskedCNPJ.startIndex,
            offsetBy: 6
        )
        
        let slashIndex = maskedCNPJ.index(
            maskedCNPJ.startIndex,
            offsetBy: 10
        )
        
        maskedCNPJ.insert(
            ".",
            at: firstDotIndex
        )
        maskedCNPJ.insert(
            ".",
            at: secondDotIndex
        )
        maskedCNPJ.insert(
            "/",
            at: slashIndex
        )
        
        let dashIndex = maskedCNPJ.index(
            maskedCNPJ.startIndex,
            offsetBy: 15
        )
        
        maskedCNPJ.insert(
            "-",
            at: dashIndex
        )
        
        return maskedCNPJ
    }
    
}
