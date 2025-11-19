//
//  CodeViewProtocol.swift
//  QueroSerMB
//
//  Created by Hundily Cerqueira on 18/11/25.
//

protocol CodeViewProtocol {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupViews()
}

extension CodeViewProtocol {
    func setupViews() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
    
    func setupAdditionalConfiguration() { }
}
