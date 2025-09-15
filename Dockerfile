# Use a small, secure nginx image
FROM nginx:stable-alpine

LABEL maintainer="Arihant Jain <jainarihant1309@gmail.com>"

# Remove default nginx content
RUN rm -rf /usr/share/nginx/html/*

# Copy site files
COPY . /usr/share/nginx/html

# Set permissions (nginx in alpine runs as nginx:nginx)
RUN chown -R nginx:nginx /usr/share/nginx/html \
    && chmod -R 755 /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Simple healthcheck (HTTP 200 expected)
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
  CMD wget -qO- --timeout=2 http://localhost/ >/dev/null || exit 1

# Run nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
