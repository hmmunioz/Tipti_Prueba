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

Run:
flutter run
```

## -----IMPORTANT-----

THE TESTS MUST BE RUN ONE BY ONE AND NOT IN GROUP

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

![alt text](https://i.postimg.cc/wBSQZCpN/Whats-App-Image-2023-04-13-at-4-13-49-AM-1.jpg)
![alt text](https://i.postimg.cc/5tHmPxZ1/Whats-App-Image-2023-04-13-at-4-13-49-AM-2.jpg)
![alt text](https://i.postimg.cc/mgpwNcp8/Whats-App-Image-2023-04-13-at-4-13-49-AM-3.jpg)
