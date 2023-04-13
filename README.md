# Tipti Test

A test application for the tipti company, which is in charge of displaying a paginated list with the starwars characters, which will allow it to be filtered. In addition, at the top of the screen there will be a 3D cubic object, which will rotate with data from the gyroscope transmitted through a native channel to the interface.

## How to Use

**Step 1:**

Download or clone this repo by using the link below:

```
git@github.com:hmmunioz/Tipti_Prueba.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies:

```
flutter clean
flutter pub upgade
flutter pub get
```

## Tipti Features:

- People

### Libraries & Tools Used

- [flutter version v2.10.5]
- [equatable](https://pub.dev/packages/equatable)
- [shimmer](https://pub.dev/packages/shimmer)
- [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- [http](https://pub.dev/packages/http)
- [bloc_test](https://pub.dev/packages/bloc_test)

### Folder Structure

Here is the core folder structure which flutter provides.

```
TIPTI_TEST/
|- android
|- build
|- ios
|- lib
|- test
```

Here is the folder structure we have been using in this project

```
lib/
|- app/
  |- _childrens/
     |- home/
       |- bloc
       |- enums
       |- widgets
  |- common_widgets/
  |- constants/
  |- models/
  |- utils/
  |- main.dart
```

Now, lets dive into the lib folder which has the main code for the application.

```
1- constants - All the application level constants are defined in this directory with-in their respective files. This directory contains the constants for `theme`, `dimentions`, `api endpoints`, `preferences` and `strings`.
2- data - Contains the data layer of your project, includes directories for local, network and shared pref/cache.
3- stores - Contains store(s) for state-management of your application, to connect the reactive data of your application with the UI.
4- ui — Contains all the ui of your project, contains sub directory for each screen.
5- util — Contains the utilities/common functions of your application.
6- widgets — Contains the common widgets for your applications. For example, Button, TextField etc.
7- routes.dart — This file contains all the routes for your application.
8- main.dart - This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.
```

### Constants

This directory contains all the application level constants. A separate file is created for each type as shown in example below:

```
constants/
|- app_theme.dart
|- dimens.dart
|- endpoints.dart
|- preferences.dart
|- strings.dart
```
