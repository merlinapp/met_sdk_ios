# Merlin iOS Events SDK 

The [Merlin](https://merlinjobs.com/) iOS Events SDK

## Project Status

- **State:** Production

- **CI:** [![Build Status](https://app.bitrise.io/app/b4b8a34bd9288b52/status.svg?token=FSMxwDsaha_FNV70Lo-u5w&branch=develop)](https://app.bitrise.io/app/b4b8a34bd9288b52)


## Getting Started 

You'll need some tools first. Xcode 10.0 is required, as well as the command-line tools (you probably already have these installed). After installing Xcode, run the following command:

```xcode-select --install```

Right, next clone the repo as usual and cd into it. You'll need to install the dependencies. This command installs the tools required:

```pod install```

This step is optional, you can  install a github  assistant. Our recommendation  is [sourcetree](https://www.sourcetreeapp.com/download/). Finally open up  the xcworkspace file.

## Stack

- **Cocoapods** as a dependency manager
- **Alamofire** for network Tasks
- **RealmSwift** for the local storage 


## Testing

Functional testing (unit test and UI test) will be implemented using the native framework in Xcode

### Running Tests

To run tests in XCode:

```
Command + U
```
