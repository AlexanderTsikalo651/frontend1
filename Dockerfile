# Use the official Python image as a base
FROM python:3.12-slim

# Set the working directory to /app
WORKDIR /app

# Copy the requirements file
COPY requirements.txt .

# Install the dependencies
RUN apt-get update && apt-get install -y libgl1-mesa-glx libglib2.0-0 libxcb-xinerama0 libxcb-xinput0
RUN pip install -r requirements.txt

# Install Qt and its dependencies
RUN apt-get update && apt-get install -y qt5-default

# Clone the Git repository
RUN git clone https://github.com/your-repo/your-app.git .

# Checkout the v2.0 branch
RUN git checkout v2.0

# Set the environment variables
ENV QT_QPA_PLATFORM_PLUGIN_PATH=/usr/lib/x86_64-linux-gnu/qt5/plugins/platforms
ENV PYTHONPATH=/app

# Expose the port
EXPOSE 5000

# Run the command
CMD ["python", "frontend1.py"]
