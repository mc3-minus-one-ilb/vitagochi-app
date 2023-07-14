//
//  UIKitPickerView.swift
//  Vitagochi
//
//  Created by Dzulfikar on 12/07/23.
//

import SwiftUI
import UIKit

struct TimePickerView: UIViewRepresentable {
    var data: [[String]]
    @Binding var selections: [Int]
    
    //makeCoordinator()
    func makeCoordinator() -> TimePickerView.Coordinator {
        Coordinator(self)
    }

    //makeUIView(context:)
    func makeUIView(context: UIViewRepresentableContext<TimePickerView>) -> UIPickerView {
        let picker = UIPickerView(frame: .zero)
        
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator
        
        return picker
    }

    //updateUIView(_:context:)
    func updateUIView(_ view: UIPickerView, context: UIViewRepresentableContext<TimePickerView>) {
        for i in 0...(self.selections.count - 1) {
            view.selectRow(self.selections[i], inComponent: i, animated: false)
        }
        context.coordinator.parent = self // fix
    }
    
    class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        var parent: TimePickerView
        
        //init(_:)
        init(_ pickerView: TimePickerView) {
            self.parent = pickerView
        }
        
        //numberOfComponents(in:)
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return self.parent.data.count
        }
        
        //pickerView(_:numberOfRowsInComponent:)
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return self.parent.data[component].count
        }
        
        //pickerView(_:titleForRow:forComponent:)
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            let transparent = UIColor(red: 255.0 , green: 255.0, blue: 255.0, alpha: 0.0)
            pickerView.subviews[1].backgroundColor = transparent
            
            return self.parent.data[component][row]
        }
        
        //pickerView(_:didSelectRow:inComponent:)
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            self.parent.selections[component] = row
        }
            
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
                let label: UILabel
                if let view = view as? UILabel {
                    label = view
                } else {
                    label = UILabel()
                }

                label.textColor = .black
                label.textAlignment = .center
                label.font = UIFont.systemFont(ofSize: 25)

                let componentData = self.parent.data[component]
                let title = componentData[row]

                label.text = title

                // Adjust the spacing between components
                let attributedString = NSMutableAttributedString(string: title)
                let range = NSRange(location: 0, length: title.count)
                attributedString.addAttribute(NSAttributedString.Key.kern, value: -1.5, range: range)
                label.attributedText = attributedString

                return label
            }
    }
}

import SwiftUI

struct UIKitPickerView: View {
    private let data: [[String]] = [
        Array(0...11).map { "\($0)" },
        Array(0...59).map { "\($0)" },
        ["AM", "PM"].map { "\($0)" }
    ]
    
    @State private var selections: [Int] = [5, 10, 0]

    var body: some View {
        VStack {
            TimePickerView(data: self.data, selections: self.$selections)

            Text("\(self.data[0][self.selections[0]]) \(self.data[1][self.selections[1]]) \(self.data[2][self.selections[2]])")
        } //VStack
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UIKitPickerView()
    }
}
