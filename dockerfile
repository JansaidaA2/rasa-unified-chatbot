FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install basic tools
RUN apt-get update && apt-get install -y build-essential gcc libpq-dev curl

# Copy files
COPY . /app

# Install pip dependencies
RUN pip install --upgrade pip
RUN pip install rasa==3.1.0
RUN pip install -r requirements.txt

# Expose port
EXPOSE 8000

# Run Rasa server
CMD ["rasa", "run", "--enable-api", "--cors", "*", "--debug", "-p", "8000"]
