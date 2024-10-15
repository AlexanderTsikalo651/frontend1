# Используем образ Python 3.12 с минимальным набором пакетов
FROM python:3.12-slim

# Устанавливаем рабочий каталог в /app
WORKDIR /app

# Обновляем список пакетов и устанавливаем необходимые зависимости
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \  # Библиотека для работы с OpenGL
    libglib2.0-0 \  # Библиотека для работы с GLib
    libx11-xcb1 \  # Библиотека для работы с X11
    libxrender1 \  # Библиотека для работы с X Render
    libxext6 \  # Библиотека для работы с X Extensions
    libxi6 \  # Библиотека для работы с X Input
    libxrandr2 \  # Библиотека для работы с X RandR
    libxcb-util1 \  # Библиотека для работы с XCB
    libxcb-icccm4 \  # Библиотека для работы с XCB ICCCM
    libxcb-image0 \  # Библиотека для работы с XCB Image
    libxcb-keysyms1 \  # Библиотека для работы с XCB KeySyms
    libxcb-randr0 \  # Библиотека для работы с XCB RandR
    libxcb-render0 \  # Библиотека для работы с XCB Render
    libxcb-shape0 \  # Библиотека для работы с XCB Shape
    libxcb-xfixes0 \  # Библиотека для работы с XCB XFixes
    libxcb-xinerama0 \  # Библиотека для работы с XCB Xinerama
    libxcb-xinput0 \  # Библиотека для работы с XCB XInput
    qtbase5-dev \  # Библиотека для работы с Qt
    libqt5gui5 libqt5widgets5 libqt5network5 libqt5core5a libqt5dbus5 \  # Библиотеки для работы с Qt
    git  # Система управления версиями Git

# Устанавливаем переменные окружения
ENV QT_QPA_PLATFORM=xcb  # Устанавливаем платформу для Qt
ENV QT_QPA_PLATFORM_PLUGIN_PATH=/usr/lib/x86_64-linux-gnu/qt5/plugins/platforms  # Устанавливаем путь к плагинам для Qt
ENV DISPLAY=host.docker.internal:0.0  # Устанавливаем переменную DISPLAY для работы с X11

# Устанавливаем X11-клиент
RUN apt-get update && apt-get install -y x11-apps  # Устанавливаем пакеты для работы с X11

# Копируем файл requirements.txt в рабочий каталог
COPY requirements.txt .

# Устанавливаем зависимости из файла requirements.txt
RUN pip install -r requirements.txt

# Копируем текущий каталог в рабочий каталог
COPY . .

# Отменяем все изменения в репозитории Git
RUN git stash

# Переходим на ветку v2.0 в репозитории Git
RUN git checkout v2.0

# Открываем порт 5002 для работы с приложением
EXPOSE 5002

# Устанавливаем команду для запуска приложения
CMD ["python", "frontend1.py", "--host=0.0.0.0", "--port=5002"]
