ARG UNAME=pi
ARG UID=1000
ARG GID=1000
ARG RUNNER_ARCH=arm64
ARG RUNNER_VER=2.321.0
ARG RUNNER_BIN=actions-runner-linux-${RUNNER_ARCH}-${RUNNER_VER}.tar.gz

FROM debian:latest
ARG UNAME
ARG UID
ARG GID
ARG RUNNER_VER
ARG RUNNER_BIN

RUN apt-get update && apt-get install -y ca-certificates curl libicu72 libssl3 openssh-client curl gpg && apt-get clean autoclean
RUN install -m 0755 -d /etc/apt/keyrings

# Add Docker's official GPG key:
RUN curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
RUN chmod a+r /etc/apt/keyrings/docker.asc

# Add the docker repository to Apt sources and insatll docker
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg;
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null;

RUN apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin gh && apt-get clean autoclean

RUN groupadd -g $GID -o $UNAME && useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME
RUN echo '%pi ALL=(ALL) NOPASSWD:ALL'>>/etc/sudoers

RUN mkdir -p /home/pi/.ssh /home/pi/runner && chown -R pi:pi /home/pi && cd /home/pi/runner && curl -o $RUNNER_BIN -L https://github.com/actions/runner/releases/download/v${RUNNER_VER}/${RUNNER_BIN} && cd /home/pi/runner && tar xzf ./$RUNNER_BIN && rm $RUNNER_BIN && chown -R pi:pi /home/pi

COPY ./scripts/start.sh /home/pi/runner

USER $UNAME

WORKDIR /home/pi/runner

ENV GITHUB_ACTIONS_RUNNER_TLS_NO_VERIFY=1

ENTRYPOINT [ "./start.sh" ]
#ENTRYPOINT [ "/bin/sh" ]
