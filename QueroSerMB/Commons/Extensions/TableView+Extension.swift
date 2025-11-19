//
//  TableView+Extension.swift
//  QueroSerMB
//
//  Created by Hundily Cerqueira on 17/11/25.
//

import UIKit

extension UIView {
    static var identifierCore: String { return String(describing: self) }
}

extension UITableView {
    func registerCore(cellClass: UITableViewCell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.identifierCore)
    }
    
    func dequeueReusableCellCore<T: UITableViewCell>(of class: T.Type,
                                                     for indexPath: IndexPath,
                                                     configure: ((T) -> Void) = { _ in }) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: T.identifierCore, for: indexPath)
        if let typedCell = cell as? T {
            configure(typedCell)
        }
        return cell
    }
    
    func cellForRowCore(row: Int, section: Int, numberOfRows: Int) -> UITableViewCell? {
        let indexPath = IndexPath(row: row, section: section)
        guard let cell = self.cellForRow(at: indexPath) else { return nil }
        let rowCell = row < numberOfRows - 1 ? row + 1 : row
        self.scrollToRow(at: IndexPath(row: rowCell, section: 0), at: .top, animated: false)
        return cell
    }
}
