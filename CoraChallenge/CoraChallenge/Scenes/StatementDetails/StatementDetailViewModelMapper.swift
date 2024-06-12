import Foundation

protocol StatementDetailViewModelMapping {
    func makeViewModel(with decodable: StatementDetailsResponse) -> StatementDetailsModels.StatementDetailViewModel
}

final class StatementDetailViewModelMapper: StatementDetailViewModelMapping {
    
    private let calendar: DayIdentifying
    private let locale = Locale(identifier: "pt-BR")
    private let timeZone: TimeZone
    
    private let titleLeadingDateFormat = String(localized: "StatementDetail.LeadingDateTextFormat")
    
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
    
    init(
        calendar: DayIdentifying = Calendar.current,
        timeZone: TimeZone = .current
    ) {
        self.calendar = calendar
        self.timeZone = timeZone
    }
    
    func makeViewModel(with decodable: StatementDetailsResponse) -> StatementDetailsModels.StatementDetailViewModel {
        
        let valueCurrency = decodable.amount?.currency ?? 0.0
        let value = numberFormatter.string(from: NSNumber(value: valueCurrency)) ?? String(localized: "CurrencyPlaceholder")
        dateFormatter.dateFormat = String(localized: "Statement.Item.DateFormat")
        let date = dateFormatter.date(from: decodable.dateEvent ?? "") ?? Date()
        
        return .init(
            title: decodable.label ?? "",
            value: value,
            dateText: makeReadableDateText(from: date),
            senderViewModel: makeActorViewModel(for: decodable.sender),
            receiverViewModel: makeActorViewModel(for: decodable.recipient),
            description: decodable.description ?? ""
        )
    }
    
    func makeReadableDateText(from date: Date) -> String {
        let leadingDateText = makeLeadingDateText(from: date)
        
        dateFormatter.dateFormat = String(localized: "StatementDetails.DateFormat")
        let trailingDateText = dateFormatter.string(from: date)
        
        return leadingDateText + " " + trailingDateText
    }
    
    func makeLeadingDateText(from date: Date) -> String {
        dateFormatter.dateFormat = String(localized: "Statement.Section.TitleLeadingShortDateFormat")
        guard !calendar.isDateInToday(date) else {
            return String(localized: "TodayTitle")
        }
        
        guard !calendar.isDateInYesterday(date) else {
            return String(localized: "YesterdayTitle")
        }
        
        dateFormatter.dateFormat = titleLeadingDateFormat
        return dateFormatter.string(from: date).capitalizedFirstCharacter
    }
    
    func makeActorViewModel(for actor: StatementDetailsResponse.Actor?) -> StatementDetailsModels.StatementDetailViewModel.ActorViewModel {
        return StatementDetailsModels.StatementDetailViewModel.ActorViewModel(
            name: actor?.name ?? "",
            document: makeDocumentText(for: actor),
            bankName: actor?.bankName ?? "",
            accountInformation: makeAccountInformation(for: actor)
        )
    }
    
    func makeDocumentText(for actor: StatementDetailsResponse.Actor?) -> String {
        let documentType: StatementDetailsModels.DocumentType = .init(rawValue: actor?.documentType?.lowercased() ?? "") ?? .none
        
        switch documentType {
        case .cpf:
            return documentType.rawValue.uppercased() + " " + (actor?.documentNumber?.maskCPF ?? "")
        case .cnpj:
            return documentType.rawValue.uppercased() + " " + (actor?.documentNumber?.maskCNPJ ?? "")
        default:
            return ""
        }
    }
    
    func makeAccountInformation(for actor: StatementDetailsResponse.Actor?) -> String {
        let accountInformationFormat = String(localized: "StatementDetails.AccountInformationFormat")
        
        var agencyCompleteNumber = actor?.agencyNumber ?? ""
        if let agencyNumberDigit = actor?.agencyNumberDigit {
            agencyCompleteNumber += "-" + agencyNumberDigit
        }
        
        return String(
            format: accountInformationFormat,
            agencyCompleteNumber,
            actor?.accountNumber ?? "",
            actor?.accountNumberDigit ?? ""
        )
    }
    
}
