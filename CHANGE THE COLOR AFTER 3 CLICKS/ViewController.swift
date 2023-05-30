//
//  ViewController.swift
//  CHANGE THE COLOR AFTER 3 CLICKS
//
//  Created by Narayan on 30/05/23.
//

import UIKit
import RxSwift
import RxRelay

class ViewController: UIViewController {
	let disposeBag = DisposeBag()
	let maxClicks = 3


	//BehaviorRelay is a class provided by the RxSwift framework. It is a type of Subject that wraps a value and allows observers to subscribe and receive the current value as well as subsequent updates.
	var tap = BehaviorRelay<Int>(value: 0)

	@IBAction func btn(_ sender: Any) {
		tap.accept(tap.value + 1)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupColorChange()
	}



	func setupColorChange() {
		tap
			.asObservable()
			.buffer(timeSpan: .seconds(1), count: 3, scheduler: MainScheduler.instance)
			.filter { $0.count == self.maxClicks }
			.subscribe(onNext: { _ in
				    self.view.backgroundColor = .green
			}).disposed(by: disposeBag)
		
	}
}


	//asObservable() is a method provided by RxSwift that converts a BehaviorRelay into an Observable sequence. It allows you to expose the value of a BehaviorRelay as an observable stream

	//Subscribe to an observable so that whenever its value changes, perform the operations defined in the subscription.

	//	subscribe is a method provided by RxSwift to subscribe to an Observable sequence. When you subscribe to an observable, you provide a closure (also called an observer) that defines how to handle the emitted values from the sequence.
    // disposed refers to the state of a subscription or a disposable resource in RxSwift. When a subscription is disposed, it means that it has been terminated, and no further events will be received.

    // we will dispose because for better memory management


	// buffer collects the number of events and proceeds after the number of count events are fullfilled
