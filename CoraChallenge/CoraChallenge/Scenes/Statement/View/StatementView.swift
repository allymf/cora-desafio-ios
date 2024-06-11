import UIKit

protocol StatementViewActions {
    var didPullToRefresh: () -> Void { get }
}

protocol StatementViewProtocol: ViewInitializer {
    var sectionHeaderHeight: CGFloat { get }
    var actions: StatementViewActions? { get set }
    
    func setupTableView(with driver: UITableViewDataSource & UITableViewDelegate)
    
    func reloadTableView()
    func stopRefresh()
}

final class StatementView: CodedView, StatementViewProtocol {

    enum Metrics {
        
        enum OptionsStackView {
            static var height: CGFloat = 64
        }
        
        enum SelectedButtonView {
            static var width: CGFloat = 32
            static var height: CGFloat = 1
            static var margin: CGFloat = 20
        }
        
        enum TableView {
            static var sectionHeaderHeight: CGFloat = 32
            static var cellHeight: CGFloat = 130
        }
        
        enum Button {
            static var fontSize: CGFloat = 14
        }
        
    }
    
    // MARK: - Subviews
    private lazy var optionsStackView = {
        let stackView = UIStackView()
        
        stackView.addArrangedSubview(everythingButton)
        stackView.addArrangedSubview(incomeButton)
        stackView.addArrangedSubview(withdrawalButton)
        stackView.addArrangedSubview(futureButton)
        stackView.addArrangedSubview(filterButton)
        
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var everythingButton = {
        let button = UIButton()
        
        button.setTitle(
            String(localized: "Statement.EverythingButton.Title"),
            for: .normal
        )
        button.setTitleColor(
            .mainPink,
            for: .normal
        )
        button.titleLabel?.font = .avenir(size: Metrics.Button.fontSize)
        button.addTarget(
            self,
            action: #selector(didTapEverythingButton),
            for: .touchUpInside
        )
        
        return button
    }()
    
    private lazy var incomeButton = {
        let button = UIButton()
        
        button.setTitle(
            String(localized: "Statement.IncomeButton.Title"),
            for: .normal
        )
        button.setTitleColor(
            .secondaryGray,
            for: .normal
        )
        button.titleLabel?.font = .avenir(size: Metrics.Button.fontSize)
        
        button.addTarget(
            self,
            action: #selector(didTapIncomeButton),
            for: .touchUpInside
        )
        
        return button
    }()
    
    private lazy var withdrawalButton = {
        let button = UIButton()
        
        button.setTitle(
            String(localized: "Statement.WithdrawalButton.Title"),
            for: .normal
        )
        button.setTitleColor(
            .secondaryGray,
            for: .normal
        )
        button.titleLabel?.font = .avenir(size: Metrics.Button.fontSize)
        button.addTarget(
            self, 
            action: #selector(didTapWithdrawalButton),
            for: .touchUpInside
        )
        
        return button
    }()
    
    private lazy var futureButton = {
        let button = UIButton()
        
        button.setTitle(
            String(localized: "Statement.FutureButton.Title"),
            for: .normal
        )
        button.setTitleColor(
            .secondaryGray,
            for: .normal
        )
        button.titleLabel?.font = .avenir(size: Metrics.Button.fontSize)
        button.addTarget(
            self,
            action: #selector(didTapFutureButton),
            for: .touchUpInside
        )
        
        return button
    }()
    
    private lazy var filterButton = {
        let button = UIButton()
        
        let buttonIcon = UIImage(named: "filter")
        button.setImage(
            buttonIcon,
            for: .normal
        )
        button.tintColor = .mainPink
        
        return button
    }()
    
    private let selectedButtonView = {
        let view = UIView()
        
        view.backgroundColor = .mainPink
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var refreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            self,
            action: #selector(didPullToRefresh),
            for: .valueChanged
        )
        return refreshControl
    }()
    
    private lazy var tableView = {
        let tableView = UITableView(
            frame: .zero,
            style: .grouped
        )
        
        tableView.contentInset = .zero
        tableView.separatorStyle = .none
        tableView.refreshControl = refreshControl
        
        tableView.register(GenericTableViewCell<StatementItemView>.self)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private var selectableButtons: [UIButton] {
        [
            everythingButton,
            incomeButton,
            withdrawalButton,
            futureButton
        ]
    }
    
    private var selectedButtonViewTopConstraint: NSLayoutConstraint?
    private var selectedButtonViewCenterXConstraint: NSLayoutConstraint?
    
    // MARK: - Public API
    var sectionHeaderHeight: CGFloat { return Metrics.TableView.sectionHeaderHeight }
    var actions: StatementViewActions?
    
    func setupTableView(with driver: UITableViewDataSource & UITableViewDelegate) {
        tableView.dataSource = driver
        tableView.delegate = driver
    }
    
    func reloadTableView() {
        stopRefresh()
        tableView.reloadData()
    }
    
    func stopRefresh() {
        refreshControl.endRefreshing()
    }
    
    // MARK: - CodedView Life Cycle
    override func addSubviews() {
        addSubviews(
            optionsStackView,
            selectedButtonView,
            tableView
        )
    }
    
    override func constrainSubviews() {
        constrainOptionsStackView()
        constrainTableView()
        constrainSelectedButtonView()
    }
    
    override func configureAdditionalSettings() {
        backgroundColor = .white
    }
}

// MARK: - Component Interactions
private extension StatementView {
    @objc
    func didTapEverythingButton() {
        performVisualUpdates(for: everythingButton)
    }
    
    @objc
    func didTapIncomeButton() {
        performVisualUpdates(for: incomeButton)
    }
    
    @objc
    func didTapWithdrawalButton() {
        performVisualUpdates(for: withdrawalButton)
    }
    
    @objc
    func didTapFutureButton() {
        performVisualUpdates(for: futureButton)
    }
    
    @objc
    func didPullToRefresh() {
        actions?.didPullToRefresh()
    }
    
    func performVisualUpdates(for selectedButton: UIButton) {
        updateSelectedButtonConstraint(with: selectedButton)
        updateButtonsStyle(selectedButton: selectedButton)
    }
                           
    func updateButtonsStyle(selectedButton: UIButton) {
        for button in selectableButtons {
            setupDiselectedStyle(in: button)
        }
        setupSelectedStyle(in: selectedButton)
    }
    
    func setupSelectedStyle(in button: UIButton) {
        button.setTitleColor(
            .mainPink,
            for: .normal
        )
    }
    
    func setupDiselectedStyle(in button: UIButton) {
        button.setTitleColor(
            .secondaryGray,
            for: .normal
        )
    }
}

// MARK: - Constraint Related Methods
private extension StatementView {
    func constrainOptionsStackView() {
        NSLayoutConstraint.activate(
            optionsStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            optionsStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            optionsStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            optionsStackView.heightAnchor.constraint(equalToConstant: Metrics.OptionsStackView.height)
        )
    }
    
    func constrainTableView() {
        NSLayoutConstraint.activate(
            tableView.topAnchor.constraint(equalTo: optionsStackView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        )
    }
    
    func constrainSelectedButtonView() {
        let selectedButtonViewTopConstraint = selectedButtonView.topAnchor.constraint(
            equalTo: everythingButton.bottomAnchor,
            constant: -Metrics.SelectedButtonView.margin
        )
        let selectedButtonViewCenterXConstraint = selectedButtonView.centerXAnchor.constraint(equalTo: everythingButton.centerXAnchor)
        
        self.selectedButtonViewCenterXConstraint = selectedButtonViewCenterXConstraint
        self.selectedButtonViewTopConstraint = selectedButtonViewTopConstraint
        
        NSLayoutConstraint.activate(
            selectedButtonViewTopConstraint,
            selectedButtonViewCenterXConstraint,
            selectedButtonView.widthAnchor.constraint(equalToConstant: Metrics.SelectedButtonView.width),
            selectedButtonView.heightAnchor.constraint(equalToConstant: Metrics.SelectedButtonView.height)
        )
    }
    
    func updateSelectedButtonConstraint(with view: UIView) {
        selectedButtonViewTopConstraint?.isActive = false
        selectedButtonViewCenterXConstraint?.isActive = false
        
        selectedButtonViewTopConstraint = selectedButtonView.topAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: -Metrics.SelectedButtonView.margin
        )
        selectedButtonViewCenterXConstraint = selectedButtonView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        selectedButtonViewTopConstraint?.isActive = true
        selectedButtonViewCenterXConstraint?.isActive = true
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: .curveEaseOut
        ) {
            self.layoutIfNeeded()
        }
    }
    
}
