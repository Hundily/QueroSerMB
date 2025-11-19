//
//  HomeListCell.swift
//  QueroSerMB
//
//  Created by Hundily Cerqueira on 17/11/25.
//

import UIKit

class HomeListCell: UITableViewCell {
    
    private lazy var hStackContent: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [logoImageView,
                                                   vStack])
        stack.spacing = 16
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [labelTitle])
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private lazy var logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.fill")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 32).isActive = true
        image.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        return image
    }()
    
    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupInfo(model: ExchangeModel, index: Int) {
        self.accessibilityIdentifier = "HomeListCell_\(index)"
        
        labelTitle.text = model.name
        vStack.addArrangedSubview(createHStack("Spot Volume USD:", model.spot_volume_usd?.toUSD() ?? ""))
        vStack.addArrangedSubview(createHStack("Date Lauched:", model.date_launched?.toBrazilianDate() ?? ""))
        if let urlString = model.logo, let url = URL(string: urlString) {
            self.logoImageView.loadAndCache(from: url, defaultImage: UIImage(systemName: "person.fill"))
        }
    }
    
    func createHStack(_ title: String, _ detail: String) -> UIStackView {
        let labelTitle = UILabel()
        labelTitle.text = title
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = detail
        descriptionLabel.textAlignment = .right
        
        let stack = UIStackView(arrangedSubviews: [labelTitle, descriptionLabel])
        stack.axis = .horizontal
        stack.spacing = 4
        
        return stack
    }
}

extension HomeListCell: CodeViewProtocol {
    func buildViewHierarchy() {
        contentView.addSubview(hStackContent)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            hStackContent.topAnchor.constraint(equalTo: contentView.topAnchor),
            hStackContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hStackContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            hStackContent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
    }
}
