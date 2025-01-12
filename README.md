# Weather App

A simple weather app built using Flutter that fetches weather data for cities and displays the current weather, forecast, and city information.

## Requirements

- Flutter SDK
- Dart
- An IDE such as VS Code or Android Studio

## Setup Instructions

### 1. Clone the Repository

First, clone the repository to your local machine:

```bash
git clone https://github.com/0x01-itsmurphy/weatherapp.git
```

### 2. Install Dependencies

Navigate to the project directory and install the required dependencies:

```bash
cd weatherapp
flutter pub get
```

### 3. Set up API Key

You will need an API key from a weather service such as [OpenWeatherMap](https://openweathermap.org/api) to fetch weather data. After obtaining the API key:

- Open `lib/providers/weather_provider.dart`.
- Add your API key in the relevant section of the code.

### 4. Run the App

Make sure you have an emulator or a physical device connected, then run the app using the following command:

```bash
flutter run
```

### 5. Testing

The app includes weather fetching functionality for different cities. The app provides the following features:

- **Search for cities**: Search for any city and see the weather details.
- **Unit Switch**: Switch between Celsius and Fahrenheit temperature units.
- **City List**: Displays weather details for the selected city.

---

## Brief Approach Document

### **Project Overview**

The app was developed using **Flutter**, a cross-platform mobile framework, and **Provider** for state management. The main features of the app include displaying weather data, supporting temperature unit switching, and providing a search functionality to find weather information for any city.

### **Code Optimization Approach**

1. **Separation of Concerns**:

   - The code was organized into smaller, reusable methods for better readability and maintainability. Each part of the UI and logic (AppBar, unit switch, error handling, etc.) was encapsulated in its own method, such as `_buildAppBar`, `_buildUnitSwitch`, and `_buildBody`.
2. **State Management**:

   - The app uses **Provider** to manage state, making it easy to share data between widgets. The `WeatherProvider` fetches weather data and manages the state, including loading status, error handling, and weather data.
   - The weather data (current weather, forecast, and units) are managed via the `WeatherProvider` class.
3. **Error Handling**:

   - An error message is shown if there is a problem fetching the weather data. This is displayed within a dedicated widget (`_buildErrorScreen`), allowing for easy customization and reuse.
4. **UI Layout**:

   - The UI consists of:
     - **AppBar**: Displays the current city and a location icon (Click to search for cities).
     - **Switch for Units**: Allows switching between Fahrenheit and Celsius.
     - **Main Body**: Displays weather information and the forecast. The body dynamically changes based on the loading state, error state, and available weather data.
5. **Fetch Weather**:

   - On app initialization, the weather data for a default city ('Bhopal') is fetched. This can be modified to fetch data for any city or based on the user's location.
   - The app allows users to search for other cities through a search screen (`SearchScreen`), which fetches and displays the weather information.
