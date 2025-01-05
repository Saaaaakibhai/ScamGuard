from flask import Flask, request, jsonify
import joblib
import re  # For basic URL validation

# Initialize Flask app
app = Flask(__name__)

# Load the trained model and vectorizer
model_path = './models/model.pkl'  # Ensure your trained model is saved as 'model.pkl'
vectorizer_path = './models/vectorizer.pkl'  # Include the vectorizer if your model uses text data features

try:
    model = joblib.load(model_path)
    vectorizer = joblib.load(vectorizer_path)  # For transforming website links into numerical features
    print("Model and vectorizer loaded successfully!")
except Exception as e:
    print(f"Error loading model or vectorizer: {e}")
    raise

# Function to preprocess the input URL
def preprocess_url(url):
    # Basic URL validation using regex
    url_pattern = re.compile(
        r"^(https?:\/\/)?"  # http:// or https:// (optional)
        r"(www\.)?"        # www. (optional)
        r"[a-zA-Z0-9.-]+"   # Domain name
        r"(\.[a-zA-Z]{2,})"  # .com, .net, etc.
    )
    if not url_pattern.match(url):
        raise ValueError("Invalid URL format.")
    
    # Extract features from the URL
    domain_name = url.split("//")[-1].split("/")[0]  # Extract domain (for feature extraction)
    features = [len(url), len(domain_name)]  # Length of URL and domain name
    
    # Example additional feature: count of subdomains
    subdomains = domain_name.split(".")
    features.append(len(subdomains) - 1)  # Subdomain count
    
    # You can add more features as needed
    return features

# Function to check if the URL is suspicious (based on subdomains)
def is_suspicious_url(url):
    # Check if the domain has multiple subdomains other than "www"
    domain_name = url.split("//")[-1].split("/")[0]  # Extract domain (for feature extraction)
    subdomains = domain_name.split(".")
    
    # If there are more than 2 subdomains or the first subdomain is not "www", consider it suspicious
    if len(subdomains) > 2 and subdomains[0].lower() != "www":
        return True
    return False

@app.route('/predict', methods=['POST'])
def predict():
    try:
        # Parse JSON input
        data = request.json
        if 'website' not in data:
            return jsonify({'error': 'Please provide a "website" key in the request body.'}), 400
        
        website = data['website']
        
        # Check if the URL is suspicious (i.e., has more than one subdomain or non-www subdomain)
        if is_suspicious_url(website):
            return jsonify({
                'website': website,
                'prediction': 'Scam',
                'label': 0  # Scam
            }), 200
        
        # Preprocess the input URL to extract features
        features = preprocess_url(website)
        
        # Log extracted features for debugging
        print(f"Extracted features: {features}")
        
        # Transform features using the vectorizer (if applicable)
        transformed_features = vectorizer.transform([str(features)]).toarray()  # Ensure features are passed as a string list
        
        # Log transformed features for debugging
        print(f"Transformed features: {transformed_features}")
        
        # Make a prediction using the trained model
        prediction = model.predict(transformed_features)[0]
        
        # Log prediction for debugging
        print(f"Prediction: {prediction}")
        
        # Format the response
        response = {
            'website': website,
            'prediction': 'Safe' if prediction == 1 else 'Scam',
            'label': int(prediction)  # 1 = Safe, 0 = Scam
        }
        return jsonify(response), 200
    except ValueError as ve:
        return jsonify({'error': str(ve)}), 400
    except Exception as e:
        return jsonify({'error': f'An error occurred: {str(e)}'}), 500

if __name__ == '__main__':
    app.run(debug=True)
