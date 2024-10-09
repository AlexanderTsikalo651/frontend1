FROM python:3.12-slim
COPY requirements.txt .
RUN apt-get update && apt-get install -y libgl1-mesa-glx libglib2.0-0 libxcb-xinerama0 libxcb-xinput0
RUN pip install -r requirements.txt
RUN apt-get update && apt-get install -y git
COPY . .
RUN git stash
RUN git checkout v2.0
ENV QT_QPA_PLATFORM_PLUGIN_PATH=/usr/lib/x86_64-linux-gnu/qt5/plugins/platforms
EXPOSE 5000
ENV PYTHONPATH=/app
CMD ["python", "frontend1.py"]
