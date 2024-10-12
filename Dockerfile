# Use the official Python image as a base
FROM python:3.12-slim

# Set the working directory to /app
WORKDIR /app

# Copy the application code
COPY . /app/
COPY requirements.txt /app/
# Install git
RUN apt-get update && apt-get install -y git

# Run git stash
RUN git stash

# Checkout the v2.0 branch
RUN git checkout v2.0

# Install the dependencies
RUN apt-get update && apt-get install -y libqt5core5a libqt5gui5 libqt5widgets5 libqt5printsupport5 qtwayland5



# Install Python dependencies
RUN pip install -r requirements.txt

# Set the environment variables
ENV QT_QPA_PLATFORM_PLUGIN_PATH=/usr/lib/x86_64-linux-gnu/qt5/plugins/platforms
ENV PYTHONPATH=/app

# Expose the port
EXPOSE 5000

# Run the command
CMD ["python", "frontend1.py"]
