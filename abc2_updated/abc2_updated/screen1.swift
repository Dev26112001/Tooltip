import SwiftUI

struct screen1: View {
    @State private var selectedTarget = "Button"
    @State private var tooltipText = ""
    @State private var textSize = 16
    @State private var paddingValue = 10
    @State private var selectedTextColor = Color.black
    @State private var selectedBackgroundColor = Color.white
    @State private var cornerRadius = 8
    @State private var tooltipWidth = 150
    @State private var arrowWidth = 20
    @State private var arrowHeight = 10
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Target Element")) {
                    Picker("Target Element", selection: $selectedTarget) {
                        Text("Button1").tag("Button")
                        Text("Button2").tag("Image")
                        Text("Button3").tag("Label")
                        Text("Button4").tag("Label")
                        Text("Button5").tag("Label")
                    }
                    .pickerStyle(.menu)
                }
                
                Section(header: Text("Tooltip Text")) {
                    TextField("Enter Tooltip Text", text: $tooltipText)
                }
                
                Section(header: Text("Text Size and Padding")) {
                    Stepper("Text Size: \(textSize)", value: $textSize, in: 12...36)
                    Stepper("Padding: \(paddingValue)", value: $paddingValue, in: 0...20)
                }
                
                Section(header: Text("Text Colour")) {
                    ColorPicker("Select Text Colour", selection: $selectedTextColor)
                }
                
                Section(header: Text("Background Colour")) {
                    ColorPicker("Select Background Colour", selection: $selectedBackgroundColor)
                }
                
                Section(header: Text("Corner Radius and Tooltip Width")) {
                    Stepper("Corner Radius: \(cornerRadius)", value: $cornerRadius, in: 0...20)
                    Stepper("Tooltip Width: \(tooltipWidth)", value: $tooltipWidth, in: 100...300)
                }
                
                Section(header: Text("Arrow Width and Height")) {
                    Stepper("Arrow Width: \(arrowWidth)", value: $arrowWidth, in: 10...50)
                    Stepper("Arrow Height: \(arrowHeight)", value: $arrowHeight, in: 5...20)
                }
                NavigationLink( destination: ContentView()) {
                    Button(action: {
                        // Action to render tooltip
                        print("Render Tooltip")
                    }) {
                        Text("Render Tooltip")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            .navigationBarTitle("Dynamic Tooltip Form")
            .navigationBarHidden(true)
        }
    }
}

struct screen1_Previews: PreviewProvider {
    static var previews: some View {
        screen1()
    }
}
