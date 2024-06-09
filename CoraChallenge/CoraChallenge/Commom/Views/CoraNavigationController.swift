import UIKit

final class CoraNavigationController: UINavigationController {
    
    private enum Metrics {
        static var titleFontSize: CGFloat = 14
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
    }
    
    private func setupStyle() {
        guard let font = UIFont.avenir(size: Metrics.titleFontSize) else { return }
        
        let appearence = UINavigationBarAppearance()
        appearence.configureWithTransparentBackground()
        
        appearence.backgroundColor = .terciaryGray
        appearence.titleTextAttributes  = [
            NSAttributedString.Key.font: font,
            .foregroundColor: UIColor.secondaryGray]
        appearence.largeTitleTextAttributes = [.foregroundColor: UIColor.secondaryGray]
        
        UINavigationBar.appearance().tintColor = .mainPink
        UINavigationBar.appearance().standardAppearance = appearence
        UINavigationBar.appearance().compactAppearance = appearence
        UINavigationBar.appearance().scrollEdgeAppearance = appearence
        
        navigationBar.prefersLargeTitles = false
        navigationBar.isTranslucent = false
        navigationBar.backIndicatorImage = UIImage(named: "chevronLeft")
        navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "chevronLeft")
    }
    
}
