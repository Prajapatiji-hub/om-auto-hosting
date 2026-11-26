# GitHub repo "om-auto-hosting" में सिर्फ़ दो चीज़ें रहेंगी: यह Dockerfile और OM_AUTO_HOSTING.zip
# (फोन से एक ही फाइल Upload करनी पड़ती है; Render Build के समय ZIP खोल लेता है.)
FROM python:3.11-slim-bookworm
ENV PYTHONUNBUFFERED=1 PIP_DISABLE_PIP_VERSION_CHECK=1 PIP_NO_CACHE_DIR=1 NO_UPDATE_NOTIFIER=1 RENDER=true
RUN apt-get update \
 && apt-get install -y --no-install-recommends nodejs npm gcc libc6-dev libffi-dev libssl-dev ca-certificates util-linux unzip \
 && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY OM_AUTO_HOSTING.zip /tmp/app.zip
RUN unzip -q /tmp/app.zip -d /tmp/unz \
 && cp -a /tmp/unz/OM_AUTO_HOSTING/. /app/ \
 && rm -rf /tmp/unz /tmp/app.zip \
 && pip install -r /app/requirements.txt
EXPOSE 10000
CMD ["python", "render_main.py"]
