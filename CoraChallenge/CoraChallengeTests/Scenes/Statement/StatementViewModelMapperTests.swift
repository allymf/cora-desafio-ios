import XCTest
@testable import CoraChallenge

final class StatementViewModelMapperTests: XCTestCase {

    private let dayIdentifyingStub = DayIdentifyingStub()
    private var dateFormatter = DateFormatter()
    private var sut: StatementViewModelMapper!
    
    override func setUpWithError() throws {
        let timeZoneStub = try XCTUnwrap(TimeZone(abbreviation: "UTC"))
    
        sut = StatementViewModelMapper(
            calendar: dayIdentifyingStub,
            timeZone: timeZoneStub
        )
        dateFormatter.timeZone = timeZoneStub
    }
    
    // MARK: - MakeViewModel tests
    func test_makeViewModel_givenStubResponse_whenResponseIsPassed_itShouldReturnCorrectViewModel() {
        // Given
        let stubResponse: StatementResponse = .fixture(sections: [])
        let expectedResult: StatementModels.StatementViewModel = .fixture()
        
        // When
        let result = sut.makeViewModel(with: stubResponse)
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    // MARK: - MakeSections tests
    func test_makeSections_givenDecodableSectionArray_whenArrayIsPassedToMethod_itShouldReturnCorrectViewModel() throws {
        // Given
        dateFormatter.dateFormat = String(localized: "Statement.Section.DateFormat")
        let stubDateText = "2024-06-11"
        let expectedDate = try XCTUnwrap(dateFormatter.date(from: stubDateText))
        
        let stubSections: [StatementResponse.Section] = [
            .fixture(
                items: [],
                date: stubDateText
            ),
            .fixture(
                items: [],
                date: stubDateText
            )
        ]
        
        let expectedResult: [StatementModels.StatementViewModel.Section] = [
            .fixture(
                title: "Terça-feira - 11 de Junho",
                date: expectedDate
            ),
            .fixture(
                title: "Terça-feira - 11 de Junho",
                date: expectedDate
            )
        ]
        
        // When
        let result = sut.makeSections(with: stubSections)
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_makeSections_givenEmptyDecodableSectionArray_whenArrayIsPassedToMethod_itShouldReturnEmptyArray() {
        // Given
        let stubSections = [StatementResponse.Section]()
        
        // When
        let result = sut.makeSections(with: stubSections)
        
        // Then
        XCTAssertTrue(result.isEmpty)
    }

    // MARK: - MakeSection tests
    func test_makeSection_givenDecodableWithDateAndCalendarReturnsTodayTrue_whenDecodableIsPassedToMethod_itShouldReturnViewModelWithCorrectTitle() throws {
        // Given
        dateFormatter.dateFormat = String(localized: "Statement.Section.DateFormat")
        let stubTodayDateText = dateFormatter.string(from: Date())
        let expectedDate = try XCTUnwrap(dateFormatter.date(from: stubTodayDateText))
        
        let stubSection: StatementResponse.Section = .fixture(date: stubTodayDateText)
        
        dayIdentifyingStub.isDateInTodayValueToReturn = true
        
        let titleLeadingDateFormat = String(localized: "Statement.Section.TitleLeadingShortDateFormat")
        
        dateFormatter.dateFormat = titleLeadingDateFormat
        let expectedLeadingTitle = String(localized: "TodayTitle") + dateFormatter.string(from: expectedDate)
        
        dateFormatter.dateFormat = String(localized: "Statement.Section.TitleTrailingDateFormat")
        
        let expectedResultTitle = String(
            format: String(localized: "Statement.Section.TitleFormat"),
            expectedLeadingTitle,
            dateFormatter.string(from: expectedDate).capitalized
        )
        
        let expectedResult: StatementModels.StatementViewModel.Section = .fixture(title: expectedResultTitle, date: expectedDate)
        
        // When
        let result = sut.makeSection(with: stubSection)
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_makeSection_givenDecodableWithDateAndCalendarReturnsYesterdayTrue_whenDecodableIsPassedToMethod_itShouldReturnViewModelWithCorrectTitle() throws {
        // Given
        dateFormatter.dateFormat = String(localized: "Statement.Section.DateFormat")
        let stubYesterdayDateText = dateFormatter.string(from: Date())
        let expectedDate = try XCTUnwrap(dateFormatter.date(from: stubYesterdayDateText))
        
        let stubSection: StatementResponse.Section = .fixture(date: stubYesterdayDateText)
        
        dayIdentifyingStub.isDateInYesterdayValueToReturn = true
        
        let titleLeadingDateFormat = String(localized: "Statement.Section.TitleLeadingShortDateFormat")
        
        dateFormatter.dateFormat = titleLeadingDateFormat
        let expectedLeadingTitle = String(localized: "YesterdayTitle") + dateFormatter.string(from: expectedDate)
        
        dateFormatter.dateFormat = String(localized: "Statement.Section.TitleTrailingDateFormat")
        
        let expectedResultTitle = String(
            format: String(localized: "Statement.Section.TitleFormat"),
            expectedLeadingTitle,
            dateFormatter.string(from: expectedDate).capitalized
        )
        
        let expectedResult: StatementModels.StatementViewModel.Section = .fixture(title: expectedResultTitle, date: expectedDate)
        
        // When
        let result = sut.makeSection(with: stubSection)
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_makeSection_givenDecodableWithDateAndCalendarReturnsFalseToTodayAndYesterday_whenDecodableIsPassedToMethod_itShouldReturnViewModelWithCorrectTitle() throws {
        // Given
        dateFormatter.dateFormat = String(localized: "Statement.Section.DateFormat")
        let stubTodayDateText = "2023-10-10"
        let expectedDate = try XCTUnwrap(dateFormatter.date(from: stubTodayDateText))
        
        let stubSection: StatementResponse.Section = .fixture(date: stubTodayDateText)
        
        dayIdentifyingStub.isDateInTodayValueToReturn = false
        dayIdentifyingStub.isDateInYesterdayValueToReturn = false
        
        let titleLeadingDateFormat = String(localized: "Statement.Section.TitleLeadingDateFormat")
        
        dateFormatter.dateFormat = titleLeadingDateFormat
        let expectedLeadingTitle = dateFormatter.string(from: expectedDate).capitalizedFirstCharacter
        
        dateFormatter.dateFormat = String(localized: "Statement.Section.TitleTrailingDateFormat")
        
        let expectedResultTitle = String(
            format: String(localized: "Statement.Section.TitleFormat"),
            expectedLeadingTitle,
            dateFormatter.string(from: expectedDate).capitalized
        )
        
        let expectedResult: StatementModels.StatementViewModel.Section = .fixture(title: expectedResultTitle, date: expectedDate)
        
        // When
        let result = sut.makeSection(with: stubSection)
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    // MARK: - MakeItems tests
    func test_makeItems_givenDecodableItems_whenItemsArePassedToMethod_itShouldReturnViewModelArray() {
        // Given
        let stubDateText = "2023-10-10T18:10:21Z"
        let expectedHourText = "18:10"
        let stubFirstId = UUID().uuidString
        let stubSecondId = UUID().uuidString
        let stubItems: [StatementResponse.Item] = [
            .fixture(
                name: stubFirstId,
                dateEvent: stubDateText
            ),
            .fixture(
                name: stubSecondId,
                dateEvent: stubDateText
            )
        ]
        
        let expectedResult: [StatementModels.StatementViewModel.Item] = [
            .fixture(
                currencyAmount: "R$ 0,00",
                name: stubFirstId,
                hourText: expectedHourText
            ),
            .fixture(
                currencyAmount: "R$ 0,00",
                name: stubSecondId,
                hourText: expectedHourText
            )
        ]
        
        dateFormatter.dateFormat = String(localized: "Statement.Item.DateFormat")
        
        // When
        let result = sut.makeItems(with: stubItems)
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_makeItems_givenEmptyDecodableItemsArray_whenEmptyArrayIsPassedToMethod_itShouldReturnEmptyViewModelArray() {
        // Given
        let stubItems = [StatementResponse.Item]()
        
        // When
        let result = sut.makeItems(with: stubItems)
        
        // Then
        XCTAssertTrue(result.isEmpty)
    }
    
    // MARK: - MakeItem tests
    
    func test_makeItem_givenItemWithAmountAndDateAndDebitEntryAndCompletedStatus_whenDecodableItemIsPassed_itShouldReturnCorrectViewModel() {
        // Given
        let stubDescription = UUID().uuidString
        let stubLabel = UUID().uuidString
        let stubName = UUID().uuidString
        
        let stubItem: StatementResponse.Item = .fixture(
            description: stubDescription,
            label: stubLabel,
            entry: "DEBIT",
            amount: 100,
            name: stubName,
            dateEvent: "2023-10-10T18:10:21Z",
            status: "COMPLETED"
        )
        
        let expectedResult: StatementModels.StatementViewModel.Item = .fixture(
            description: stubDescription,
            label: stubLabel,
            entry: .debit,
            currencyAmount: "R$ 1,00",
            name: stubName,
            hourText: "18:10",
            status: .completed
        )
        
        dateFormatter.dateFormat = String(localized: "Statement.Item.DateFormat")
        
        // When
        let result = sut.makeItem(with: stubItem)
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }

    func test_makeItem_givenItemWithAmountAndDateAndCreditEntryAndCompletedStatus_whenDecodableItemIsPassed_itShouldReturnCorrectViewModel() {
        // Given
        let stubDescription = UUID().uuidString
        let stubLabel = UUID().uuidString
        let stubName = UUID().uuidString
        
        let stubItem: StatementResponse.Item = .fixture(
            description: stubDescription,
            label: stubLabel,
            entry: "CREDIT",
            amount: 123456,
            name: stubName,
            dateEvent: "2023-10-10T20:13:21Z",
            status: "COMPLETED"
        )
        
        let expectedResult: StatementModels.StatementViewModel.Item = .fixture(
            description: stubDescription,
            label: stubLabel,
            entry: .credit,
            currencyAmount: "R$ 1.234,56",
            name: stubName,
            hourText: "20:13",
            status: .completed
        )
        
        dateFormatter.dateFormat = String(localized: "Statement.Item.DateFormat")
        
        // When
        let result = sut.makeItem(with: stubItem)
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    
    func test_makeItem_givenItemWithAmountAndDateAndInvalidEntryAndInvalidStatus_whenDecodableItemIsPassed_itShouldReturnCorrectViewModel() {
        // Given
        let stubDescription = UUID().uuidString
        let stubLabel = UUID().uuidString
        let stubName = UUID().uuidString
        
        let stubItem: StatementResponse.Item = .fixture(
            description: stubDescription,
            label: stubLabel,
            entry: "",
            amount: 123456,
            name: stubName,
            dateEvent: "2023-10-10T20:13:21Z",
            status: ""
        )
        
        let expectedResult: StatementModels.StatementViewModel.Item = .fixture(
            description: stubDescription,
            label: stubLabel,
            entry: .none,
            currencyAmount: "R$ 1.234,56",
            name: stubName,
            hourText: "20:13",
            status: .none
        )
        
        dateFormatter.dateFormat = String(localized: "Statement.Item.DateFormat")
        
        // When
        let result = sut.makeItem(with: stubItem)
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    
}

// MARK: - Test doubles
extension StatementViewModelMapperTests {
    
    final class DayIdentifyingStub: DayIdentifying {
        
        private(set) var isDateInTodayParametersPassed = [Date]()
        var isDateInTodayValueToReturn = false
        func isDateInToday(_ date: Date) -> Bool {
            isDateInTodayParametersPassed.append(date)
            return isDateInTodayValueToReturn
        }
        
        private(set) var isDateInYesterdayParametersPassed = [Date]()
        var isDateInYesterdayValueToReturn = false
        func isDateInYesterday(_ date: Date) -> Bool {
            isDateInYesterdayParametersPassed.append(date)
            return isDateInYesterdayValueToReturn
        }
        
        
    }
    
}
