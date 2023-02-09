# StepperViewSwift

#### Swift iOS component for Step Indications

[![iOS](https://img.shields.io/badge/ios-14%2B-brightgreen)](#)
[![Swift](https://img.shields.io/badge/swift-5-green)](#)
[![License](https://img.shields.io/badge/License-MIT%20license-blue)](https://github.com/azizHamadi/StepperViewSwift/blob/master/LICENSE)

**StepperViewSwift** is a fully customizable control to give people more ways to create a stepper.

## Overview

**StepperViewSwift** is the stepper UI framework. This release includes a dynamic stepper model, including the ability to create your own stepper, use auto-size stack views and table views instead of sizing cells, 100% fast, and more. The result is a much simpler, easier to use, more powerful and easier to maintain stepper. This framework is currently used by the [BubbleYou](https://apps.apple.com/id/app/bubbleyou/id1559384388) iOS application in the quiz, voting and survey module.

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

You can implement the stepper using the **storyboard** or with **code**

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

You can customize the color, stepper size, and the color of the selected icon from the inspector as well as from the code 

### Inspector

<p align="center">
  <img src="https://github.com/azizHamadi/StepperViewSwift/blob/readme-version-1/Images/stepperViewConfig.gif?raw=true" alt="screenshot" height="558" width="507" />
</p>

### Code 

```swift
// widthLinearStepperView is the size of the vertical line view of the stepper
stepperView.widthLinearStepperView = 5

// heightCircleView is the stepper circle size
stepperView.heightCircleView = 60

// radiusCercleView is the corner radius of the stepper circle
stepperView.radiusCercleView = 15

// circleColor is the stepper circle color
stepperView.circleColor = .red

// borderCircleColor is the border color of the stepper and line view circle
stepperView.borderCircleColor = .black

// iconCircleView is the stepper circle icon
stepperView.iconCercleView = UIImage(named: "iconStepper")!

// iconColorCircle is the icon color of the stepper circle
stepperView.iconColorCercle = .systemIndigo

// enableCircleInteraction to enable/disable interaction with stepper circles
// default: enableCircleInteraction = true -> hide and show stepper content when clicking on stepper circles
stepperView.enableCircleInteraction = false
```
You can change the font of the title and description as well as their colors, customize the color of checkbox and radiobox

<p align="center">
  <img src="https://github.com/azizHamadi/StepperViewSwift/blob/readme-version-1/Images/stepperParam.jpg?raw=true" alt="screenshot" height="469" width="516" />
</p>

```swift
stepperView.titleFont = UIFont(name: "Futura", size: 17)!
stepperView.titleColor = .red
stepperView.actionIconColor = .red
```

## Implementation

**StepperViewSwift** offers you 2 types of stepper: 

- Default stepper
- Customized

### Default stepper

Default stepper use the enumeration `StepperModel`

#### StepperModel
A `StepperModel` is a enumeration defined with these properties:
- ViewModel
- RequestModel

##### ViewModel

`ViewModel` is a structure used to create the stepper and which contains the following properties:
- *title:* stepper title must not be null
- *description:* a description of the stepper
- *type:* must not be null and contains 5 types: text, textarea, checkbox, radiobox and ranking (drag and drop)
- *resourceConfig:* to configure the title and the placeholder of the input, it contains: 
  - *responseTitle:* Additional information
  - *responsePlaceholder:* a placeholder for the input field
- *maxChecked:* limit selections with a checkbox type stepper
- *responseList:* list of choices for ranking, checkbox and radiobox type steppers, it contains:
  - *responseText:* a response title
  - *image:* an image of the response
  - *imageType:* image type can be system, assets or presignedUrl 
  - *checked:* response checked or not

```swift
StepperModel.ViewModel(title: "title",
                      description: "description",
                      type: .textarea,
                      resourceConfig: ResourceConfig(responseTitle: "Short answer*",
                                                    responsePlaceholder: "placeholder text"))
```

##### RequestModel

`RequestModel` is a structure used to retrieve stepper data and contains the following properties:
- *type:* must not be null and contains 5 types: text, textarea, checkbox, radiobox and ranking (drag and drop)
- *responseText:* text and textarea type stepper response
- *responseList:* list of selected choices for steppes of type classification, checkbox and radiobox

#### defaultDataSource

`defaultDataSource` is a protocol used to generate the default stepper view

```swift
// Conforming to the DefaultStepperDataSource
stepperView.defaultDataSource = self

// data: contains the list of StepperModel.ViewModel which will be displayed
func numberOfRowsInStepper() -> Int {
    return data.count
}
func stepper(dataForRowAtIndexPath indexPath: NSIndexPath) -> StepperModel.ViewModel? {
    return data[indexPath.row]
}
```

#### defaultDelegate

`defaultDelegate` is a protocol used to retrieve data entered in the stepper

```swift
// Conforming to the DefaultStepperDelegate
stepperView.defaultDelegate = self

extension ExampleViewController: DefaultStepperDelegate {
    func resultStepper(dataAtIndexPath indexPath: NSIndexPath, data: StepperModel.RequestModel?) {
        print(data)
    }
}
```

## Installation

#### CocoaPods

Install CocoaPods if not already available:

``` bash
$ [sudo] gem install cocoapods
$ pod setup
```
Go to the directory of your Xcode project, and Create and Edit your *Podfile* and add _StepperViewSwift_:

``` bash
$ cd /path/to/MyProject
$ pod init
$ open -a Xcode Podfile
source 'https://github.com/CocoaPods/Specs.git'

# Comment the next line if you don't want to use dynamic frameworks
use_frameworks!

pod 'StepperViewSwift'
```

Install into your project:

``` bash
$ pod install
```

Open your project in Xcode from the .xcworkspace file (not the usual project file):

``` bash
$ open MyProject.xcworkspace
```

You can now `import StepperViewSwift` framework into your files.

## Contribution

Contributions are welcomed and encouraged *♡*.

## Contact

Aziz Hamadi
 - [LinkedIn](https://tn.linkedin.com/in/aziz-hamadi)

## License (MIT)

StepperViewSwift is available under the MIT license. See the [LICENSE](https://github.com/azizHamadi/StepperViewSwift/blob/readme-version-1/LICENSE) file for more info.
