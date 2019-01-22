FROM debian:stretch
RUN apt-get update -qq && apt-get install -qq \
    uwsgi-core uwsgi-plugin-python3 \
    python3 python3-pip python3-psycopg2 \
    gettext dumb-init
ADD . /bitpoll
WORKDIR /bitpoll
RUN pip3 install -qr requirements.txt && \
    python3 manage.py compilemessages && \
    python3 manage.py collectstatic
EXPOSE 8080
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD uwsgi --ini /bitpoll/contrib/uwsgi.ini
