import numpy as np
from sklearn import datasets
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import MinMaxScaler

# Load Iris dataset
iris = datasets.load_iris()
X = iris.data
y = iris.target

# Normalize features to 0-255 range
scaler = MinMaxScaler(feature_range=(0, 255))
X_scaled = scaler.fit_transform(X).astype(np.uint8)

# Stratified train-test split (maintain class distribution)
X_train, X_test, y_train, y_test = train_test_split(
    X_scaled, y, 
    test_size=0.3,        # 30% test samples
    random_state=42,      # Reproducible split
    stratify=y            # Maintain class ratios
)

# Save test vectors in binary format
with open("iris_test_vectors.txt", "w") as f:
    for features, label in zip(X_test, y_test):
        # Write features as 8-bit binary strings
        for feature in features:
            f.write(f"{feature:08b}\n")
        # Write label as 2-bit binary
        f.write(f"{label:02b}\n")