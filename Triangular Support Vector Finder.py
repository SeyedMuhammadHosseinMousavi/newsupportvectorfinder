import numpy as np
import itertools
from sklearn.datasets import load_iris
from sklearn.preprocessing import StandardScaler
from sklearn.svm import SVC
from sklearn.model_selection import train_test_split
from sklearn.metrics import classification_report, accuracy_score
from scipy.spatial.distance import pdist, squareform

# Load the Iris dataset
iris = load_iris()
X = iris.data
y = iris.target

# Standardize features
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

# Function to calculate the generalized area of a triangle given by three points
def triangle_area(p1, p2, p3):
    matrix = np.array([p1, p2, p3])
    dist_matrix = squareform(pdist(matrix, 'euclidean'))
    semi_perimeter = np.sum(dist_matrix) / 2
    area = semi_perimeter
    for i in range(3):
        area *= (semi_perimeter - dist_matrix[i][(i+1) % 3])
    return np.sqrt(area)

# Collect areas for triangles where two points are from the same class and one from another
areas = []
for (i, j, k) in itertools.combinations(range(len(X_scaled)), 3):
    if y[i] == y[j] != y[k] or y[j] == y[k] != y[i] or y[i] == y[k] != y[j]:
        area = triangle_area(X_scaled[i], X_scaled[j], X_scaled[k])
        areas.append(area)

# Calculate statistics for area to determine a threshold
area_stats = (np.min(areas), np.max(areas), np.mean(areas), np.std(areas))
area_threshold = area_stats[2] - area_stats[3]  # mean - std

# Function to select data based on the triangle area threshold
def select_data(X, y, threshold):
    selected_indices = []
    for (i, j, k) in itertools.combinations(range(len(X)), 3):
        if y[i] == y[j] != y[k] or y[j] == y[k] != y[i] or y[i] == y[k] != y[j]:
            area = triangle_area(X[i], X[j], X[k])
            if area < threshold:
                selected_indices.extend([i, j, k])
    return X[np.unique(selected_indices)], y[np.unique(selected_indices)]

# Select data using the computed area threshold
selected_X, selected_y = select_data(X_scaled, y, area_threshold)

# SVM classification on the selected data
X_train_sel, X_test_sel, y_train_sel, y_test_sel = train_test_split(selected_X, selected_y, test_size=0.3, random_state=42)
svm_sel = SVC(kernel='linear')
svm_sel.fit(X_train_sel, y_train_sel)
y_pred_sel = svm_sel.predict(X_test_sel)

# Classification report and accuracy for the selected subset
report_sel = classification_report(y_test_sel, y_pred_sel)
accuracy_sel = accuracy_score(y_test_sel, y_pred_sel)

# SVM classification on the full dataset for comparison
X_train_full, X_test_full, y_train_full, y_test_full = train_test_split(X_scaled, y, test_size=0.3, random_state=42)
svm_full = SVC(kernel='linear')
svm_full.fit(X_train_full, y_train_full)
y_pred_full = svm_full.predict(X_test_full)

# Classification report and accuracy for the full dataset
report_full = classification_report(y_test_full, y_pred_full)
accuracy_full = accuracy_score(y_test_full, y_pred_full)

# Print results
print("Selected Subset Classification Report:\n", report_sel)
print("Selected Subset Accuracy: ", accuracy_sel)
print("Full Dataset Classification Report:\n", report_full)
print("Full Dataset Accuracy: ", accuracy_full)
