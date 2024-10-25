FROM python:3.8-alpine

COPY ./. /app/
EXPOSE 3030

WORKDIR /app

RUN pip install -r requirements.txt

ENTRYPOINT [ "python3" ]

CMD [ "app.py" ]