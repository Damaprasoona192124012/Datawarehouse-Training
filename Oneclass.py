import os
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.svm import OneClassSVM

# === Step 1: Load ITO Descriptions from Nested Folders ===
def load_ito_descriptions(folder_path):
    descriptions = []
    for root, _, files in os.walk(folder_path):
        for file in files:
            if file.endswith('.csv'):
                file_path = os.path.join(root, file)
                try:
                    df = pd.read_csv(file_path)
                    if 'description' in df.columns:
                        desc = df['description'].dropna().astype(str).tolist()
                        descriptions.extend(desc)
                except Exception as e:
                    print(f"⚠️ Failed to read {file_path}: {e}")
    return descriptions

# === Step 2: TF-IDF Vectorizer ===
def vectorize_text(corpus):
    vectorizer = TfidfVectorizer(stop_words='english', max_features=1000)
    X = vectorizer.fit_transform(corpus)
    return X, vectorizer

# === Step 3: Train SVM ===
def train_one_class_svm(X_train):
    model = OneClassSVM(kernel='rbf', gamma='auto', nu=0.1)
    model.fit(X_train)
    return model

# === Step 4: Load & Vectorize Test Data ===
def load_test_data(file_path, vectorizer):
    test_df = pd.read_csv(file_path)
    test_df['description'] = test_df['description'].astype(str)
    X_test = vectorizer.transform(test_df['description'])
    return test_df, X_test

# === Step 5: Save Results into Two Files ===
def save_predictions(test_df, predictions):
    test_df['predicted_label'] = ['ITO' if p == 1 else 'Non-ITO' for p in predictions]

    ito_df = test_df[test_df['predicted_label'] == 'ITO']
    non_ito_df = test_df[test_df['predicted_label'] == 'Non-ITO']

    ito_df.to_csv("ito_predictions.csv", index=False)
    non_ito_df.to_csv("non_ito_predictions.csv", index=False)

    print(f"✅ ITO samples saved: {len(ito_df)} to 'ito_predictions.csv'")
    print(f"✅ Non-ITO samples saved: {len(non_ito_df)} to 'non_ito_predictions.csv'")

# === Main Execution ===
# 🔁 Update these paths
ito_folder_path = "/path/to/your/ITO_folder"
test_file_path = "/path/to/your/test_data.csv"

# 1. Load & train
ito_descriptions = load_ito_descriptions(ito_folder_path)
X_train, tfidf_vectorizer = vectorize_text(ito_descriptions)
svm_model = train_one_class_svm(X_train)

# 2. Test
test_df, X_test = load_test_data(test_file_path, tfidf_vectorizer)
predictions = svm_model.predict(X_test)

# 3. Output
save_predictions(test_df, predictions)
