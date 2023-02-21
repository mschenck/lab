#!/usr/bin/env python

from datetime import datetime

from flask import Flask

app = Flask(__name__)

START_DELAY_SECONDS = 60


@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"


@app.route("/health")
def health():
    if _boot_complete():
        return "<p>Hello, World!</p>"
    return '', 204


def _boot_complete():
    '''Synthesizing a slow boot.'''
    now = datetime.utcnow()
    return (now - start_time).total_seconds() > START_DELAY_SECONDS


start_time = datetime.utcnow()
