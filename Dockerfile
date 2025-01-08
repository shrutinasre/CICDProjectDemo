# Use a lightweight Nginx image
FROM nginx:latest

# Set the working directory
WORKDIR /usr/share/nginx/html

# Copy your HTML files to the container
COPY . /usr/share/nginx/html

# Expose port 80 for the web server
EXPOSE 80

# Default command to run Nginx
CMD ["nginx", "-g", "daemon off;"]
