FROM nginx:latest

# ENV LANG ja_JP.UTF-8
# ENV LANGUAGE ja_JP:ja
# ENV LC_ALL ja_JP.UTF-8
# ENV TZ JST-9
# ENV TERM xterm

RUN apt-get update && apt-get install -y
ARG USERNAME=${USER_NAME}
ARG GROUPNAME=${GROUP_NAME}
ARG UID=${U_ID}
ARG GID=${G_ID}
# ARG PASSWORD=isusr
RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -u $UID -g $GID $USERNAME

COPY ./html/ /usr/share/nginx/html/
COPY ./nginx.conf/ /etc/nginx/nginx.conf
RUN chown -R $USERNAME:$USERNAME /usr/share/nginx/html/
RUN chmod -R 755 /usr/share/nginx/html/
RUN chown -R $USERNAME:$USERNAME /etc/nginx/ && chmod -R g+w /etc/nginx/
RUN chown -R $USERNAME:$USERNAME /var/cache/nginx/ && chmod -R g+w /var/cache/nginx/
RUN chown -R $USERNAME:$USERNAME /var/log/nginx/ && chmod -R g+w /var/log/nginx/
RUN chown -R $USERNAME:$USERNAME /var/run/ && chmod -R g+w /var/run/
USER $USERNAME
EXPOSE 8080
