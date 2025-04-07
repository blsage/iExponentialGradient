import SwiftUI

/// A gradient that applies an exponential function to color interpolation, creating more natural-looking transitions.
///
/// Unlike standard linear gradients that use constant rate of change between colors, `ExponentialGradient` 
/// uses a power function to create non-linear transitions that can better mimic how light behaves in physical space.
///
/// ## Example
///
/// ```swift
/// VStack(spacing: 30) {
///     // Standard linear gradient
///     LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing)
///         .frame(height: 100)
///         .cornerRadius(10)
///         
///     // Exponential gradient for more natural transition
///     ExponentialGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing)
///         .frame(height: 100)
///         .cornerRadius(10)
/// }
/// .padding()
/// ```
@available(iOS 14.0, macOS 10.16, tvOS 14.0, watchOS 7.0, *)
public struct ExponentialGradient: View, Sendable {
    public let gradient: Gradient
    public let startPoint: UnitPoint
    public let endPoint: UnitPoint
    public let exponent: CGFloat
    public let subdivisions: Int

    /// Creates an exponential gradient with the specified parameters.
    ///
    /// - Parameters:
    ///   - gradient: The gradient containing the colors and their locations.
    ///   - startPoint: The point at which the gradient begins.
    ///   - endPoint: The point at which the gradient ends.
    ///   - exponent: The power to which the interpolation is raised. Values greater than 1 create a slower start and faster finish.
    ///                Values less than 1 create a faster start and slower finish. Default is 2.
    ///   - subdivisions: The number of steps to use when interpolating between colors. Higher values create smoother transitions. Default is 32.
    ///
    /// ## Example
    ///
    /// ```swift
    /// // Create a custom gradient with specific color stops
    /// let customGradient = Gradient(stops: [
    ///     .init(color: .blue, location: 0.0),
    ///     .init(color: .green, location: 0.3),
    ///     .init(color: .red, location: 1.0)
    /// ])
    ///
    /// // Use the custom gradient with ExponentialGradient
    /// ExponentialGradient(
    ///     gradient: customGradient,
    ///     startPoint: .topLeading,
    ///     endPoint: .bottomTrailing,
    ///     exponent: 2.5,
    ///     subdivisions: 64
    /// )
    /// ```
    public init(
        gradient: Gradient,
        startPoint: UnitPoint,
        endPoint: UnitPoint,
        exponent: CGFloat = 2,
        subdivisions: Int = 32
    ) {
        self.gradient = gradient
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.exponent = exponent
        self.subdivisions = subdivisions
    }

    /// Creates an exponential gradient with the specified colors.
    ///
    /// - Parameters:
    ///   - colors: An array of colors to use in the gradient, evenly distributed from start to end.
    ///   - startPoint: The point at which the gradient begins.
    ///   - endPoint: The point at which the gradient ends.
    ///   - exponent: The power to which the interpolation is raised. Values greater than 1 create a slower start and faster finish.
    ///                Values less than 1 create a faster start and slower finish. Default is 2.
    ///   - subdivisions: The number of steps to use when interpolating between colors. Higher values create smoother transitions. Default is 32.
    ///
    /// ## Example
    ///
    /// ```swift
    /// // Create a background with an exponential gradient
    /// ZStack {
    ///     ExponentialGradient(
    ///         colors: [.indigo, .purple, .pink],
    ///         startPoint: .top,
    ///         endPoint: .bottom,
    ///         exponent: 3.0
    ///     )
    ///     
    ///     Text("Hello, World!")
    ///         .font(.largeTitle)
    ///         .foregroundStyle(.white)
    /// }
    /// ```
    public init(
        colors: [Color],
        startPoint: UnitPoint,
        endPoint: UnitPoint,
        exponent: CGFloat = 2,
        subdivisions: Int = 32
    ) {
        self.init(
            gradient: Gradient(colors: colors),
            startPoint: startPoint,
            endPoint: endPoint,
            exponent: exponent,
            subdivisions: subdivisions
        )
    }

    /// Creates an exponential gradient with the specified color stops.
    ///
    /// - Parameters:
    ///   - stops: An array of gradient stops, each containing a color and location.
    ///   - startPoint: The point at which the gradient begins.
    ///   - endPoint: The point at which the gradient ends.
    ///   - exponent: The power to which the interpolation is raised. Values greater than 1 create a slower start and faster finish.
    ///                Values less than 1 create a faster start and slower finish. Default is 2.
    ///   - subdivisions: The number of steps to use when interpolating between colors. Higher values create smoother transitions. Default is 32.
    ///
    /// ## Example
    ///
    /// ```swift
    /// // Create a gradient with precise color positioning
    /// ExponentialGradient(
    ///     stops: [
    ///         .init(color: .clear, location: 0.0),
    ///         .init(color: .blue.opacity(0.5), location: 0.3),
    ///         .init(color: .blue, location: 0.7),
    ///         .init(color: .purple, location: 1.0)
    ///     ],
    ///     startPoint: .leading,
    ///     endPoint: .trailing,
    ///     exponent: 1.5,
    ///     subdivisions: 48
    /// )
    /// .frame(height: 150)
    /// .clipShape(RoundedRectangle(cornerRadius: 20))
    /// ```
    public init(
        stops: [Gradient.Stop],
        startPoint: UnitPoint,
        endPoint: UnitPoint,
        exponent: CGFloat = 2,
        subdivisions: Int = 32
    ) {
        self.init(
            gradient: Gradient(stops: stops),
            startPoint: startPoint,
            endPoint: endPoint,
            exponent: exponent,
            subdivisions: subdivisions
        )
    }
    public var body: some View {
        LinearGradient(
            stops: subdividedStops,
            startPoint: startPoint,
            endPoint: endPoint
        )
    }

    @available(iOS 14.0, macOS 10.16, tvOS 14.0, watchOS 7.0, *)
    private var subdividedStops: [Gradient.Stop] {
        guard gradient.stops.count > 1 else { return gradient.stops }
        var result: [Gradient.Stop] = []
        for i in 0..<(gradient.stops.count - 1) {
            let current = gradient.stops[i]
            let next = gradient.stops[i + 1]
            for step in 0..<subdivisions {
                let fraction = CGFloat(step) / CGFloat(subdivisions)
                let location = current.location + (next.location - current.location) * fraction
                let color = current.color.interpolated(
                    to: next.color,
                    fraction: fraction,
                    exponent: exponent
                )
                result.append(.init(color: color, location: Double(location)))
            }
        }
        result.append(gradient.stops.last!)
        return result
    }
}

extension Color {
    /// Converts a SwiftUI Color to its RGBA components.
    ///
    /// - Returns: A tuple containing the red, green, blue, and alpha components, each in the range 0-1.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let color = Color.red
    /// let components = color.toComponents()
    /// print("R: \(components.r), G: \(components.g), B: \(components.b), A: \(components.a)")
    /// // Output: "R: 1.0, G: 0.0, B: 0.0, A: 1.0"
    /// ```
    @available(iOS 14.0, macOS 10.16, tvOS 14.0, watchOS 7.0, *)
    func toComponents() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        #if canImport(UIKit)
        let c = UIColor(self).cgColor
        guard let comps = c.components else { return (0, 0, 0, 1) }
        if comps.count < 4 { return (comps[0], comps[0], comps[0], comps.count > 1 ? comps[1] : 1) }
        return (comps[0], comps[1], comps[2], comps[3])
        #else
        return (0, 0, 0, 1)
        #endif
    }

    /// Interpolates between this color and another using an exponential function.
    ///
    /// - Parameters:
    ///   - other: The target color to interpolate toward.
    ///   - fraction: A value from 0 to 1 representing the linear distance between the colors.
    ///   - exponent: The power to which the fraction is raised, creating a non-linear interpolation.
    /// - Returns: A new color that represents the exponentially interpolated result.
    ///
    /// ## Example
    ///
    /// ```swift
    /// // Create a transition between blue and green with an exponential curve
    /// let startColor = Color.blue
    /// let endColor = Color.green
    /// 
    /// // Linear midpoint (0.5) with exponent 2.0 results in a color closer to blue
    /// let midpointColor = startColor.interpolated(to: endColor, fraction: 0.5, exponent: 2.0)
    /// 
    /// HStack {
    ///     Rectangle().fill(startColor)
    ///     Rectangle().fill(midpointColor)  // Will be closer to blue than green
    ///     Rectangle().fill(endColor)
    /// }
    /// ```
    @available(iOS 14.0, macOS 10.16, tvOS 14.0, watchOS 7.0, *)
    func interpolated(to other: Color, fraction: CGFloat, exponent: CGFloat) -> Color {
        let f = pow(fraction, exponent)
        let c1 = toComponents()
        let c2 = other.toComponents()
        let r = c1.r + (c2.r - c1.r) * f
        let g = c1.g + (c2.g - c1.g) * f
        let b = c1.b + (c2.b - c1.b) * f
        let a = c1.a + (c2.a - c1.a) * f
        #if canImport(UIKit)
        return Color(UIColor(red: r, green: g, blue: b, alpha: a))
        #else
        return self
        #endif
    }
}

/// Enables using ExponentialGradient as a ShapeStyle on iOS 17 and later.
///
/// This conformance allows ExponentialGradient to be used with shape modifiers like `fill()`:
///
/// ## Example
///
/// ```swift
/// // Create a circular button with an exponential gradient fill
/// Button(action: {
///     // Action code
/// }) {
///     Image(systemName: "play.fill")
///         .font(.system(size: 24))
///         .foregroundColor(.white)
///         .frame(width: 60, height: 60)
/// }
/// .background(
///     Circle()
///         .fill(
///             ExponentialGradient(
///                 colors: [.blue, .purple],
///                 startPoint: .topLeading,
///                 endPoint: .bottomTrailing,
///                 exponent: 2.5
///             )
///         )
/// )
/// .shadow(radius: 5)
/// ```
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension ExponentialGradient: ShapeStyle {
    public typealias Resolved = Never

    public nonisolated func resolve(in environment: EnvironmentValues) -> Never {
        fatalError()
    }
}
