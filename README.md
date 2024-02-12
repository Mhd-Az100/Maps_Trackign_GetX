# (Tracking App Test) for WattCharge

## Introduction

Welcome to the **My Test App** repository!.

## Features

### 1. Login

- Authenticate using a username and password through a simulated API.
- Utilizes the powerful `flutter_securestorage` for secure local storage.

### 2. Home Page with Map

- Displays an interactive map using `google_maps_flutter`.
- Offers directions between two points with a visually appealing line.
- Uses `geolocator` to obtain the current location using GPS.

### 3. Location Search

- Enables users to search for locations or markets on the map.
- Integrates Google APIs for geocoding and places functionality.

### 4. Location Selection

- Allows users to select a location on the map using marker and showing place name on top.

### 5. Trip Details

- Displays trip details on the home screen.
- Shows the route with markers and calculates time and cost.

### 6. Simulation Tracking

- Simulates tracking a car from point A to point B.

## Technologies Used

1. **Google Maps Flutter**
   - For interactive maps and map-related functionality.

2. **Get**
   - For state management, routing, and efficient HTTP requests.

3. **Flutter Secure Storage**
   - For secure local storage of sensitive information.

4. **Flutter ScreenUtil**
   - Ensures a responsive UI across different devices.

5. **GetIt**
   - Facilitates ServiceLocator for dependency injection.

6. **Freezed & JsonSerializable**
   - Creates immutable classes and generates `fromJson` methods.

7. **Geolocator**
   - Obtains the current location using GPS.

8. **Google APIs**
   - Utilized for various functionalities like Direction, Geocoding, Places, etc.

## Core Components

1. **GetConnect**
   - Central class for making HTTP requests.

2. **Base Handle**
   - Manages API requests and displays error messages using the handle controller and app exceptions.

3. **Global Session**
   - Provides abstraction for session functions.

4. **Global Widgets**
   - Includes reusable widgets such as buttons, text fields, etc., to avoid repetition.

5. **Validator Class**
   - Ensures data validation throughout the application.

## Demo

Check out the video below to see the Awesome App in action:

![Awesome App Demo](demo_app.gif)

Feel free to explore the codebase and discover the magic behind each feature!

## Download the App

Download the App APK [here](<https://drive.google.com/file/d/1WGk1Axi23xBIm-1dgT5IKCQG2qIDy6e3/view>).

## Conclusion

Thank you for taking the time to review this README. I hope it reflects the effort and attention to detail put into creating this Tracking App. If you have any questions or feedback, please don't hesitate to reach out.