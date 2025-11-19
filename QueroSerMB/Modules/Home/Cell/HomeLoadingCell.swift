//
//  LoadingCell.swift
//  QueroSerMB
//
//  Created by Hundily Cerqueira on 18/11/25.
//

import UIKit

class HomeLoadingCell: UITableViewCell {

    private let spinner: UIActivityIndicatorView = {
        let s = UIActivityIndicatorView(style: .medium)
        s.translatesAutoresizingMaskIntoConstraints = false
        s.startAnimating()
        return s
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        self.accessibilityIdentifier = "HomeLoadingCell"
    }

    required init?(coder: NSCoder) {
        return nil
    }

    private func setupLayout() {
        contentView.addSubview(spinner)

        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}
