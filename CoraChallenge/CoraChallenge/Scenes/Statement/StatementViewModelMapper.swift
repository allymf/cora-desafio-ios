import Foundation

protocol StatementViewModelMapping {
    func makeViewModel(with decodable: StatementResponse) -> StatementModels.StatementViewModel
}

protocol DayIdentifying {
    func isDateInToday(_ date: Date) -> Bool
    func isDateInYesterday(_ date: Date) -> Bool
}

extension Calendar: DayIdentifying {}

final class StatementViewModelMapper: StatementViewModelMapping {
    
    private let locale = Locale(identifier: "pt-BR")
    private lazy var dateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.timeZone = timeZone
        return dateFormatter
    }()
    
    private lazy var numberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = locale
        numberFormatter.numberStyle = .currency
        return numberFormatter
    }()
    
    private let calendar: DayIdentifying
    private let timeZone: TimeZone
    
    private let sectionDateFormat = String(localized: "Statement.Section.DateFormat")
    
    private let sectionTitleLeadingDateFormat = String(localized: "Statement.Section.TitleLeadingDateFormat")
    private let sectionTitleTrailingDateFormat = String(localized: "Statement.Section.TitleTrailingDateFormat")
    private let titleFormatText = String(localized: "Statement.Section.TitleFormat")
    
    private let itemDateFormat = String(localized: "Statement.Item.DateFormat")
    private let itemHourFormat = String(localized: "Statement.Item.HourFormat")
    
    init(
        calendar: DayIdentifying = Calendar.current,
        timeZone: TimeZone = .current
    ) {
        self.calendar = calendar
        self.timeZone = timeZone
    }
    
    func makeViewModel(with decodable: StatementResponse) -> StatementModels.StatementViewModel {
        return .init(sections: makeSections(with: decodable.results))
    }
    
    func makeSections(with decodables: [StatementResponse.Section]?) -> [StatementModels.StatementViewModel.Section] {
        var sections = [StatementModels.StatementViewModel.Section]()
        guard let decodables else { return sections }
        
        for decodable in decodables {
            sections.append(makeSection(with: decodable))
        }
        
        return sections
    }
    
    func makeSection(with decodable: StatementResponse.Section) -> StatementModels.StatementViewModel.Section {
        dateFormatter.dateFormat = sectionDateFormat
        let dateText = decodable.date ?? ""
        let date = dateFormatter.date(from: dateText) ?? Date()
        
        let titleLeadingText = titleLeading(for: date)
        
        dateFormatter.dateFormat = sectionTitleTrailingDateFormat
        let titleTrailingText = dateFormatter.string(from: date).capitalized
        
        let title = String(
            format: titleFormatText,
            titleLeadingText,
            titleTrailingText
        )
        
        return .init(
            title: title,
            date: date,
            items: makeItems(with: decodable.items)
        )
    }
    
    func titleLeading(for date: Date) -> String {
        dateFormatter.dateFormat = String(localized: "Statement.Section.TitleLeadingShortDateFormat")
        guard !calendar.isDateInToday(date) else {
            return String(localized: "TodayTitle") + dateFormatter.string(from: date)
        }
        
        guard !calendar.isDateInYesterday(date) else {
            return String(localized: "YesterdayTitle") + dateFormatter.string(from: date)
        }
        
        dateFormatter.dateFormat = sectionTitleLeadingDateFormat
        return dateFormatter.string(from: date).capitalizedFirstCharacter
    }
    
    func makeItems(with decodables: [StatementResponse.Item]?) -> [StatementModels.StatementViewModel.Item] {
        var items = [StatementModels.StatementViewModel.Item]()
        guard let decodables else { return items }
        
        for decodable in decodables {
            items.append(makeItem(with: decodable))
        }
        
        return items
    }
    
    func makeItem(with decodable: StatementResponse.Item) -> StatementModels.StatementViewModel.Item {
        let currencyAmount: Double = decodable.amount?.currency ?? 0.0
        let formattedCurrencyAmount = numberFormatter.string(from: NSNumber(value: currencyAmount)) ?? String(localized: "CurrencyPlaceholder")
        
        let entry = StatementModels.StatementViewModel.Entry(rawValue: decodable.entry?.lowercased() ?? "") ?? .none
        let status = StatementModels.StatementViewModel.Status(rawValue: decodable.status?.lowercased() ?? "") ?? .none
        
        return .init(
            description: decodable.description ?? "",
            label: decodable.label ?? "",
            entry: entry,
            currencyAmount: formattedCurrencyAmount,
            name: decodable.name ?? "",
            hourText: formatItemHourText(from: decodable),
            status: status
        )
    }
    
    func formatItemHourText(from decodable: StatementResponse.Item) -> String {
        dateFormatter.dateFormat = itemDateFormat
        let date = dateFormatter.date(from: decodable.dateEvent ?? "") ?? Date()
        dateFormatter.dateFormat = itemHourFormat
        return dateFormatter.string(from: date)
    }
    
}
