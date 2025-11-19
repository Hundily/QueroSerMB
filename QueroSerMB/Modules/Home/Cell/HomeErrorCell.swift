//
//  HomeErrorCell.swift
//  QueroSerMB
//
//  Created by Hundily Cerqueira on 18/11/25.
//

import UIKit
import Foundation

protocol HomeErrorCellDelegate: AnyObject {
    func didTapRetryButton()
}

class HomeErrorCell: UITableViewCell {

    weak var delegate: HomeErrorCellDelegate?
        
    private lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [iconImageView, messageLabel, retryButton])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var iconImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "exclamationmark.triangle.fill")
        image.tintColor = .systemRed
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 48).isActive = true
        image.heightAnchor.constraint(equalToConstant: 48).isActive = true
        return image
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Ocorreu um erro ao carregar os dados. Verifique sua conexão e tente novamente."
        label.textColor = .systemGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tentar Novamente", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        button.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        return button
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        self.accessibilityIdentifier = "HomeErrorCell"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupView() {
        contentView.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            vStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            vStack.heightAnchor.constraint(greaterThanOrEqualToConstant: 150)
        ])
        
        self.selectionStyle = .none
    }
        
    @objc private func retryButtonTapped() {
        delegate?.didTapRetryButton()
    }
    
    public func configure(with errorMessage: String? = nil) {
        if let message = errorMessage, !message.isEmpty {
            messageLabel.text = message
        }
    }
}
