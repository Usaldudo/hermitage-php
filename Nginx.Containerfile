FROM nginxinc/nginx-unprivileged:1.23.1-alpine
USER nginx
COPY --chown=101:101 ./nginx.conf /etc/nginx/conf.d/default.conf
CMD ["nginx", "-g", "daemon off;"]
