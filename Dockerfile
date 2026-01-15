# Use official Python base image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY *.ipynb ./
COPY README.md ./

# Create directories for data
RUN mkdir -p dataset processed

# Expose Jupyter port
EXPOSE 8888

# Set environment variables for Jupyter
ENV JUPYTER_ENABLE_LAB=yes

# Run Jupyter Lab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=", "--NotebookApp.password="]
