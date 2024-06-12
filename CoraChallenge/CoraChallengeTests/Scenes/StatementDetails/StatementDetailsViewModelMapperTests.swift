import XCTest
@testable import CoraChallenge

final class StatementDetailsViewModelMapperTests: XCTestCase {
    
    private let dayIdentifyingStub = DayIdentifyingStub()
    private var sut: StatementDetailViewModelMapper!
    private let documentFormat = String(localized: "StatementDetails.DocumentFormat")
    private let agencyFormat = String(localized: "StatementDetails.BankAgencyFormat")
    private let accountInformationFormat = String(localized: "StatementDetails.AccountInformationFormat")
    private var dateFormatter = DateFormatter()

    override func setUpWithError() throws {
        let stubTimeZone = try XCTUnwrap(TimeZone(abbreviation: "UTC"))
        sut = StatementDetailViewModelMapper(
            calendar: dayIdentifyingStub,
            timeZone: stubTimeZone
        )
        dateFormatter.timeZone = stubTimeZone
    }
    
    func test_makeViewModel_givenStubResponseWithAmmoutAndDateTextAndDayIdentifierWillReturnTrueForToday_whenResponseIsPassed_itShouldReturnCorrectValue() throws {
        // Given
        let stubDateText = "2024-02-05T14:30:45Z"
        dateFormatter.dateFormat = String(localized: "Statement.Item.DateFormat")
        let stubDate = try XCTUnwrap(dateFormatter.date(from: stubDateText))
        let stubResponse: StatementDetailsResponse = .fixture(
            amount: 100,
            dateEvent: stubDateText,
            recipient: .fixture(agencyNumberDigit: nil), 
            sender: .fixture(agencyNumberDigit: nil)
        )
        
        dayIdentifyingStub.isDateInTodayValueToStub = true
        
        let readableDateTextFormat = String(localized: "StatementDetails.DateTextFormat")
        
        let dateText = String(localized: "TodayTitle") + "05/02/2024"
        
        let accountInfoText = String(
            format: accountInformationFormat,
            "",
            "",
            ""
        )
        
        let expectedResult: StatementDetailsModels.StatementDetailViewModel = .fixture(
            value: "R$ 1,00",
            dateText: dateText,
            senderViewModel: .fixture(accountInformation: accountInfoText),
            receiverViewModel: .fixture(accountInformation: accountInfoText)
        )
        
        
        // When
        let result = sut.makeViewModel(with: stubResponse)
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_makeViewModel_givenStubResponseWithAmmoutAndDateTextAndDayIdentifierWillReturnTrueForYesterday_whenResponseIsPassed_itShouldReturnCorrectValue() throws {
        // Given
        let stubDateText = "2024-02-05T14:30:45Z"
        dateFormatter.dateFormat = String(localized: "Statement.Item.DateFormat")
        let stubDate = try XCTUnwrap(dateFormatter.date(from: stubDateText))
        let stubResponse: StatementDetailsResponse = .fixture(
            amount: 100,
            dateEvent: stubDateText,
            recipient: .fixture(agencyNumberDigit: nil),
            sender: .fixture(agencyNumberDigit: nil)
        )
        
        dayIdentifyingStub.isDateInYesterdayValueToStub = true
        
        let readableDateTextFormat = String(localized: "StatementDetails.DateTextFormat")
        
        let dateText = String(localized: "YesterdayTitle") + "05/02/2024"
        
        let accountInfoText = String(
            format: accountInformationFormat,
            "",
            "",
            ""
        )
        
        let expectedResult: StatementDetailsModels.StatementDetailViewModel = .fixture(
            value: "R$ 1,00",
            dateText: dateText,
            senderViewModel: .fixture(accountInformation: accountInfoText),
            receiverViewModel: .fixture(accountInformation: accountInfoText)
        )
        
        
        // When
        let result = sut.makeViewModel(with: stubResponse)
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_makeViewModel_givenStubResponseWithAmmoutAndDateTextAndDayIdentifierWillReturnFalseForYesterdayAndToday_whenResponseIsPassed_itShouldReturnCorrectValue() throws {
        // Given
        let stubDateText = "2024-02-05T14:30:45Z"
        dateFormatter.dateFormat = String(localized: "Statement.Item.DateFormat")
        let stubDate = try XCTUnwrap(dateFormatter.date(from: stubDateText))
        let stubResponse: StatementDetailsResponse = .fixture(
            amount: 100,
            dateEvent: stubDateText,
            recipient: .fixture(agencyNumberDigit: nil), sender: .fixture(agencyNumberDigit: nil)
        )
        
        dayIdentifyingStub.isDateInTodayValueToStub = false
        dayIdentifyingStub.isDateInYesterdayValueToStub = false
        
        let readableDateTextFormat = String(localized: "StatementDetails.DateTextFormat")
        
        dateFormatter.dateFormat = String(localized: "StatementDetail.LeadingDateTextFormat")
        let dateTextLeading = dateFormatter.string(from: stubDate).capitalizedFirstCharacter
        let dateText = dateTextLeading + "05/02/2024"
        
    
        let accountInfoText = String(
            format: accountInformationFormat,
            "",
            "",
            ""
        )
        
        let expectedResult: StatementDetailsModels.StatementDetailViewModel = .fixture(
            value: "R$ 1,00",
            dateText: dateText,
            senderViewModel: .fixture(accountInformation: accountInfoText),
            receiverViewModel: .fixture(accountInformation: accountInfoText)
        )
        
        
        // When
        let result = sut.makeViewModel(with: stubResponse)
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    // MARK: - MakeActorViewModel tests
    func test_makeActorViewModel_givenStubResponseWithCPFDocumentAndAgencyNumberWithDigit_whenResponseIsPassed_itShouldReturnCorrectValue() {
        // Given
        let stubName = UUID().uuidString
        let stubBankName = UUID().uuidString
        let stubDocumentType = StatementDetailsModels.DocumentType.cpf.rawValue
        let stubDocumentNumber = "12345678910"
        let stubAccountNumber = "1234567"
        let stubAccountNumberDigit = "5"
        let stubAgencyNumber = "1234"
        let stubAgencyDigit = "2"
        let stubActor: StatementDetailsResponse.Actor = .fixture(
            bankName: stubBankName,
            documentNumber: stubDocumentNumber,
            documentType: stubDocumentType, 
            accountNumberDigit: stubAccountNumberDigit,
            agencyNumberDigit: stubAgencyDigit,
            agencyNumber: stubAgencyNumber,
            name: stubName,
            accountNumber: stubAccountNumber
        )
        
        let documentText = String(
            format: documentFormat,
            stubDocumentType,
            stubDocumentNumber.maskCPF
        )
        
        let agencyText = String(
            format: agencyFormat,
            stubAgencyNumber,
            stubAgencyDigit
        )
        
        let accountInformationTest = String(
            format: accountInformationFormat,
            agencyText,
            stubAccountNumber,
            stubAccountNumberDigit
        )
        
        let expectedResult: StatementDetailsModels.StatementDetailViewModel.ActorViewModel = .init(
            name: stubName,
            document: documentText,
            bankName: stubBankName,
            accountInformation: accountInformationTest
        )
        // When
        let result = sut.makeActorViewModel(for: stubActor)
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_makeActorViewModel_givenStubResponseWithCNPJDocumentAndAgencyNumberWithNilDigit_whenResponseIsPassed_itShouldReturnCorrectValue() {
        // Given
        let stubName = UUID().uuidString
        let stubBankName = UUID().uuidString
        let stubDocumentType = StatementDetailsModels.DocumentType.cnpj.rawValue
        let stubDocumentNumber = "99999999999999"
        let stubAccountNumber = "1234567"
        let stubAccountNumberDigit = "5"
        let stubAgencyNumber = "1234"
        let stubActor: StatementDetailsResponse.Actor = .fixture(
            bankName: stubBankName,
            documentNumber: stubDocumentNumber,
            documentType: stubDocumentType,
            accountNumberDigit: stubAccountNumberDigit,
            agencyNumberDigit: nil,
            agencyNumber: stubAgencyNumber,
            name: stubName,
            accountNumber: stubAccountNumber
        )
        
        let documentText = String(
            format: documentFormat,
            stubDocumentType,
            stubDocumentNumber.maskCNPJ
        )
        
        
        let accountInformationTest = String(
            format: accountInformationFormat,
            stubAgencyNumber,
            stubAccountNumber,
            stubAccountNumberDigit
        )
        
        let expectedResult: StatementDetailsModels.StatementDetailViewModel.ActorViewModel = .init(
            name: stubName,
            document: documentText,
            bankName: stubBankName,
            accountInformation: accountInformationTest
        )
        // When
        let result = sut.makeActorViewModel(for: stubActor)
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_makeActorViewModel_givenStubResponseWithInvalidDocumentAndAgencyNumberWithNilDigit_whenResponseIsPassed_itShouldReturnCorrectValue() {
        // Given
        let stubName = UUID().uuidString
        let stubBankName = UUID().uuidString
        let stubDocumentType = "asdasd"
        let stubDocumentNumber = "99999999999999"
        let stubAccountNumber = "1234567"
        let stubAccountNumberDigit = "5"
        let stubAgencyNumber = "1234"
        let stubActor: StatementDetailsResponse.Actor = .fixture(
            bankName: stubBankName,
            documentNumber: stubDocumentNumber,
            documentType: stubDocumentType,
            accountNumberDigit: stubAccountNumberDigit,
            agencyNumberDigit: nil,
            agencyNumber: stubAgencyNumber,
            name: stubName,
            accountNumber: stubAccountNumber
        )
        
        let accountInformationTest = String(
            format: accountInformationFormat,
            stubAgencyNumber,
            stubAccountNumber,
            stubAccountNumberDigit
        )
        
        let expectedResult: StatementDetailsModels.StatementDetailViewModel.ActorViewModel = .init(
            name: stubName,
            document: "",
            bankName: stubBankName,
            accountInformation: accountInformationTest
        )
        // When
        let result = sut.makeActorViewModel(for: stubActor)
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
}

extension StatementDetailsViewModelMapperTests {
    
    final class DayIdentifyingStub: DayIdentifying {
        
        private(set) var isDateInTodayParametersPassed = [Date]()
        var isDateInTodayValueToStub = false
        func isDateInToday(_ date: Date) -> Bool {
            isDateInTodayParametersPassed.append(date)
            return isDateInTodayValueToStub
        }
        
        private(set) var isDateInYesterdayParametersPassed = [Date]()
        var isDateInYesterdayValueToStub = false
        func isDateInYesterday(_ date: Date) -> Bool {
            isDateInYesterdayParametersPassed.append(date)
            return isDateInYesterdayValueToStub
        }
        
    }
    
}
