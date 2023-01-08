//
//  ViewFridgeItemForm.swift
//  KitchenHelper
//
//  Created by dfg on 26.11.2022.
//
import UIKit
import UserNotifications
import Vision


protocol AnyViewFridgeItemForm {
    var presenter: AnyPresenterFridgeItemForm? {get set}
    func present(ac: UIAlertController, animated: Bool)
}

class FridgeItemFormViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AnyViewFridgeItemForm {
    
    func present(ac: UIAlertController, animated: Bool) {
        self.present(ac: ac, animated: animated)
    }
    
    var presenter: AnyPresenterFridgeItemForm?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    let id = UUID().uuidString
    
    @objc func onAddPhoto(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.allowsEditing = true
        vc.delegate = self
        
        let alertController = UIAlertController(title: "Выбор источника", message: "", preferredStyle: .actionSheet)

        let cameraAction = UIAlertAction(title: "Камера", style: UIAlertAction.Style.default) {
                UIAlertAction in
                vc.sourceType = .camera
            self.present(vc, animated: true)
            }
        let libraryAction = UIAlertAction(title: "Альбом", style: UIAlertAction.Style.destructive) {
                UIAlertAction in
                vc.sourceType = .photoLibrary
            self.present(vc, animated: true)
            }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                UIAlertAction in
                NSLog("Cancel Pressed")
            }

            alertController.addAction(cameraAction)
            alertController.addAction(libraryAction)
        
            alertController.addAction(cancelAction)

            self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func onAddItem(_ sender: Any) {
        
        presenter?.createItem(name: nameTextField.text ?? "", itemDescription: descriptionTextField.text ?? "",  id: id, itemImage: itemImage, overdueDate: self.datePickerField.date, isOverdueNotificationSwitch: overdueNotificationSwitch.isOn)
        
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    var itemImage = UIImage(named: "drink")!
    
    let viewWrapper = UIScrollView()
    
    let nameTextField = UITextField()
    let descriptionTextField = UITextField()
    let datePickerField = UIDatePicker()
    
    let overdueNotificationWrapper = UIView()
    let overdueNotificationSwitch = UISwitch()
    let overdueNotificationLabel = UILabel()
    
    let descriptionFromCameraWrapper = UIView()
    let descriptionFromCameraSwitch = UISwitch()
    let descriptionFromCameraLabel = UILabel()
    
    let cameraButton = UIButton(type: .system)
    let addItemButton = UIButton(type: .system)
    
    
    let wrapperMargin: CGFloat = 20
    let fieldsHeight: CGFloat = 40
    var datePickerHeight: CGFloat = 100
    let fieldsTopMargin: CGFloat = 30
    let overdueSwithRightMargin: CGFloat = -3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Новый продукт"
        
        self.hideKeyboardWhenTappedAround()
        
        if #available(iOS 14.0, *) {
            datePickerHeight = 40
        }
        
        datePickerField.preferredDatePickerStyle = .compact
        
        view.backgroundColor = .white
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        viewWrapper.translatesAutoresizingMaskIntoConstraints = false
        datePickerField.translatesAutoresizingMaskIntoConstraints = false
        overdueNotificationWrapper.translatesAutoresizingMaskIntoConstraints = false
        overdueNotificationSwitch.translatesAutoresizingMaskIntoConstraints = false
        overdueNotificationLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionFromCameraWrapper.translatesAutoresizingMaskIntoConstraints = false
        descriptionFromCameraSwitch.translatesAutoresizingMaskIntoConstraints = false
        descriptionFromCameraLabel.translatesAutoresizingMaskIntoConstraints = false
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        addItemButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        nameTextField.placeholder = "Название продукта"
        nameTextField.clearButtonMode = .whileEditing
        
        descriptionTextField.placeholder = "Описание продукта"
        descriptionTextField.clearButtonMode = .whileEditing
        
        
        overdueNotificationLabel.text = "Уведомлять о просрочке?"
        descriptionFromCameraLabel.text = "Считывать описание из фото?"
        
        overdueNotificationSwitch.isOn = true
        overdueNotificationSwitch.onTintColor = ColorsInstance.green
        
        descriptionFromCameraSwitch.isOn = false
        descriptionFromCameraSwitch.onTintColor = ColorsInstance.green
        
        cameraButton.setTitle("Добавить фото", for: .normal)
        
        cameraButton.addTarget(self, action: #selector(onAddPhoto), for: .touchUpInside)
        
        addItemButton.setTitle("Добавить продукт", for: .normal)
        
        
        addItemButton.addTarget(self, action: #selector(onAddItem), for: .touchUpInside)
        
        cameraButton.backgroundColor = ColorsInstance.green
        cameraButton.layer.cornerRadius = 20
        cameraButton.setTitleColor(.black, for: .normal)
        
        
        addItemButton.backgroundColor = ColorsInstance.gray
        addItemButton.layer.cornerRadius = 20
        addItemButton.setTitleColor(.white, for: .normal)
     
        
        nameTextField.borderStyle = .roundedRect
        descriptionTextField.borderStyle = .roundedRect
        
        
        view.addSubview(viewWrapper)
        viewWrapper.addSubview(nameTextField)
        viewWrapper.addSubview(descriptionTextField)
        viewWrapper.addSubview(datePickerField)
        
        viewWrapper.addSubview(overdueNotificationWrapper)
        overdueNotificationWrapper.addSubview(overdueNotificationSwitch)
        overdueNotificationWrapper.addSubview(overdueNotificationLabel)
        
        viewWrapper.addSubview(descriptionFromCameraWrapper)
        descriptionFromCameraWrapper.addSubview(descriptionFromCameraSwitch)
        descriptionFromCameraWrapper.addSubview(descriptionFromCameraLabel)
        
        viewWrapper.addSubview(cameraButton)
        viewWrapper.addSubview(addItemButton)
        
        
        NSLayoutConstraint.activate([
            viewWrapper.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: wrapperMargin),
            viewWrapper.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -wrapperMargin),
            
            viewWrapper.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: fieldsTopMargin),
            viewWrapper.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
       ])
        
        NSLayoutConstraint.activate([
            nameTextField.heightAnchor.constraint(equalToConstant: fieldsHeight),
            nameTextField.widthAnchor.constraint(equalTo: viewWrapper.widthAnchor, multiplier : 1),
            nameTextField.centerXAnchor.constraint(equalTo: viewWrapper.centerXAnchor ),
            nameTextField.topAnchor.constraint(equalTo: viewWrapper.topAnchor),
       ])
        
        NSLayoutConstraint.activate([
            descriptionTextField.heightAnchor.constraint(equalToConstant: fieldsHeight),
            descriptionTextField.widthAnchor.constraint(equalTo: viewWrapper.widthAnchor, multiplier : 1),
            descriptionTextField.centerXAnchor.constraint(equalTo: viewWrapper.centerXAnchor ),
            descriptionTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: fieldsTopMargin),
       ])
        
        
        NSLayoutConstraint.activate([
            datePickerField.heightAnchor.constraint(equalToConstant: datePickerHeight),
            datePickerField.widthAnchor.constraint(equalTo: viewWrapper.widthAnchor, multiplier : 1),
            datePickerField.centerXAnchor.constraint(equalTo: viewWrapper.centerXAnchor ),
            datePickerField.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: fieldsTopMargin),
       ])
        
        NSLayoutConstraint.activate([
            overdueNotificationWrapper.heightAnchor.constraint(equalToConstant: fieldsHeight),
            overdueNotificationWrapper.widthAnchor.constraint(equalTo: viewWrapper.widthAnchor, multiplier : 1),
            overdueNotificationWrapper.centerXAnchor.constraint(equalTo: viewWrapper.centerXAnchor ),
            overdueNotificationWrapper.topAnchor.constraint(equalTo: datePickerField.bottomAnchor, constant: fieldsTopMargin),
       ])
        
        NSLayoutConstraint.activate([
            overdueNotificationLabel.topAnchor.constraint(equalTo: overdueNotificationWrapper.topAnchor, constant: fieldsHeight/2 ),
            overdueNotificationLabel.leadingAnchor.constraint(equalTo: overdueNotificationWrapper.leadingAnchor),
       ])
        
        NSLayoutConstraint.activate([
            overdueNotificationSwitch.topAnchor.constraint(equalTo: overdueNotificationWrapper.topAnchor, constant: fieldsHeight/2 ),
            overdueNotificationSwitch.trailingAnchor.constraint(equalTo: overdueNotificationWrapper.trailingAnchor, constant: overdueSwithRightMargin),
       ])
        
        NSLayoutConstraint.activate([
            descriptionFromCameraWrapper.heightAnchor.constraint(equalToConstant: fieldsHeight),
            descriptionFromCameraWrapper.widthAnchor.constraint(equalTo: viewWrapper.widthAnchor, multiplier : 1),
            descriptionFromCameraWrapper.centerXAnchor.constraint(equalTo: viewWrapper.centerXAnchor ),
            descriptionFromCameraWrapper.topAnchor.constraint(equalTo: overdueNotificationWrapper.bottomAnchor, constant: fieldsTopMargin),
       ])
       
        
        NSLayoutConstraint.activate([
            descriptionFromCameraLabel.topAnchor.constraint(equalTo: descriptionFromCameraWrapper.topAnchor, constant: fieldsHeight/2 ),
            descriptionFromCameraLabel.leadingAnchor.constraint(equalTo: descriptionFromCameraWrapper.leadingAnchor),
       ])
        
        NSLayoutConstraint.activate([
            descriptionFromCameraSwitch.topAnchor.constraint(equalTo: descriptionFromCameraWrapper.topAnchor, constant: fieldsHeight/2 ),
            descriptionFromCameraSwitch.trailingAnchor.constraint(equalTo: descriptionFromCameraWrapper.trailingAnchor, constant: overdueSwithRightMargin),
       ])
        
        
        NSLayoutConstraint.activate([
            cameraButton.heightAnchor.constraint(equalToConstant: fieldsHeight),
            cameraButton.widthAnchor.constraint(equalTo: viewWrapper.widthAnchor, multiplier : 1),
            cameraButton.centerXAnchor.constraint(equalTo: viewWrapper.centerXAnchor ),
            cameraButton.topAnchor.constraint(equalTo: descriptionFromCameraSwitch.bottomAnchor, constant: fieldsTopMargin * 2),
       ])
        
    
        NSLayoutConstraint.activate([
            addItemButton.heightAnchor.constraint(equalToConstant: fieldsHeight),
            addItemButton.widthAnchor.constraint(equalTo: viewWrapper.widthAnchor, multiplier : 1),
            addItemButton.centerXAnchor.constraint(equalTo: viewWrapper.centerXAnchor ),
            addItemButton.bottomAnchor.constraint(equalTo: cameraButton.bottomAnchor, constant: fieldsTopMargin * 2),
       ])
    }
    
    override func viewDidLayoutSubviews() {
        // ios 14 has new date picker format
        if #available(iOS 14.0, *) {
            viewWrapper.contentSize = CGSize(width: 0, height: 520)
        } else {
            viewWrapper.contentSize = CGSize(width: 0, height: 580)
        }
    }
    
    func updateItem(item: FridgeItem, newName: String) {
        item.name=newName
        do {
            try context.save()
        } catch {
            print("error updating items CoreData")
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        
        itemImage = image
        
        if (descriptionFromCameraSwitch.isOn) {
            recognizeImage(imageWithText: image)
        }
    }
    
    func recognizeImage(imageWithText: UIImage) {
        guard let cgImage = imageWithText.cgImage else {return}

        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        let request = VNRecognizeTextRequest { request, error in
            guard let observations = request.results as?      [VNRecognizedTextObservation],
             error == nil else {return}
             let textFromPhoto = observations.compactMap({
             $0.topCandidates(1).first?.string
             }).joined(separator: ", ")
            self.descriptionTextField.text = textFromPhoto
        }
        do {
            try handler.perform([request])
        }
        catch {
            print("error recognizing image", error)
        }
    }
}
