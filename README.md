# Can't Cook Application

## Overview

The Can't Cook Application is designed to help users identify food items from images and provide corresponding recipes. The application uses a machine learning model to predict the food item in the image and then retrieves relevant recipes from a dataset.

## Features

- Upload an image of a food item to get a prediction of what the food item is.
- Retrieve recipes related to the predicted food item.
- Display images of the food items along with the recipes.

## Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/yourusername/cantCookApplication.git
    ```
2. Navigate to the project directory:
    ```bash
    cd cantCookApplication/can-t-cook/backend
    ```
3. Install the required dependencies:
    ```bash
    pip install -r requirements.txt
    ```

## Usage

1. Start the backend server (make sure you have Flask installed):
    ```bash
    flask run
    ```
2. Run the `api.py` script to predict food items and retrieve recipes:
    ```bash
    python result.py
    ```

## Project Structure

- `backend/`
  - `api.py`: Simple Flask backend that feeds images to the image recognition model and gets recipes when triggered.
  - `requirements.txt`: List of dependencies required for the project.
- `archive/`
  - `Food Ingredients and Recipe Dataset with Image Name Mapping.csv`: Dataset containing food ingredients, recipes, and image name mappings.
  - `Food Images/`: Directory containing images of food items.

## How It Works

1. The `api.py` script sends an image to a prediction endpoint (`http://127.0.0.1:5000/predict`).
2. The endpoint returns a prediction of the food item in the image.
3. The script then searches the dataset for recipes related to the predicted food item.
4. The relevant recipes and images are displayed to the user.

## Example

To see the application in action, you can use the provided example image (`48.jpg`). The script will predict the food item and display the top 5 related recipes along with their images.

## Frontend

The frontend is a flutter application so you can clone the repo and have the right setup the allows you to run flutter. I recommend using xcode.