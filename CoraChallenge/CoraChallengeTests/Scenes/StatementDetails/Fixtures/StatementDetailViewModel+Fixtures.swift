import Foundation
@testable import CoraChallenge

extension StatementDetailsModels.StatementDetailViewModel {
    static func fixture(
        title: String = "",
        value: String = "",
        dateText: String = "",
        senderViewModel: ActorViewModel = .fixture(),
        receiverViewModel: ActorViewModel = .fixture(),
        description: String = ""
    ) -> StatementDetailsModels.StatementDetailViewModel {
        return .init(
            title: title,
            value: value,
            dateText: dateText,
            senderViewModel: senderViewModel,
            receiverViewModel: receiverViewModel,
            description: description
        )
    }
}

extension StatementDetailsModels.StatementDetailViewModel.ActorViewModel {
    static func fixture(
        name: String = "",
        document: String = "",
        bankName: String = "",
        accountInformation: String = ""
    ) -> StatementDetailsModels.StatementDetailViewModel.ActorViewModel {
        return .init(
            name: name,
            document: document,
            bankName: bankName,
            accountInformation: accountInformation
        )
    }
}
