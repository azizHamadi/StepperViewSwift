# StepperViewSwift

#### Swift iOS component for Step Indications

[![iOS](https://img.shields.io/badge/ios-14%2B-brightgreen)](#)
[![Swift](https://img.shields.io/badge/swift-5-green)](#)
[![License](https://img.shields.io/badge/License-MIT%20license-blue)](https://github.com/azizHamadi/StepperViewSwift/blob/master/LICENSE)

**StepperViewSwift** is a fully customizable control to give people more ways to create a stepper.

## Overview

**StepperViewSwift** is the stepper UI framework. This release includes a dynamic stepper model, including the ability to create your own stepper, use auto-size stack views and table views instead of sizing cells, 100% fast, and more. The result is a much simpler, easier to use, more powerful and easier to maintain stepper. This framework is currently used by the [BubbleYou](https://apps.apple.com/id/app/bubbleyou/id1559384388) iOS application in the quiz, voting and poll module.

<p align="center">
  <img src="https://github.com/azizHamadi/StepperViewSwift/blob/readme-version-1/Images/defaultStepperView.gif?raw=true" alt="screenshot" height="591" width="289" />
</p>

<p align="center">
    <a href="#requirements">Requirements</a> • <a href="#usage">Usage</a> • <a href="#installation">Installation</a> • <a href="#contribution">Contribution</a> • <a href="#contact">Contact</a> • <a href="#license-mit">License</a>
</p>

## Requirements

- iOS 14+
- Xcode 12+
- Swift 5+

## Usage

### Storyboard
- Go to **.storyboard** and add a **blank UIView**
- Open the **Identity Inspector** and type '**Stepper**' in the '**class**' field
- Make sure you have '**StepperViewSwift**' selected in '**Module**' field

<p align="center">
  <img src="https://github.com/azizHamadi/StepperViewSwift/blob/readme-version-1/Images/Custom%20class.png?raw=true" alt="screenshot" />
</p>

### Code
```swift
import StepperViewSwift

let stepper = Stepper(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
// configure datasource & delegate
// you can configure the size of the 'stepper' circle, line thickness, color of the circles...

view.addSubview(stepper)
```
## Customization

<p align="center">
  <img src="https://github.com/azizHamadi/StepperViewSwift/blob/readme-version-1/Images/stepperViewConfig.gif?raw=true" alt="screenshot" height="558" width="507" />
</p>

<p align="center">
  <img src="https://github.com/azizHamadi/StepperViewSwift/blob/readme-version-1/Images/stepperParam.jpg?raw=true" alt="screenshot" height="469" width="516" />
</p>

## License (MIT)

StepperViewSwift is available under the MIT license. See the [LICENSE](https://github.com/azizHamadi/StepperViewSwift/blob/readme-version-1/LICENSE) file for more info.
