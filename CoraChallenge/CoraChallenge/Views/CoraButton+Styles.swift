extension CoraButton.Style {
    static var `default` = CoraButton.Style(
        font: .init(
            name: "AvenirNext-Bold",
            size: CoraButton.Metrics.defaultFontSize
        ),
        backgroundColor: .mainPink,
        tintColor: .white
    )
    
    static var largeButton = CoraButton.Style(
        font: .init(
            name: "AvenirNext-Bold",
            size: CoraButton.Metrics.largeFontSize
        ),
        backgroundColor: .white,
        tintColor: .mainPink
    )
}
