# Use Python 3.9 base image
FROM python:3.9-slim

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Set working directory
WORKDIR /app

# Install OS dependencies
RUN apt-get update && apt-get install -y \
    build-essential gcc git curl libpq-dev && \
    apt-get clean

# Copy all project files
COPY . .

# Upgrade pip
RUN pip install --upgrade pip

# Install compatible Rasa & dependency versions
RUN pip install rasa==3.1.0 \
    websockets==10.4 \
    sanic==21.2.1

# Install remaining requirements
RUN pip install -r requirements.txt || true

# Expose port for Railway or other platforms
EXPOSE 8000

# Start Rasa server
CMD ["rasa", "run", "--enable-api", "--cors", "*", "--debug", "-p", "8000"]
