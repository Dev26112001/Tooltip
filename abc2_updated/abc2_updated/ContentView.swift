import SwiftUI

struct ContentView: View {
    @State private var tooltipVisible: Bool = false
    @State private var tooltipPosition: TooltipPosition = .top
    @State private var tooltipText: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView{
                VStack {
                    //                Color.white.edgesIgnoringSafeArea(.all)
                    
                    //                VStack(alignment: .leading, spacing: 20) {
                    
                    //                    Spacer()
                    
                    HStack(alignment: .top) {
                        //                        Spacer()
                        TooltipButton(title: "Top Left", position: .top, geometry: geometry, onTap: showTooltip)
                        
                        Spacer()
                        TooltipButton(title: "Top Right", position: .top, geometry: geometry, onTap: showTooltip)
                    }.padding(24)
                    
                    Spacer()
                    
                    HStack(alignment: .center) {
                        TooltipButton(title: "Center", position: .center, geometry: geometry, onTap: showTooltip)
                        
                    }.padding(24)
                    
                    Spacer()
                    
                    HStack(alignment: .bottom) {
                        TooltipButton(title: "Bottom Left", position: .left, geometry: geometry, onTap: showTooltip)
                        Spacer()
                        TooltipButton(title: "Bottom Right", position: .right, geometry: geometry, onTap: showTooltip)
                    }.padding(24)
                    
                    
                }
            }
            .navigationBarHidden(true)
            .onTapGesture {
                hideTooltip()
            }
            .overlay(
                tooltipVisible ? TooltipView(position: tooltipPosition, text: tooltipText) : nil
            )
        }
    }
        
        private func showTooltip(title: String, position: TooltipPosition) {
            tooltipVisible = true
            tooltipPosition = position
            tooltipText = "\(title)"
        }
        
        private func hideTooltip() {
            tooltipVisible = false
        }
    
}

enum TooltipPosition {
    case top, left, center, right, bottom
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TooltipButton: View {
    let title: String
    let position: TooltipPosition
    let geometry: GeometryProxy
    let onTap: (String, TooltipPosition) -> Void
    
    var body: some View {
        Button(action: {
            onTap(title, position)
        }) {
            Text(title)
                .font(.system(size: 18))
                .foregroundColor(.white)
                .frame(width: 100, height: 50)
                .background(Color.gray)
                .cornerRadius(8)
        }
        .overlay(
            GeometryReader { buttonGeometry in
                Color.clear
                    .onAppear {
                        let buttonFrame = buttonGeometry.frame(in: .global)
                        let tooltipX = buttonFrame.midX
                        let tooltipY = buttonFrame.midY
                        let tooltipWidth: CGFloat = 150
                        let tooltipHeight: CGFloat = 60
                        
                        let adjustedX = max(min(tooltipX, geometry.size.width - tooltipWidth / 2), tooltipWidth / 2)
                        let adjustedY = max(min(tooltipY, geometry.size.height - tooltipHeight / 2), tooltipHeight / 2)
                        
                        let tooltipPosition: TooltipPosition
                        
                        switch position {
                        case .top, .bottom:
                            tooltipPosition = adjustedX < geometry.size.width / 2 ? .left : .right
                        case .left, .right:
                            tooltipPosition = adjustedY < geometry.size.height / 2 ? .top : .bottom
                        case .center:
                            tooltipPosition = .center
                        }
                        
                        onTap(title, tooltipPosition)
                    }
            }
        )
    }
}

struct TooltipView: View {
    let position: TooltipPosition
    let text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.black)
                .opacity(0.8)
            
            VStack {
                Text(text)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Image(systemName: "info.circle")
                    .foregroundColor(.white)
            }
        }
        .frame(width: 150, height: 60)
        .position(tooltipPosition())
        .animation(.easeInOut)
    }
    
    private func tooltipPosition() -> CGPoint {
        switch position {
        case .top:
            return CGPoint(x: UIScreen.main.bounds.midX, y: 30)
        case .left:
            return CGPoint(x: 30, y: UIScreen.main.bounds.midY)
        case .center:
            return CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        case .right:
            return CGPoint(x: UIScreen.main.bounds.width - 30, y: UIScreen.main.bounds.midY)
        case .bottom:
            return CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.height - 30)
        }
    }
}
