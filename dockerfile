# Use a compatible Python version (Rasa 3.1.0 requires <3.10)
FROM python:3.9-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential gcc libpq-dev curl git

# Copy project files
COPY . /app

# Upgrade pip and install dependencies
RUN pip install --upgrade pip
RUN pip install rasa==3.1.0
RUN pip install -r requirements.txt

# Expose port (used by Railway)
EXPOSE 8000

# Run Rasa server
CMD ["rasa", "run", "--enable-api", "--cors", "*", "--debug", "-p", "8000"]
