//
//  WelcomePresenterTests.swift
//  CoraChallengeTests
//
//  Created by Alysson Moreira on 03/06/24.
//

import XCTest
@testable import CoraChallenge

final class WelcomePresenterTests: XCTestCase {
    private let displayerSpy = DisplayerSpy()
    private lazy var sut = {
        let presenter = WelcomePresenter()
        presenter.displayer = displayerSpy
        return presenter
    }()
    
    func test_presentLogin_whenMethodIsCalled_thenItShouldCallCorrectMethodFromDisplayer() {
        // Given
        let expectedDisplayLoginCalls = 1
        
        // When
        sut.presentLogin()
        
        // Then
        XCTAssertEqual(displayerSpy.displayLoginCalls, expectedDisplayLoginCalls)
    }
    
}

// MARK: - Test Doubles
extension WelcomePresenterTests {
    private final class DisplayerSpy: WelcomeDisplayLogic {
        
        private(set) var displayLoginCalls = 0
        func displayLogin() {
            displayLoginCalls += 1
        }
        
    }
}
