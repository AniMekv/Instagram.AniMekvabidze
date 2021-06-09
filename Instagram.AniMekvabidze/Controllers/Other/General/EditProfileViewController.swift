//
//  EditProfileViewController.swift
//  Instagram.AniMekvabidze
//
//  Created by Mac User on 5/29/21.
//

import UIKit

struct EditProfileFormModel {
    let label: String
    let placeholder: String
    var value: String?
    
}
final class EditProfileViewController: UIViewController, UITableViewDataSource {
    // with anonimu cloruse
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
        
        return tableView
    }()
    
    private var models = [[EditProfileFormModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        //header view where user sees the profile and an edit it
        tableView.tableHeaderView = tableHeaderView()
        tableView.dataSource =  self
        view.addSubview(tableView)

        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(onSave))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(onCancel))


    }
    private func  configureModels() {
        // name, username, website, bio
        let section1Labels = ["Name", "Username", "Bio"]
        var section1 = [EditProfileFormModel]()
        for label in section1Labels {
            let model = EditProfileFormModel(label: label, placeholder: "enter \(label)...", value: nil)
            section1.append(model)
        }
        models.append(section1)
        
        // private info email phone
        let section2Labels = ["Email", "Phone"]
        var section2 = [EditProfileFormModel]()
        for label in section2Labels {
            let model = EditProfileFormModel(label: label, placeholder: "enter \(label)...", value: nil)
            section2.append(model)
        }
        models.append(section2)
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - TableView
    private func tableHeaderView() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height/4).integral)
        // integral rounds values to the neares integer in case we are using floating point
        let size = header.height/1.5
        
        let profilePhotoButton = UIButton(frame: CGRect(x: (view.width-size)/2,
                                                        y: (header.height-size)/2,
                                                        width: size, height: size))
        header.addSubview(profilePhotoButton)
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.tintColor = .label
        profilePhotoButton.layer.cornerRadius = size/2.0
        profilePhotoButton.addTarget(self, action: #selector(onProfileButton), for: .touchDragInside)
        profilePhotoButton.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        profilePhotoButton.layer.borderWidth = 1
        profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        return header
        
        
    }
    
    
    @objc private func onProfileButton() {
        
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // it's a two dementional array so [section]
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath) as! FormTableViewCell
        cell.conficure(with: model)
        cell.delegate = self

        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else {
            return nil
        }
        return "private Information"
    }
    // MARK:  - Action
    

    @objc private func onSave() {
        // save info to database
        dismiss(animated: true, completion: nil)

    }
    
    @objc private func onCancel() {
        // dismiss
        dismiss(animated: true, completion: nil)
        
    }
    
    // allow user change profile pic
    
    @objc private func  onChangeProfilePicture() {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Change Profile Picture", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "take photo", style: .default, handler: { _ in
        
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose from library", style: .default, handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds

        present(actionSheet, animated: true)
    }

}

extension EditProfileViewController: FormTableViewCellDelegate {
    func formTableViewCell(_cell: FormTableViewCell, updatedModel: EditProfileFormModel) {
        // Update the model
    }
    
    
    
}
