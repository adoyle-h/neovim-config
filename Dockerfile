ARG BASE_IMAGE
FROM $BASE_IMAGE AS base

WORKDIR /workspace
ARG APK_PROXY
ARG GH_PROXY

RUN if [[ -n "$APK_PROXY" ]]; then \
    sed -i "s|http://.*archive.ubuntu.com|$APK_PROXY|g" /etc/apt/sources.list && \
    sed -i "s|http://.*security.ubuntu.com|$APK_PROXY|g" /etc/apt/sources.list ; \
    fi

RUN apt-get update && apt-get install -y \
    tar \
    coreutils \
    curl \
    unzip

ENV NVIM_TAR=/workspace/nvim-linux64.tar.gz
ARG VERSION=master

RUN curl -o $NVIM_TAR "${GH_PROXY:-}/https://github.com/neovim/neovim/releases/download/$VERSION/nvim-linux64.tar.gz" && \
    curl -o "${NVIM_TAR}.sha256sum" "${GH_PROXY:-}/https://github.com/neovim/neovim/releases/download/$VERSION/nvim-linux64.tar.gz.sha256sum"

RUN sha256sum "${NVIM_TAR}" && tar xzvf "${NVIM_TAR}"

# -------------------------------------------------------------------------------

FROM $BASE_IMAGE

LABEL maintainer="ADoyle <adoyle.h@gmail.com>"
WORKDIR /workspace
ARG APK_PROXY
ARG GH_PROXY

RUN if [[ -n "$APK_PROXY" ]]; then \
    sed -i "s|http://.*archive.ubuntu.com|$APK_PROXY|g" /etc/apt/sources.list && \
    sed -i "s|http://.*security.ubuntu.com|$APK_PROXY|g" /etc/apt/sources.list ; \
    fi

RUN apt-get update && apt-get install -y \
    glibc-source coreutils git curl gcc software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt install python3 && \
    rm -rf /var/lib/apt/lists/*

COPY --from=base /workspace/nvim-linux64 /opt/nvim

RUN ln -s /opt/nvim/bin/nvim /usr/local/bin/nvim && \
    mkdir -p /root/.config/nvim

COPY . /root/.config/nvim

RUN if [[ -n "$GH_PROXY" ]]; then git config --global http.https://github.com.proxy $GH_PROXY; fi

RUN nvim --headless -c PlugInstall -c qa

RUN nvim --headless -c 'TSInstall all' -c 'MasonInstall all' -c qa

ENTRYPOINT [ "bash" ]
CMD [ "nvim" "/workspace" ]
