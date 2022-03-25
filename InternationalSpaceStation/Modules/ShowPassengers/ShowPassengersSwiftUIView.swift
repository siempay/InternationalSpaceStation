//
//  ShowPassengersSwiftUIView.swift
//  InternationalSpaceStation
//
//  Created by Brahim Elmssilha on 24/3/2022.
//

import SwiftUI

struct ShowPassengersSwiftUIView: View {
	
	var delegate: ShowPassengersViewControllerDelegate?
	
	var title: String {
		"Number of people \(passengers?.number ?? 0)"
	}
	
	var passengers: ShowPassengerEntity?
	
	@State var toggle: Bool = false
	
	var body: some View {
		NavigationView {
			Button(
				(toggle ? "Text" : "False")
			) {
				toggle.toggle()
			}
			List {
				ForEach(passengers?.people ?? [], id: \.name) { item in
					HStack {
						Text(item.name)
						Spacer()
						Text(item.craft).foregroundColor(.gray)
					}
				}
			}
			.navigationTitle(title)
			.navigationBarTitleDisplayMode(.inline)
			.listStyle(.sidebar)
			
		}
		
		
	}
	
	func setVar() {
		
		toggle.toggle()
	}
}

struct ShowPassengersSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
		ShowPassengersSwiftUIView(passengers: .init(number: 3, people: [.init(craft: "707", name: "Brahim")]))
    }
}
