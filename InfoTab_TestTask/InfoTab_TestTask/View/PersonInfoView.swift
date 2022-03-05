//
//  PersonInfoView.swift
//  InfoTab_TestTask
//
//  Created by Alexander Grigoryev on 05.03.2022.
//

import UIKit

protocol Delegate {
    func isTapped(_ tap: Bool)
    
    func arrayIsFull(_ tap: Bool)
}

final class PersonInfoView: UIView {
    
    //    MARK: - Properties
    
    var arrayOfChild: [Child] = []
    
    var delegate: Delegate?
    
    // MARK: - Subviews
    
    let nameLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .black
        l.textAlignment = .left
        l.font = UIFont.systemFont(ofSize: 14.0)
        l.text = "Имя"
        
        return l
    }()
    
    let ageLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .black
        l.textAlignment = .left
        l.font = UIFont.systemFont(ofSize: 14.0)
        l.text = "Возраст"
        
        return l
    }()
    
    let maxInfoLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .black
        l.textAlignment = .center
        l.font = UIFont.boldSystemFont(ofSize: 17)
        l.text = "Дети (макс.5)"
        
        return l
    }()
    
    var nameField: UITextField = {
        let t = UITextField()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.textColor = .black
        t.textAlignment = .left
        t.borderStyle = .roundedRect
        t.resignFirstResponder()
        t.selectedTextRange = nil
        
        return t
    }()
    
    var ageField: UITextField = {
        let t = UITextField()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.textColor = .black
        t.textAlignment = .left
        t.borderStyle = .roundedRect
        
        return t
    }()
    
    let addButton: UIButton = {
        let button = UIButton(type: .contactAdd)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Добавить ребенка", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.layer.cornerRadius = 15.0
        button.addTarget(self, action: #selector(addButtonHandler), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    // MARK: - UI
    
    @objc func addButtonHandler(_ sender: UIButton) {
        addChild()
        delegate?.isTapped(true)
    }
    
    private func addChild() {
        
        guard nameField.text != "",
              ageField.text != ""
        else
        { return }
        let name = nameField.text
        let age = ageField.text
        
        if arrayOfChild.count < 5 {
            arrayOfChild.append(Child(name: name!, age: age!))
        } else if arrayOfChild.count == 5 {
            self.delegate?.arrayIsFull(true)
            self.addButton.isHidden = true
            
        }
        
    }
    
    private func configureUI() {
        self.addSubview(nameLabel)
        self.addSubview(ageLabel)
        self.addSubview(nameField)
        self.addSubview(ageField)
        self.addSubview(addButton)
        self.addSubview(maxInfoLabel)
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        
        let s = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            
            self.nameLabel.topAnchor.constraint(equalTo: s.topAnchor, constant: 15),
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
            
            self.maxInfoLabel.topAnchor.constraint(equalTo: ageField.bottomAnchor, constant: 5),
            self.maxInfoLabel.leftAnchor.constraint(equalTo: s.leftAnchor, constant: 20),
            self.maxInfoLabel.widthAnchor.constraint(equalToConstant: 130),
            
            self.addButton.leftAnchor.constraint(equalTo: maxInfoLabel.rightAnchor, constant: 10),
            self.addButton.widthAnchor.constraint(equalToConstant: 170),
            self.addButton.topAnchor.constraint(equalTo: ageField.bottomAnchor, constant: 5)
        ])
    }
}

