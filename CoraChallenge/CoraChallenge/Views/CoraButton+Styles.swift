extension CoraButton.Style {
    static var defaultPink = CoraButton.Style(
        font: .avenirBold(size: CoraButton.Metrics.defaultFontSize),
        backgroundColor: .mainPink,
        tintColor: .white
    )
    
    static var defaultWhite = CoraButton.Style(
        font: .avenir(size: CoraButton.Metrics.defaultFontSize),
        backgroundColor: .white,
        tintColor: .mainPink
    )
    
    static var largeButton = CoraButton.Style(
        font: .avenirBold(size: CoraButton.Metrics.largeFontSize),
        backgroundColor: .white,
        tintColor: .mainPink
    )
}
