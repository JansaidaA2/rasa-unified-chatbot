# Use Python 3.9 base image
FROM python:3.9-slim

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Create app directory
WORKDIR /app

# Install OS dependencies
RUN apt-get update && apt-get install -y \
    build-essential gcc git curl libpq-dev

# Copy project files
COPY . .

# Upgrade pip & install dependencies
RUN pip install --upgrade pip
RUN pip install rasa==3.1.0
RUN pip install -r requirements.txt

# Expose port for Railway
EXPOSE 8000

# Start Rasa server
CMD ["rasa", "run", "--enable-api", "--cors", "*", "--debug", "-p", "8000"]
