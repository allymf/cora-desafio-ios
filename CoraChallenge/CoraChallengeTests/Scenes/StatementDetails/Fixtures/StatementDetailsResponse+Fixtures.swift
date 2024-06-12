import Foundation
@testable import CoraChallenge

extension StatementDetailsResponse {
    static func fixture(
        description: String? = "",
        label: String? = "",
        amount: Int? = 0,
        counterPartyName: String? = "",
        id: String? = "",
        dateEvent: String? = "",
        recipient: Actor? = .fixture(),
        sender: Actor? = .fixture(),
        status: String? = ""
    ) -> StatementDetailsResponse {
        return .init(
            description: description,
            label: label,
            amount: amount,
            counterPartyName: counterPartyName,
            id: id,
            dateEvent: dateEvent,
            recipient: recipient,
            sender: sender,
            status: status
        )
    }
}

extension StatementDetailsResponse.Actor {
    static func fixture(
        bankName: String? = "",
        bankNumber: String? = "",
        documentNumber: String? = "",
        documentType: String? = "",
        accountNumberDigit: String? = "",
        agencyNumberDigit: String? = "",
        agencyNumber: String? = "",
        name: String? = "",
        accountNumber: String? = ""
    ) -> StatementDetailsResponse.Actor {
        return .init(
            bankName: bankName,
            bankNumber: bankNumber,
            documentNumber: documentNumber,
            documentType: documentType,
            accountNumberDigit: accountNumberDigit,
            agencyNumberDigit: agencyNumberDigit,
            agencyNumber: agencyNumber,
            name: name,
            accountNumber: accountNumber
        )
    }
}
