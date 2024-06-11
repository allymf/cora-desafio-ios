import Foundation
@testable import CoraChallenge

extension StatementResponse {
    static func fixture(
        sections: [StatementResponse.Section]? = nil,
        itemsTotal: Int? = nil
    ) -> StatementResponse {
        return .init(
            results: sections,
            itemsTotal: itemsTotal
        )
    }
}

extension StatementResponse.Section {
    static func fixture(
        items: [StatementResponse.Item]? = nil,
        date: String? = nil
    ) -> StatementResponse.Section {
        return .init(
            items: items,
            date: date
        )
    }
}

extension StatementResponse.Item {
    static func fixture(
        id: String? = nil,
        description: String? = nil,
        label: String? = nil,
        entry: String? = nil,
        amount: Int? = nil,
        name: String? = nil,
        dateEvent: String? = nil,
        status: String? = nil
    ) -> StatementResponse.Item {
        return .init(
            id: id,
            description: description,
            label: label,
            entry: entry,
            amount: amount,
            name: name,
            dateEvent: dateEvent,
            status: status
        )
    }
}
