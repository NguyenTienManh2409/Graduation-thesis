# Sử dụng image base cho Java
FROM openjdk:17-jdk-slim

# Đặt tên thư mục làm việc trong container
WORKDIR /app

# Copy toàn bộ project vào container
COPY . /app

# Tạo thư mục để chứa views
RUN mkdir -p /app/target/webapp/views

# Copy thư mục views vào container
COPY src/main/webapp/views /app/target/webapp/views

# Copy file JAR vào container
COPY target/phonestore-0.0.1-SNAPSHOT.jar app.jar

# Expose cổng ứng dụng
EXPOSE 8080

# Lệnh chạy ứng dụng
ENTRYPOINT ["java", "-jar", "app.jar"]
