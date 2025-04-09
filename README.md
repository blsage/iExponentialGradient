# UnionGradeints

A SwiftUI extension that provides exponential gradients for more natural-looking color transitions.

## Overview

Standard linear gradients use a constant rate of change between colors, which can sometimes appear flat or unnatural. iExponentialGradient applies an exponential function to create more visually interesting and dynamic gradients that can better mimic how light and color behave in the real world.

## Requirements

- iOS 14.0+ / macOS 10.16+ / tvOS 14.0+ / watchOS 7.0+
- Swift 6.0+

## Installation

### Swift Package Manager

Add the package dependency to your Package.swift file:

```swift
dependencies: [
    .package(url: "https://github.com/unionst/union-gradients.git", from: "1.0.0")
]
```

Or add it directly in Xcode using File > Add Packages...

## Usage

```swift
import SwiftUI
import UnionGradeints

struct ContentView: View {
    var body: some View {
        // Basic usage with default exponent (2.0)
        ExponentialGradient(
            colors: [.blue, .purple],
            startPoint: .leading, 
            endPoint: .trailing
        )
        .frame(width: 300, height: 200)
        
        // Custom exponent for different curve steepness
        ExponentialGradient(
            colors: [.red, .orange, .yellow],
            startPoint: .top,
            endPoint: .bottom,
            exponent: 3.5,
            subdivisions: 64  // More subdivisions for smoother gradients
        )
        .frame(width: 300, height: 200)
        
        // Works with gradient stops for precise color positioning
        ExponentialGradient(
            stops: [
                .init(color: .green, location: 0),
                .init(color: .blue, location: 0.3),
                .init(color: .purple, location: 1)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing,
            exponent: 1.5
        )
        .frame(width: 300, height: 200)
    }
}
```

## Parameters

- `gradient`: A SwiftUI Gradient to use for the colors.
- `colors`: An array of Colors to use in the gradient (convenience initializer).
- `stops`: An array of Gradient.Stop values for precise color control (convenience initializer).
- `startPoint`: The UnitPoint where the gradient begins.
- `endPoint`: The UnitPoint where the gradient ends.
- `exponent`: The power to which the interpolation is raised (default: 2.0).
  - Values > 1 create a slower start and faster finish
  - Values < 1 create a faster start and slower finish
  - Value of 1 is equivalent to a linear gradient
- `subdivisions`: The number of gradient steps to use (default: 32, higher values create smoother gradients).

## License

This library is released under the MIT license. See LICENSE for details. 
