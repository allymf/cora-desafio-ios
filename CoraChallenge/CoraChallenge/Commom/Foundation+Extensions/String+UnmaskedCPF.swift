import Foundation

extension String {
    var unmaskedCPF: String {
        var cpf = self
        cpf.removeAll { $0 == "." || $0 == "-" || $0 == " " }
        return cpf
    }
}
