//
//  BTOrderTicketVC.swift
//  Bit Trader
//
//  Created by Varoon Behramsha on 17/01/20.
//  Copyright © 2020 Varoon Behramsha. All rights reserved.
//

import UIKit

class BTOrderTicketVC: UIViewController {

	@IBOutlet weak var sellingPriceLabel: UILabel!
	@IBOutlet weak var buyingPriceLabel: UILabel!
	@IBOutlet weak var spreadLabel: UILabel!
	@IBOutlet weak var unitsTextField: UITextField!
	@IBOutlet weak var amountTextField: UITextField!
	@IBOutlet weak var confirmButton: UIButton!
	
	private var presenter:OrderTicketPresenterProtocol!
	private var timer : Timer?
	private var tagForLastUsedTextField = 0
	
	override func viewDidLoad() {
        super.viewDidLoad()

		self.unitsTextField.delegate = self
		self.amountTextField.delegate = self
		self.unitsTextField.layer.borderColor = BTColor.textfieldBorder.cgColor
		self.amountTextField.layer.borderColor = BTColor.textfieldBorder.cgColor
		self.unitsTextField.layer.cornerRadius = self.unitsTextField.frame.width / 25
		self.amountTextField.layer.cornerRadius = self.amountTextField.frame.width / 25
		self.confirmButton.layer.cornerRadius = self.confirmButton.frame.width / 25
		self.confirmButton.backgroundColor = BTColor.disabledButton
		
		//Add gesture recogniser to the view for dismissing keypad
		let gestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(hideKeypad))
		self.view.addGestureRecognizer(gestureRecogniser)
		
        // Do any additional setup after loading the view.
		let priceService = BTPriceService(networkManager: NetworkManager<BlockchainAPI>())
		self.presenter = BTOrderTicketPresenter(priceService: priceService)
		self.setupTimerToLoadData()
		
    }
	
	


	@IBAction func textDidChange(_ sender: UITextField) {
		self.updateUnitAndAmount()
	}
	
	//MARK : - Helper Methods
	
	func setupTimerToLoadData()
	{
		self.timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (timer) in
			self.presenter.loadData({ (successful, statusMessage) in
				DispatchQueue.main.async {
					if successful
					{
							self.setupUI()
					}else
					{
						let alertController = UIAlertController(title: "Error", message: statusMessage, preferredStyle: .alert)
						alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
						self.present(alertController, animated: true, completion: nil)
					}
				}
				
			})
		})
		self.timer?.fire()
	}
	
	func setupUI()
	{
		
		
		self.sellingPriceLabel.attributedText = self.presenter.sellingPrice//self.presenter.sellingPriceLHS
		self.buyingPriceLabel.attributedText = self.presenter.buyingPrice
		self.spreadLabel.text = self.presenter.spread
		

		UIView.transition(with: self.sellingPriceLabel, duration: 0.3, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
			self.sellingPriceLabel.textColor = UIColor.green
			
		}) { (completed) in
			UIView.transition(with: self.sellingPriceLabel, duration: 1, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
				self.sellingPriceLabel.textColor = UIColor.gray
			}) { (completed) in
				
			}
		}
		UIView.transition(with: self.buyingPriceLabel, duration: 0.3, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
			self.buyingPriceLabel.textColor = UIColor.green
			
		}) { (completed) in
			UIView.transition(with: self.buyingPriceLabel, duration: 1, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
				self.buyingPriceLabel.textColor = UIColor.gray
			}) { (completed) in
				
			}
		}
		
		self.updateUnitAndAmount()
	}

	func updateConfirmButtonUI()
	{
		if self.amountTextField.text!.isEmpty || self.unitsTextField.text!.isEmpty
		{
			self.confirmButton.isEnabled = false
			self.confirmButton.backgroundColor = BTColor.disabledButton
		}else
		{
			self.confirmButton.isEnabled = true
			self.confirmButton.backgroundColor = BTColor.enabledButton
		}
	}
	
	@objc func hideKeypad()
	{
		self.view.endEditing(true)
	}
	
	func updateUnitAndAmount()
	{
		
		
		switch self.tagForLastUsedTextField {
		case 0:
			//Units Text Field
			//Update amount text field
			guard !self.amountTextField.isFirstResponder else
			{
				//User is currently inputting values
				return
			}
			
			if let units = Double(self.unitsTextField.text!)
			{
				self.amountTextField.text = self.presenter.amountFor(units: units)
			}else
			{
				self.amountTextField.text = ""
			}
			
		case 1:
			//Amount Text Field
			guard !self.unitsTextField.isFirstResponder else
			{
				//User is currently inputting values
				return
			}
			if let amount = Double(self.amountTextField.text!)
			{
				self.unitsTextField.text = self.presenter.unitsFor(amount: amount)
			}else
			{
				self.unitsTextField.text = ""
			}
		default:
			break
		}
	}
	
	deinit {
		//End Timer
		self.timer?.invalidate()
	}
}

extension BTOrderTicketVC : UITextFieldDelegate
{
	func textFieldDidBeginEditing(_ textField: UITextField) {
		textField.layer.borderWidth = 1.0
		self.tagForLastUsedTextField = textField.tag
	}
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		if string.isEmpty
		{
			//User is clearing the text
			return true
		}
		
		if textField.text!.split(separator: ".").count > 1
		{
			if textField.text!.split(separator: ".").last!.count < 2
			{

				return true
			}
			else
			{
				return false
			}
		}
		return true
	}
	

	func textFieldDidEndEditing(_ textField: UITextField) {
		textField.layer.borderWidth = 0
		self.updateConfirmButtonUI()
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
}
