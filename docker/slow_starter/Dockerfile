FROM alpine:latest

EXPOSE 5000

COPY requirements.txt /

RUN apk add --no-cache python3 py3-pip
RUN pip install -r /requirements.txt

COPY slow_starter.py /

ENTRYPOINT ["gunicorn", "-w 4", "-b 0.0.0.0:5000", "slow_starter:app"]
