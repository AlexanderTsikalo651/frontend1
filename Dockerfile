FROM python:3.12-slim

RUN apt-get update && apt-get install -y \
    git \
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
    qt5-qmake \
    qtbase5-dev \
    xfce4 \
    xfce4-goodies \
    tightvncserver \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .

RUN mkdir ~/.vnc
RUN echo "Alextsikalo167" | vncpasswd -f > ~/.vnc/passwd
RUN chmod 600 ~/.vnc/passwd

ENV USER=root

CMD ["sh", "-c", "vncserver -kill :1 || echo 'No VNC server running'; rm -rf /tmp/.X11-unix/X1; vncserver :1 -geometry 1280x800 -depth 24 && tail -f /dev/null"]
