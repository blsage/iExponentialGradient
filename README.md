# UnionGradeints

A SwiftUI extension that provides exponential gradients for more natural-looking color transitions.

## Overview

Standard linear gradients use a constant rate of change between colors, which can sometimes appear flat or unnatural, especially against motion.
`ExponentialGradient` applies an exponential function to create more softer gradients that can better mimic how light and color behave in the real world.

## Requirements

- iOS 13.0+
- macOS 10.15+
- tvOS 14.3+
- watchOS 6.0+

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
        ExponentialGradient(
            colors: [.blue, .purple],
            startPoint: .leading, 
            endPoint: .trailing
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
