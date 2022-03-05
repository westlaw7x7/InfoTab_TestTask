//
//  TableViewCell.swift
//  InfoTab_TestTask
//
//  Created by Alexander Grigoryev on 05.03.2022.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    
    //    MARK: - Subviews
    static let reusedIdentifier = "PersonCell"
    
    var delegate: Delegate?
    
    var nameLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .black
        l.textAlignment = .left
        l.font = UIFont.systemFont(ofSize: 14.0)
        l.text = "Имя:"
        
        return l
    }()
    
    var ageLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .black
        l.textAlignment = .left
        l.font = UIFont.systemFont(ofSize: 14.0)
        l.text = "Возраст:"
        
        return l
    }()
    
    
    var nameField: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .black
        l.textAlignment = .left
        l.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        return l
    }()
    
    var ageField: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .black
        l.textAlignment = .left
        l.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        return l
    }()
    
    
    //    MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    // MARK: - UI
    
    private func configureUI() {
        self.addSubview(nameLabel)
        self.addSubview(ageLabel)
        self.addSubview(nameField)
        self.addSubview(ageField)
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        
        let s = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            
            self.nameLabel.topAnchor.constraint(equalTo: s.topAnchor, constant: 5),
            self.nameLabel.leftAnchor.constraint(equalTo: s.leftAnchor, constant: 20),
            self.nameLabel.rightAnchor.constraint(equalTo: s.rightAnchor, constant: 100),
            self.nameLabel.widthAnchor.constraint(equalToConstant: 30),
            
            self.nameField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            self.nameField.leftAnchor.constraint(equalTo: s.leftAnchor, constant: 20),
            self.nameField.widthAnchor.constraint(equalToConstant: 200),
            
            self.ageLabel.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 5),
            self.ageLabel.leftAnchor.constraint(equalTo: s.leftAnchor, constant: 20),
            self.ageLabel.rightAnchor.constraint(equalTo: s.rightAnchor, constant: 100),
            self.ageLabel.widthAnchor.constraint(equalToConstant: 30),
            
            self.ageField.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 5),
            self.ageField.leftAnchor.constraint(equalTo: s.leftAnchor, constant: 20),
            self.ageField.widthAnchor.constraint(equalToConstant: 200),
            
        ])
    }
    
    func configureCell(_ child: Child) {
        nameField.text = child.name
        ageField.text = child.age
    }
}
