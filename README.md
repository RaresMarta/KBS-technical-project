# KBS Technical Project: Intrusion Detection System Comparison

## Overview

This project implements and compares two deep learning approaches for Intrusion Detection Systems (IDS) using the CICIDS2017 dataset:

1. **Autoencoder-based IDS** - Unsupervised anomaly detection approach
2. **Transformer-based IDS** - Supervised classification approach

The project provides a fair comparison between unsupervised and supervised learning methods for network intrusion detection.

## Dataset

The project uses the **CICIDS2017** dataset, which contains:
- Network flow features extracted from PCAP files
- Binary classification: BENIGN (0) vs ATTACK (1)
- Multiple attack types: DDoS, Port Scan, Infiltration, Web Attacks, etc.

**Note:** The raw dataset files are not included in this repository due to size limitations. You can download the CICIDS2017 dataset from the [Canadian Institute for Cybersecurity](https://www.unb.ca/cic/datasets/ids-2017.html).

## Project Structure

```
KBS/
├── 01_dataset_preprocessing.ipynb    # Dataset loading, cleaning, and splitting
├── 02_autoencoder_ids.ipynb          # Autoencoder-based IDS implementation
├── 03_transformer_ids.ipynb          # Transformer-based IDS implementation
├── requirements.txt                   # Python dependencies
├── Dockerfile                         # Docker image configuration
├── docker-compose.yml                # Docker Compose configuration
├── .dockerignore                     # Files to exclude from Docker build
├── dataset/                           # Raw CICIDS2017 CSV files (not in repo)
├── processed/                         # Preprocessed and split data (not in repo)
│   ├── X_train.csv, X_val.csv, X_test.csv
│   ├── y_train.csv, y_val.csv, y_test.csv
│   └── scaler.pkl
├── systematic_literature_review.pdf   # Systematic Literature Review
└── theoretical_background.pdf        # Theoretical Background / Report
```

## Setup

### Option 1: Docker (Recommended)

The easiest way to run the experiments is using Docker:

```bash
# Build and run with docker-compose (recommended)
docker-compose up --build

# Or build and run manually
docker build -t kbs-ids .
docker run -p 8888:8888 -v $(pwd):/app -v $(pwd)/dataset:/app/dataset -v $(pwd)/processed:/app/processed kbs-ids
```

Then open your browser to `http://localhost:8888` to access Jupyter Lab.

**Note:** Make sure to download the CICIDS2017 dataset and place the CSV files in the `dataset/` directory before running the preprocessing notebook.

### Option 2: Local Installation

#### Requirements

- Python 3.8 or higher recommended

#### Python Packages

Install all dependencies:

```bash
pip install -r requirements.txt
```

Or install manually:
```bash
pip install numpy pandas scikit-learn torch matplotlib seaborn joblib jupyter notebook ipykernel
```

## Usage

**Note:** If using Docker, the notebooks will be available in Jupyter Lab at `http://localhost:8888`. If running locally, start Jupyter with `jupyter lab` or `jupyter notebook`.

### 1. Dataset Preprocessing

Run `01_dataset_preprocessing.ipynb` first to:
- Load and merge all CICIDS2017 CSV files
- Clean data (remove NaN, infinite values)
- Convert labels to binary format (BENIGN=0, ATTACK=1)
- Split into train/validation/test sets (70%/15%/15%)
- Scale features using StandardScaler
- Save processed data to `processed/` directory

**Output:**
- `processed/X_train.csv`, `processed/X_val.csv`, `processed/X_test.csv`
- `processed/y_train.csv`, `processed/y_val.csv`, `processed/y_test.csv`
- `processed/scaler.pkl`

### 2. Autoencoder-based IDS

Run `02_autoencoder_ids.ipynb` to:
- Train an autoencoder only on benign traffic
- Use reconstruction error as anomaly score
- Select threshold on validation set
- Evaluate on test set

**Key Features:**
- Unsupervised learning approach
- Trained exclusively on benign samples
- Reconstruction error threshold for classification

### 3. Transformer-based IDS

Run `03_transformer_ids.ipynb` to:
- Train a transformer model in supervised manner
- Use self-attention to learn feature relationships
- Handle class imbalance with weighted sampling
- Evaluate on test set

**Key Features:**
- Supervised learning approach
- Multi-head self-attention mechanism
- Positional encoding for features
- Binary classification head

## Model Architectures

### Autoencoder
- **Encoder:** 77 → 128 → 64 → 32
- **Decoder:** 32 → 64 → 128 → 77
- **Loss:** Mean Squared Error (MSE)
- **Training:** Only on benign samples

### Transformer
- **Input Dimension:** 77 features
- **Model Dimension (d_model):** 128
- **Attention Heads:** 8
- **Encoder Layers:** 4
- **Feedforward Dimension:** 256
- **Dropout:** 0.1
- **Loss:** Binary Cross-Entropy

## Results

Both models are evaluated using:
- Classification Report (Precision, Recall, F1-score)
- Confusion Matrix
- ROC Curve and AUC-ROC score
- Prediction probability distributions

## Notes

- **Large Files:** Raw dataset and processed CSV files are excluded from git due to size limitations (GitHub's 100MB file limit)
- **Reproducibility:** All random seeds are set (random_state=42) for reproducible results
- **Fair Comparison:** Both models use the same train/validation/test split from the preprocessing notebook
- **Scaler:** The StandardScaler is fitted only on training data and reused for validation and test sets

## References

- CICIDS2017 Dataset: [Canadian Institute for Cybersecurity](https://www.unb.ca/cic/datasets/ids-2017.html)
- See `SLR.pdf` for systematic literature review
- See `report_1.pdf` for detailed project report

## License

[Add your license information here]

## Author

[Add your name/information here]
