//
//  HomeDetailView.swift
//  QueroSerMB
//
//  Created by Hundily Cerqueira on 18/11/25.
//

import UIKit

protocol HomeDetailViewProtocol: UIView {
    func configure(model: ExchangeModel)
}

class HomeDetailView: UIView, HomeDetailViewProtocol {
    
    lazy var scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var vStackViewContent: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [logoImage,
                                                       titleLabel,
                                                       idLabel,
                                                       descriptionLabel,
                                                       websiteLabel,
                                                       tableView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
        
        return stackView
    }()
    
    private lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.widthAnchor.constraint(equalToConstant: 66).isActive = true
        image.heightAnchor.constraint(equalToConstant: 66).isActive = true
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 28)
        return label
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 28)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var websiteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapOnLink))
        label.addGestureRecognizer(tap)
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    var coins: [CoinModel]? {
        didSet {
            tableView.reloadData()
            updateTableHeight()
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: ExchangeModel) {
        titleLabel.text = model.name
        idLabel.text = String("ID: \(model.id ?? 0)")
        descriptionLabel.text = model.description
        
        if let first = model.urls?.website.first {
            websiteLabel.text = first
        }
        
        vStackViewContent.addArrangedSubview(createInfoDetail("Maker Free: ", model.maker_fee?.toUSD() ?? "0"))
        vStackViewContent.addArrangedSubview(createInfoDetail("Taker Free: ", model.taker_fee?.toUSD() ?? "0"))
        vStackViewContent.addArrangedSubview(createInfoDetail("Date launcher: ", model.date_launched?.toBrazilianDate() ?? "0"))
        
        if let urlString = model.logo, let url = URL(string: urlString) {
            self.logoImage.loadAndCache(
                from: url,
                defaultImage: UIImage(systemName: "person.fill")
            )
        }
    }
    
    func configureCoins(coins: [CoinModel]) {
        self.coins = coins
    }
    
    func updateTableHeight() {
        tableView.layoutIfNeeded()
        tableView.heightAnchor.constraint(equalToConstant: tableView.contentSize.height).isActive = true
    }
    
    @objc func tapOnLink() {
        if let url = URL(string: websiteLabel.text ?? "") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    func createInfoDetail(_ title: String, _ description: String) -> UIStackView {
        let labelTItle = UILabel()
        labelTItle.text = title
        
        let labelDetail = UILabel()
        labelDetail.text = description
        
        let stack = UIStackView(arrangedSubviews: [labelTItle, labelDetail])
        stack.axis = .horizontal
        
        return stack
    }
}

extension HomeDetailView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.coins?.count ?? 0
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = self.coins?[indexPath.row] else { return UITableViewCell() }
        
        let cell = UITableViewCell()
        let name = model.currency.name
        let price = model.currency.priceUsd?.toUSD() ?? "0"
        
        cell.textLabel?.text = "\(name): \(price)"
        
        return cell
    }
}

extension HomeDetailView: CodeViewProtocol {
    func buildViewHierarchy() {
        scroll.addSubview(vStackViewContent)
        addSubview(scroll)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: topAnchor),
            scroll.leadingAnchor.constraint(equalTo: leadingAnchor),
            scroll.bottomAnchor.constraint(equalTo: bottomAnchor),
            scroll.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            vStackViewContent.topAnchor.constraint(equalTo: scroll.topAnchor),
            vStackViewContent.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            vStackViewContent.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            vStackViewContent.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            vStackViewContent.widthAnchor.constraint(equalTo: scroll.widthAnchor),
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}
