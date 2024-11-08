FROM python:3.12-slim
WORKDIR /app

RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libx11-xcb1 \
    libxrender1 \
    libxext6 \
    libxi6 \
    libxrandr2 \
    libxcb-util1 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-randr0 \
    libxcb-render0 \
    libxcb-shape0 \
    libxcb-xfixes0 \
    libxcb-xinerama0 \
    libxcb-xinput0 \
    qtbase5-dev \
    libqt5gui5 libqt5widgets5 libqt5network5 libqt5core5a libqt5dbus5 \
    x11-apps \
    git \
    xvfb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV QT_QPA_PLATFORM=xcb
ENV QT_QPA_PLATFORM_PLUGIN_PATH=/usr/lib/x86_64-linux-gnu/qt5/plugins/platforms
ENV DISPLAY=:99 

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
RUN git stash
RUN git checkout v2.0
EXPOSE 5002

CMD ["sh", "-c", "Xvfb :99 -screen 0 1024x768x16 & python frontend1.py --host=0.0.0.0 --port=5002"]
