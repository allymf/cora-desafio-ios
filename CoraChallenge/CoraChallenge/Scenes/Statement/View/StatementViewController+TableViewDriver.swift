import UIKit

extension StatementViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel?.sections.count ?? 0
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueResuableCell(
            GenericTableViewCell<StatementItemView>.self,
            for: indexPath
        )
        
        cell.customView
        
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
}

extension StatementViewController: UITableViewDelegate {}
