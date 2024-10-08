# Используем базовый образ Node.js
FROM node:14

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и устанавливаем зависимости
COPY package*.json ./
RUN npm install

# Копируем остальные файлы
COPY . .

# Собираем приложение
RUN npm run build

# Указываем команду для запуска приложения
CMD ["npm", "start"]

# Указываем порт
EXPOSE 3000

# Указываем версию тега
LABEL version="2.0"
