FROM ohmyfish/fish:2.5.0

COPY . /src/marina

RUN fish /src/marina/bin/install --offline --noninteractive --yes
