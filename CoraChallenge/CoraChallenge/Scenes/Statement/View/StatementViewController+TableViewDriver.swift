import UIKit

extension StatementViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.sections.count ?? 0
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        let section = viewModel?.sections[safeIndex: section]
        return section?.items.count ?? 0
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueResuableCell(
            GenericTableViewCell<StatementItemView>.self,
            for: indexPath
        )
        
        let section = viewModel?.sections[safeIndex: indexPath.section]
        guard let viewModel = section?.items[safeIndex: indexPath.item] else { return cell }
        
        cell.customView.setup(with: viewModel)
        
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        return viewProtocol.sectionHeaderHeight
    }
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        let title = viewModel?.sections[section].title ?? ""
        let headerView = StatementHeaderView()
        headerView.title = title
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

extension StatementViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewProtocol.cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .zero
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.didSelectItem(request: .init(indexPath: indexPath))
    }
    
}
