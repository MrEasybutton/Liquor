import SwiftUI
import Liquor
// Neumorphism is based on some components from Costa Chung, adapted for modular use

@available(iOS 16.0, *)
public struct NeumorphicButton: View {
    private var title: String
    private var pressedEffect: SoftButtonPressedEffect
    private var cornerRadius: CGFloat
    private var backgroundColor: Color
    private var action: () -> Void

    public init(title: String,
                pressedEffect: SoftButtonPressedEffect = .hard,
                cornerRadius: CGFloat = 45,
                backgroundColor: Color = .white,
                action: @escaping () -> Void) {
        self.title = title
        self.pressedEffect = pressedEffect
        self.cornerRadius = cornerRadius
        self.action = action
        self.backgroundColor = backgroundColor
    }

    public var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.bold)
                .backgroundStyle(backgroundColor)
        }
        .softButtonStyle(RoundedRectangle(cornerRadius: cornerRadius), pressedEffect: pressedEffect)
    }
}

@available(iOS 16.0, *)
public struct NeumorphicSrcBar: View {
    @Binding private var text: String
    private var placeholder: String
    private var cornerRadius: CGFloat
    private var mainColor: Color
    private var secondaryColor: Color
    private var darkShadowColor: Color
    private var lightShadowColor: Color

    public init(text: Binding<String>,
                placeholder: String = "Search...",
                cornerRadius: CGFloat = 30,
                mainColor: Color = Color.gray.opacity(0.2).opacity(0.2),
                secondaryColor: Color = .black,
                darkShadowColor: Color = Color.black.opacity(0.6),
                lightShadowColor: Color = Color.gray.opacity(0.2)) {
        self._text = text
        self.placeholder = placeholder
        self.cornerRadius = cornerRadius
        self.mainColor = mainColor
        self.secondaryColor = secondaryColor
        self.darkShadowColor = darkShadowColor
        self.lightShadowColor = lightShadowColor
    }

    public var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(secondaryColor)
                .font(.body.weight(.bold))

            TextField(placeholder, text: $text)
                .foregroundColor(secondaryColor)
                .font(.headline)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(mainColor)
                .softInnerShadow(
                    RoundedRectangle(cornerRadius: cornerRadius),
                    darkShadow: darkShadowColor,
                    lightShadow: lightShadowColor,
                    spread: 0.05,
                    radius: 2
                )
        )
        .padding()
    }
}

public struct NeumorphicSearchBar: View {
    @Binding var text: String
    var placeholder: String
    var cornerRadius: CGFloat
    
    @Environment(\.colorScheme) var colorScheme
    
    public init(text: Binding<String>, placeholder: String, cornerRadius: CGFloat) {
        self._text = text
        self.placeholder = placeholder
        self.cornerRadius = cornerRadius
    }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(colorScheme == .dark ? Color.black : Color.white)
                .shadow(color: colorScheme == .dark ? Color.black.opacity(0.6) : Color.gray.opacity(0.3), radius: 10, x: 5, y: 5)
                .shadow(color: colorScheme == .dark ? Color.white.opacity(0.1) : Color.white.opacity(0.7), radius: 10, x: -5, y: -5)

            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding(.leading, 10)

                TextField(placeholder, text: $text)
                    .padding(10)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .background(Color.clear)
                    .cornerRadius(cornerRadius)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)

                if !text.isEmpty {
                    Button(action: {
                        text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .padding(.trailing, 10)
                    }
                }
            }
            .padding(.horizontal, 10)
        }
        .frame(height: 50)
    }
}

@available(iOS 16.0, *)
public struct NeumorphicToggle: View {
    @Binding private var isOn: Bool
    private var onColor: Color
    private var offColor: Color
    private var cornerRadius: CGFloat
    private var enabled: Bool

    public init(isOn: Binding<Bool>,
                onColor: Color = .green,
                offColor: Color = .gray,
                cornerRadius: CGFloat = 25,
                enabled: Bool = true) {
        self._isOn = isOn
        self.onColor = onColor
        self.offColor = offColor
        self.cornerRadius = cornerRadius
        self.enabled = enabled
    }

    public var body: some View {
        HStack {
            Text(isOn ? "ON" : "OFF")
                .fontWeight(.bold)
                .foregroundColor(isOn ? onColor : offColor)
            
            Spacer()
            
            Circle()
                .fill(isOn ? onColor : offColor)
                .frame(width: 30, height: 30)
                .softInnerShadow(Circle()).opacity(enabled ? 1.2 : 0.2)
                .onTapGesture {
                    withAnimation {
                        isOn.toggle()
                    }
                }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color.gray.opacity(0.2))
                .softInnerShadow(
                    RoundedRectangle(cornerRadius: cornerRadius),
                    darkShadow: Color.gray.opacity(0.4),
                    lightShadow: Color(.lightGray).opacity(0.2)
                )
        )
        .padding()
    }
}

@available(iOS 16.0, *)
public struct NeumorphicCard: View {
    private var title: String
    private var subtitle: String
    private var icon: String
    private var backgroundColor: Color
    private var cornerRadius: CGFloat

    public init(title: String,
                subtitle: String,
                icon: String = "person.fill",
                backgroundColor: Color = Color.gray.opacity(0.2),
                cornerRadius: CGFloat = 20) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
    }

    public var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(.blue)

            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)

                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(backgroundColor)
                .softOuterShadow()
        )
        .padding()
    }
}

@available(iOS 16.0, *)
public struct NeumorphicSlider: View {
    @Binding private var value: Double
    private var floor: Double
    private var ceil: Double
    private var range: ClosedRange<Double>
    private var color: Color

    public init(value: Binding<Double>,
                floor: Double,
                ceil: Double,
                range: ClosedRange<Double> = 0...100,
                color: Color = .blue) {
        self._value = value
        self.floor = floor
        self.ceil = ceil
        self.range = floor...ceil
        self.color = color
    }

    public var body: some View {
        VStack {
            Slider(value: $value, in: range)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray.opacity(0.2))
                        .softOuterShadow()
                )
                .accentColor(color)
            
            Text("Value: \(Int(value))")
                .fontWeight(.bold)
        }
        .padding()
    }
}

@available(iOS 16.0, *)
public struct NeumorphicFAB: View {
    private var icon: String
    private var color: Color
    private var action: () -> Void

    public init(icon: String = "plus",
                color: Color = .blue,
                action: @escaping () -> Void) {
        self.icon = icon
        self.color = color
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.title)
                .padding()
                .background(
                    Circle()
                        .fill(color)
                        .softOuterShadow()
                )
                .foregroundColor(.white)
        }
    }
}

@available(iOS 14.0, *)
public struct NeumorphicSpeedometerSlider: View {
    @Binding public var value: Double
    public var range: ClosedRange<Double>
    public var label: String
    public var trackColor: Color
    public var progressColor: Color
    public var enableHaptics: Bool
    
    @State private var rotationAngle: Double = 0
    private let trackWidth: CGFloat = 25
    private let pointerWidth: CGFloat = 25
    private let dialRadius: CGFloat = 125
    
    public init(value: Binding<Double>, range: ClosedRange<Double> = 0...100, label: String = "Speed",
                trackColor: Color = Color(white: 0.8), progressColor: Color = .blue, enableHaptics: Bool = true) {
        self._value = value
        self.range = range
        self.label = label
        self.trackColor = trackColor
        self.progressColor = progressColor
        self.enableHaptics = enableHaptics
    }
    
    public var body: some View {
        VStack {
            Text(label)
                .font(.headline)
                .foregroundColor(.black)
                .padding(.bottom, 48)
            
            ZStack {
                Circle()
                    .trim(from: 0.25, to: 0.75)
                    .stroke(lineWidth: trackWidth)
                    .foregroundColor(trackColor)
                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 5, y: 5)
                
                ProgressArc(value: normalizedValue)
                    .stroke(style: StrokeStyle(lineWidth: trackWidth, lineCap: .round))
                    .foregroundColor(progressColor)
                
                if normalizedValue > 0.1 {
                                    ProgressArc(value: normalizedValue)
                                        .stroke(style: StrokeStyle(lineWidth: trackWidth, lineCap: .round))
                                        .foregroundColor(progressColor)
                                }
                
                ForEach(0...10, id: \.self) { i in
                    Rectangle()
                        .fill(Color.gray.opacity(0.8))
                        .frame(width: 2, height: i % 5 == 0 ? 15 : 8)
                        .offset(y: -dialRadius + trackWidth/2 + 15)
                        .rotationEffect(.degrees(Double(i) * 18 - 90))
                }
                
                Text("\(Int(value.rounded()))")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: pointerWidth, height: pointerWidth)
                        .shadow(color: Color.black.opacity(0.2), radius: 3, x: 2, y: 2)
                        .shadow(color: Color.white.opacity(0.7), radius: 3, x: -2, y: -2)
                    
                    Rectangle()
                        .fill(progressColor)
                        .frame(width: 4, height: pointerWidth/2)
                        .offset(y: -pointerWidth/4)
                }
                .offset(y: -dialRadius + trackWidth/2)
                .rotationEffect(.degrees(rotationAngle))
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { gesture in
                            updateFromDrag(gesture)
                        }
                )
            }
            .frame(width: dialRadius * 2, height: dialRadius)
            .padding()
            .onAppear {
                rotationAngle = angleForValue(value)
            }
            .onChange(of: value) { newValue in
                withAnimation(.spring()) {
                    rotationAngle = angleForValue(newValue)
                }
            }
        }
    }
    
    private var normalizedValue: Double {
        (value - range.lowerBound) / (range.upperBound - range.lowerBound)
    }
    
    private func angleForValue(_ value: Double) -> Double {
        let normalizedValue = (value - range.lowerBound) / (range.upperBound - range.lowerBound)
        return normalizedValue * 180 - 90
    }
    
    private func valueForAngle(_ angle: Double) -> Double {
        let clampedAngle = max(-90, min(90, angle))
        let normalizedValue = (clampedAngle + 90) / 180
        return range.lowerBound + normalizedValue * (range.upperBound - range.lowerBound)
    }
    
    private func updateFromDrag(_ gesture: DragGesture.Value) {
        let center = CGPoint(x: dialRadius, y: 0)
        let dragVector = CGPoint(x: gesture.location.x - center.x, y: gesture.location.y - center.y)
        var angle = atan2(dragVector.x, -dragVector.y) * 180 / .pi
        angle = max(-90, min(90, angle))
        
        withAnimation(.interactiveSpring()) {
            rotationAngle = angle
            value = valueForAngle(angle)
            
            if enableHaptics && (abs(angle - 90) < 5 || abs(angle + 90) < 5) {
                let generator = UIImpactFeedbackGenerator(style: .soft)
                generator.impactOccurred()
            }
        }
    }
}

public struct ProgressArc: Shape {
    var value: Double
    
    public init(value: Double) {
        self.value = value
    }
    
    public func path(in rect: CGRect) -> Path {
        let startAngle = Angle(degrees: 180)
        let endAngle = Angle(degrees: 180 - value * 180)
        
        return Path { path in
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.width / 2,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: true
            )
        }
    }
    
    public var animatableData: Double {
        get { value }
        set { value = newValue }
    }
}


@available(iOS 16.0, *)
public struct NeumorphicSwitch: View {
    @Binding private var isOn: Bool
    private var onColor: Color
    private var offColor: Color
    private var cornerRadius: CGFloat

    public init(isOn: Binding<Bool>,
                onColor: Color = .green,
                offColor: Color = .gray,
                cornerRadius: CGFloat = 20) {
        self._isOn = isOn
        self.onColor = onColor
        self.offColor = offColor
        self.cornerRadius = cornerRadius
    }

    public var body: some View {
        HStack {
            Text(isOn ? "ON" : "OFF")
                .fontWeight(.bold)
                .foregroundColor(isOn ? onColor : offColor)

            Spacer()

            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(isOn ? onColor : offColor)
                .frame(width: 50, height: 30)
                .overlay(
                    Circle()
                        .fill(Color.white)
                        .frame(width: 25, height: 25)
                        .offset(x: isOn ? 10 : -10)
                        .padding(2)
                )
                .onTapGesture {
                    withAnimation {
                        isOn.toggle()
                    }
                }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color.gray.opacity(0.2))
                .softOuterShadow()
        )
        .padding()
    }
}

// Aquaporin

public protocol TabItem: CaseIterable, Hashable, RawRepresentable where RawValue == String {
    var title: String { get }
    var icon: String { get }
}
public extension TabItem { var title: String { return rawValue } }

@available(iOS 16.0, *)
public struct AquaporinConfiguration {
    public var activeTint: Color
    public var inactiveTint: Color
    public var activeIconScale: CGFloat
    public var inactiveIconScale: CGFloat

    public var backgroundGradient: LinearGradient
    public var shadowColor: Color
    public var shadowRadius: CGFloat
    public var blurRadius: CGFloat

    public var animationResponse: Double
    public var animationDampingFraction: Double
    public var animationBlendDuration: Double

    public var horizontalPadding: CGFloat

    public init(
        activeTint: Color = .red,
        inactiveTint: Color = .gray.opacity(0.8),
        activeIconScale: CGFloat = 60,
        inactiveIconScale: CGFloat = 35,
        backgroundGradient: LinearGradient = LinearGradient(
            colors: [.gray.opacity(0.3), .gray.opacity(0.6)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        ),
        shadowColor: Color = .red.opacity(0.2),
        shadowRadius: CGFloat = 5,
        blurRadius: CGFloat = 0.8,
        animationResponse: Double = 0.6,
        animationDampingFraction: Double = 0.8,
        animationBlendDuration: Double = 0.4,
        horizontalPadding: CGFloat = 15
    ) {
        self.activeTint = activeTint
        self.inactiveTint = inactiveTint
        self.activeIconScale = activeIconScale
        self.inactiveIconScale = inactiveIconScale
        self.backgroundGradient = backgroundGradient
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.blurRadius = blurRadius
        self.animationResponse = animationResponse
        self.animationDampingFraction = animationDampingFraction
        self.animationBlendDuration = animationBlendDuration
        self.horizontalPadding = horizontalPadding
    }

    public static var standard: AquaporinConfiguration {
        AquaporinConfiguration()
    }

    public static var dark: AquaporinConfiguration {
        AquaporinConfiguration(
            activeTint: .blue,
            inactiveTint: .gray.opacity(0.6),
            backgroundGradient: LinearGradient(
                colors: [.black.opacity(0.6), .black.opacity(0.8)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ),
            shadowColor: .blue.opacity(0.3)
        )
    }

    public static var light: AquaporinConfiguration {
        AquaporinConfiguration(
            activeTint: .blue,
            inactiveTint: .gray.opacity(0.4),
            backgroundGradient: LinearGradient(
                colors: [.white.opacity(0.8), .gray.opacity(0.2)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ),
            shadowColor: .blue.opacity(0.2)
        )
    }
}

@available(iOS 16.0, *)
public struct Aquaporin<T: TabItem>: View {
    @Binding public var activeTab: T
    public var configuration: AquaporinConfiguration

    @Namespace private var animation
    @State private var tabShapePos: CGPoint = .zero

    public init(activeTab: Binding<T>, configuration: AquaporinConfiguration = .standard) {
        self._activeTab = activeTab
        self.configuration = configuration
    }

    public var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(Array(T.allCases), id: \.self) { tab in
                EZTabItem(
                    tint: configuration.activeTint,
                    inactiveTint: configuration.inactiveTint,
                    title: tab.title,
                    icon: tab.icon,
                    animation: animation,
                    isActive: activeTab == tab,
                    activeScale: configuration.activeIconScale,
                    inactiveScale: configuration.inactiveIconScale,
                    position: $tabShapePos,
                    action: { activeTab = tab }
                )
            }
        }
        .padding(.horizontal, configuration.horizontalPadding)
        .background {
            TabShape(midpoint: tabShapePos.x)
                .fill(configuration.backgroundGradient)
                .ignoresSafeArea()
                .shadow(
                    color: configuration.shadowColor,
                    radius: configuration.shadowRadius,
                    x: 0,
                    y: -2
                )
                .blur(radius: configuration.blurRadius)
                .padding(.top, 5)
        }
        .animation(
            .interactiveSpring(
                response: configuration.animationResponse,
                dampingFraction: configuration.animationDampingFraction,
                blendDuration: configuration.animationBlendDuration
            ),
            value: activeTab
        )
    }
}

@available(iOS 16.0, *)
public struct EZTabItem: View {
    public var tint: Color
    public var inactiveTint: Color
    public var title: String
    public var icon: String
    public var animation: Namespace.ID
    public var isActive: Bool
    public var activeScale: CGFloat
    public var inactiveScale: CGFloat
    @Binding public var position: CGPoint
    public var action: () -> Void

    @State private var tabPos: CGPoint = .zero

    public var body: some View {
        VStack(spacing: 0) {
            Image(systemName: icon)
                .font(.title)
                .shadow(radius: 8)
                .foregroundStyle(isActive ? .white : inactiveTint)
                .frame(width: isActive ? activeScale : inactiveScale, height: isActive ? activeScale : inactiveScale)
                .background {
                    if isActive {
                        Capsule(style: .continuous)
                            .fill(tint.gradient)
                            .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                    }
                }

            Text(title)
                .font(.caption)
                .foregroundStyle(isActive ? tint : inactiveTint.opacity(0.75))
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .viewPosition(completion: { rect in
            tabPos.x = rect.midX

            if isActive {
                position.x = rect.midX
            }
        })
        .onTapGesture {
            action()

            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.8)) {
                position.x = tabPos.x
            }
        }
    }
}

@available(iOS 16.0, *)
public struct TabShape: Shape {
    var midpoint: CGFloat
    
    public var animatableData: CGFloat {
        get { midpoint }
        set { midpoint = newValue }
    }
    
    public func path(in rect: CGRect) -> Path {
        return Path { path in
            path.addPath(Rectangle().path(in: rect))
            
            path.move(to: .init(x: midpoint - 60, y: 0))
            
            let to = CGPoint(x: midpoint, y: -20)
            let control1 = CGPoint(x: midpoint - 25, y: 0)
            let control2 = CGPoint(x: midpoint - 25, y: -20)
            
            path.addCurve(to: to, control1: control1, control2: control2)
            
            let to1 = CGPoint(x: midpoint + 60, y: 0)
            let control3 = CGPoint(x: midpoint + 25, y: -20)
            let control4 = CGPoint(x: midpoint + 25, y: 0)
            
            path.addCurve(to: to1, control1: control3, control2: control4)
        }
    }
}

public struct PositionKey: PreferenceKey {
    public static let defaultValue: CGRect = .zero
    
    public static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}


@available(iOS 16.0, *)
extension View {
    @ViewBuilder
    func viewPosition(completion: @escaping (CGRect) -> ()) -> some View {
        self
            .overlay {
                GeometryReader {
                    let rect = $0.frame(in: .global)
                    
                    Color.clear
                        .preference(key: PositionKey.self, value: rect)
                        .onPreferenceChange(PositionKey.self, perform: completion)
                }
            }
    }
}

@available(iOS 16.0, *)
public struct CompactTabBar<T: TabItem>: View {
    @Binding public var activeTab: T
    let tabColors: [T: Color]
    
    public init(activeTab: Binding<T>, tabColors: [T: Color] = [:]) {
        self._activeTab = activeTab
        self.tabColors = tabColors
    }
    
    public var body: some View {
        TabsLayoutView(activeTab: $activeTab, tabColors: tabColors)
            .padding()
            .background {
                Capsule()
                    .fill(.ultraThinMaterial) // Glassmorphism effect
                    .environment(\.colorScheme, .light)
                    .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
            }
            .frame(height: 70)
    }
}

@available(iOS 16.0, *)
fileprivate struct TabsLayoutView<T: TabItem>: View {
    @Binding var activeTab: T
    @Namespace var namespace
    let tabColors: [T: Color]
    
    var body: some View {
        HStack {
            ForEach(Array(T.allCases), id: \.self) { tab in
                TabButton(
                    tab: tab,
                    activeTab: $activeTab,
                    namespace: namespace,
                    color: tabColors[tab] ?? .blue
                )
            }
        }
    }
}

@available(iOS 16.0, *)
private struct TabButton<T: TabItem>: View {
    let tab: T
    @Binding var activeTab: T
    var namespace: Namespace.ID
    let color: Color
    
    var body: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                activeTab = tab
            }
        } label: {
            ZStack {
                if isSelected {
                    Capsule()
                        .fill(color.opacity(0.2))
                        .matchedGeometryEffect(id: "SelectedTab", in: namespace)
                }
                
                HStack(spacing: 10) {
                    Image(systemName: tab.icon)
                        .font(.system(size: 24, weight: .semibold, design: .rounded))
                        .foregroundColor(isSelected ? color : .black.opacity(0.6))
                        .scaleEffect(isSelected ? 1 : 0.8)
                        .animation(.spring(response: 0.2), value: isSelected)
                        .opacity(isSelected ? 1 : 0.7)
                        .padding(.leading, isSelected ? 8 : 0)
                        .padding(.horizontal, activeTab != tab ? 8 : 0)
                    
                    if isSelected {
                        Text(tab.title)
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundColor(color)
                            .transition(.opacity)
                    }
                }
                .padding(.vertical, 8)
            }
        }
        .buttonStyle(.borderless)
    }
    
    private var isSelected: Bool {
        activeTab == tab
    }
}
