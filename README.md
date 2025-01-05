# ScamGuard

ScamGuard is a Flutter-based application that integrates a machine learning model to detect scams based on user-provided input. This project was developed as part of a university course on machine learning and serves as an example of deploying machine learning models in real-world applications.

## Features

- **Machine Learning Integration:** 
  - The app uses a **Random Forest Tree** model for prediction, as it provides high accuracy.
  - The trained models are serialized using Python's **joblib** library to `.pkl` files for easy backend integration.

- **Backend and Frontend Communication:**
  - A **Flask** backend serves as the bridge between the machine learning model and the Flutter frontend.
  - The backend returns predictions in JSON format, which are then displayed in the app.

- **User Authentication (Optional):**
  - Users can register and log in through the app.
  - User data is securely stored in **Firebase Cloud Database**.

## Technology Stack

### Frontend:
- **Flutter:** Cross-platform framework for the mobile app.

### Backend:
- **Python:** For model integration and backend logic.
- **Flask:** Lightweight Python web framework for serving the API.
- **Firebase:** For user authentication and data storage.

### Machine Learning:
- **Random Forest Tree:** A supervised learning algorithm for predictions.
- **joblib (Python):** Used to serialize and deserialize the trained models.

## Project Workflow

1. **Train the Model:**
   - The model is trained using a dataset in Python.
   - Random Forest Tree is used for predictions, and the final model is exported as a `.pkl` file using **joblib**.

2. **Setup the Backend:**
   - A Flask application (`app.py`) loads the `.pkl` model and serves an API endpoint for predictions.
   - The backend processes user input and returns predictions in JSON format.

3. **Connect to the Frontend:**
   - The Flutter app fetches data from the Flask backend via HTTP requests.
   - Predictions are displayed in the app in a user-friendly format.

4. **User Authentication:**
   - Optional user registration and login features are implemented using Firebase.

## Getting Started

### Prerequisites
- **Flutter Development Environment:** [Get started with Flutter](https://docs.flutter.dev/get-started/install).
- **Python Environment:** Install Python 3.7+ with Flask and joblib libraries.

### Steps to Run the Project

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/your-username/scamguard.git
   cd scamguard
   **pip install flask joblib**
   **python app.py**
   **flutter pub get**
   **flutter run**

This version includes:
1. **Structured Layout**: Clear sections for features, technologies, workflow, and setup instructions.
2. **Professional Tone**: Improves readability and conveys a professional approach.
3. **Optional Sections**: Allows flexibility to include screenshots or other project details.
4. **Getting Started Instructions**: Provides step-by-step guidance for new developers.

## Here Some Demo Picture:

![image](https://github.com/user-attachments/assets/7e21da0f-58db-4a6f-977e-19c97befbe8e)
![image](https://github.com/user-attachments/assets/57355196-20f6-47cc-95b1-3c0c70692ca0)
![image](https://github.com/user-attachments/assets/b84c6209-c203-47e8-b8a6-b81de229616c)
![image](https://github.com/user-attachments/assets/5da1fecf-00e3-40e3-bb75-8a88395825b6)

