import Foundation
@testable import CoraChallenge

extension StatementModels.StatementViewModel {
    static func fixture(sections: [Section] = []) -> StatementModels.StatementViewModel {
        return .init(sections: sections)
    }
}

extension StatementModels.StatementViewModel.Section {
    static func fixture(
        title: String = "",
        date: Date = .init(),
        items: [StatementModels.StatementViewModel.Item] = []
    ) -> StatementModels.StatementViewModel.Section {
        return .init(
            title: title,
            date: date,
            items: items
        )
    }
}

extension StatementModels.StatementViewModel.Item {
    static func fixture(
        description: String = "",
        label: String = "",
        entry: StatementModels.StatementViewModel.Entry = .none,
        currencyAmount: String = "R$ 0,00",
        name: String = "",
        hourText: String = "",
        status: StatementModels.StatementViewModel.Status = .none
    ) -> StatementModels.StatementViewModel.Item {
        return .init(
            description: description,
            label: label,
            entry: entry,
            currencyAmount: currencyAmount,
            name: name,
            hourText: hourText,
            status: status
        )
    }
}
