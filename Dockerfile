FROM python:3.12-slim

# Set the working directory
WORKDIR /app

# Copy only the requirements first (improves cache efficiency)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Run application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "5000"]