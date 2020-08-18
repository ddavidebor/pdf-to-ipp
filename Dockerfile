FROM python:slim-buster
RUN pip install -r /app/requirements.txt && \
    apt-get update && apt-get install -y --no-install-recommends \
	lpr \
    cups \
    cups-client \
    cups-pdf \
	netcat \
	&& rm -rf /var/lib/apt/lists/*
ADD . /app
CMD ["/app/start.sh"]
