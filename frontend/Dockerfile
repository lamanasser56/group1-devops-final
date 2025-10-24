# Stage 1: Build
FROM node:20-alpine AS builder
WORKDIR /app

# انسخ ملفات الـ package
COPY package*.json ./

# تثبيت التبعيات
RUN npm install

# انسخ باقي الملفات
COPY . .

# بناء المشروع
RUN npm run build

# Stage 2: Serve
FROM nginx:stable-alpine
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
