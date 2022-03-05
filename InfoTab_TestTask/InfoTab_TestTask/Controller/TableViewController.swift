//
//  TableViewController.swift
//  InfoTab_TestTask
//
//  Created by Alexander Grigoryev on 05.03.2022.
//

import UIKit

class TableViewController: UIViewController {
    
    //    MARK: - Properties
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.sizeToFit()
        
        return tableView
    }()
    
    let deleteAllButoon: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .red
        button.setTitleColor(.red, for: .normal)
        button.setTitle("Очистить", for: .normal)
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(deleteButtonHandler(_:)), for: .touchUpInside)
        
        return button
    }()
    
    var safeArea: UILayoutGuide!
    
    private var personInfoView = PersonInfoView()
    
    var delegate: Delegate?
    
    //    MARK: - Lifecycle
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reusedIdentifier)
        personInfoView.delegate = self
        
        self.configureUI()
    }
    
    
    // MARK: - UI
    
    private func configureUI () {
        setupPersonInfoView()
        setupTableView()
        setupCancelButton()
    }
    
    @objc func deleteButtonHandler(_ sender: UIButton) {
        alertOfRemoval()
    }
    
    private func alertOfRemoval() {
        let alert = UIAlertController(
            title: "Вся информация будет удалена!",
            message: "Очистить таблицу?",
            preferredStyle: .alert)
        let approve = UIAlertAction(
            title: "Да", style: .default) { _ in
                self.personInfoView.arrayOfChild.removeAll()
                self.personInfoView.nameField.text = ""
                self.personInfoView.ageField.text = ""
                self.personInfoView.addButton.isHidden = false
                self.tableView.reloadData()
            }
        
        let cancel = UIAlertAction(title: "Нет", style: .cancel)
        alert.addAction(approve)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    private func alertOfLimit() {
        let alert = UIAlertController(title: "Ошибка",
                                      message: "Превышено максимально возможное количество детей",
                                      preferredStyle: .alert)
        let approve = UIAlertAction(title: "Ок",
                                    style: .default)
        alert.addAction(approve)
        present(alert, animated: true, completion: nil)
    }
    
    private func setupTableView() {
        self.view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 170).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
    }
    
    private func setupPersonInfoView() {
        self.personInfoView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(personInfoView)
        
        NSLayoutConstraint.activate([
            personInfoView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            personInfoView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            personInfoView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            personInfoView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    private func setupCancelButton() {
        
        self.view.addSubview(deleteAllButoon)
        
        NSLayoutConstraint.activate([
            deleteAllButoon.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            deleteAllButoon.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            deleteAllButoon.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
}

extension TableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personInfoView.arrayOfChild.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reusedIdentifier, for: indexPath) as! TableViewCell
        let child = personInfoView.arrayOfChild[indexPath.row]
        cell.configureCell(child)
        
        return cell
    }
}

extension TableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true)}
       
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
              if editingStyle == .delete {
                  self.personInfoView.arrayOfChild.remove(at: indexPath.row)
                  tableView.deleteRows(at: [indexPath], with: .fade)
                  self.personInfoView.addButton.isHidden = false
              }
     }
    
    
}

extension TableViewController: Delegate {
    
    func arrayIsFull(_ tap: Bool) {
        if tap == true {
            alertOfLimit()
        }
    }
    
    func isTapped(_ tap: Bool) {
        if tap == true {
            self.tableView.reloadData()
        }
    }
    
}






