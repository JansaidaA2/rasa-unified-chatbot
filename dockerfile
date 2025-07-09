# Use Python 3.9 base image
FROM python:3.9-slim

# Avoid interactive prompts during installs
ENV DEBIAN_FRONTEND=noninteractive

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential gcc git curl libpq-dev

# Copy project files into the container
COPY . .

# Upgrade pip
RUN pip install --upgrade pip

# Install specific version of Rasa
RUN pip install rasa==3.1.0

# Fix compatibility with Rasa 3.1.0 by pinning websockets
RUN pip install websockets==10.4

# Install all other dependencies (optional failure tolerated for non-critical issues)
RUN pip install -r requirements.txt || true

# Train the Rasa model
RUN rasa train

# Expose port for Railway
EXPOSE 8000

# Run the Rasa server
CMD ["rasa", "run", "--enable-api", "--cors", "*", "--debug", "-p", "8000"]
