extension CoraButton.Style {
    static var `default` = CoraButton.Style(
        font: .avenir(size: CoraButton.Metrics.defaultFontSize),
        backgroundColor: .mainPink,
        tintColor: .white
    )
    
    static var largeButton = CoraButton.Style(
        font: .avenir(size: CoraButton.Metrics.largeFontSize),
        backgroundColor: .white,
        tintColor: .mainPink
    )
}
