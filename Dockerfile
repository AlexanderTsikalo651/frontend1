# Используем базовый образ Python
FROM python:3.9

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем requirements.txt и устанавливаем зависимости
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Копируем остальные файлы
COPY . .

# Указываем команду для запуска приложения
CMD ["python", "app.py"]

# Указываем порт (если необходимо)
EXPOSE 3000

# Указываем версию тега
LABEL version="2.0"
