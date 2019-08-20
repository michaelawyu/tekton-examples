FROM gcr.io/google-appengine/python

RUN virtualenv /env

ENV VIRTUAL_ENV /env
ENV PATH /env/bin:$PATH

COPY app /cache/app

RUN pip install -r /cache/app/requirements.txt

WORKDIR /cache/app
CMD gunicorn -b :8080 main:app