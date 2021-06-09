//
//  FormTableViewCell.swift
//  Instagram.AniMekvabidze
//
//  Created by Mac User on 6/8/21.
//

import UIKit
// in video ist FormTableViewCell-DELEGATE
protocol FormTableViewCellDelegate: AnyObject {
    func formTableViewCell(_cell: FormTableViewCell, updatedModel: EditProfileFormModel)
}

class FormTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    static let identifier = "FormTableViewCell"
    private var model: EditProfileFormModel?

    public  var delegate: FormTableViewCellDelegate?
    private let formLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let field: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        return field
        
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(formLabel)
        contentView.addSubview(field)
        field.delegate = self
        // in order cell not to be selectable
        selectionStyle = .none
        
        
    }
    
    public  func conficure(with model: EditProfileFormModel) {
        self.model = model
        formLabel.text = model.label
        field.placeholder = model.placeholder
        field.text = model.value
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        formLabel.text = nil
        field.placeholder = nil
        field.text = nil
        
        //prior cell values will never accidentaly be used for next one
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        // Assign Frames
        formLabel.frame = CGRect(x: 5, y: 0, width: contentView.width/3, height: contentView.height)
        field.frame = CGRect(x: formLabel.right+5, y: 0, width: contentView.width-10-formLabel.width, height: contentView.height)
        
        
    }
    // MARK: - Field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        model?.value = textField.text
        guard let model = model else { return true }
        textField.resignFirstResponder()
        delegate?.formTableViewCell(_cell: self, updatedModel: model)
        return true
        // to dismiis  the keyboard automatikally after writing is done
        
        
    }
   
    
}
