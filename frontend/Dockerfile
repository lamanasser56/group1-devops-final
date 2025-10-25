# مرحلة البناء
FROM node:18 AS build
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build
ARG VITE_API_BASE_URL
ENV VITE_API_BASE_URL=$VITE_API_BASE_URL

# مرحلة التشغيل
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html

# (اختياري) إذا عندك ملف nginx.conf مخصص
# COPY nginx.conf /etc/nginx/conf.d/

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]