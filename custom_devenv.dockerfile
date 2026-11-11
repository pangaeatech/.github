FROM dhi.io/python:3

ENV DOTNET_VERSION=10
# renovate: datasource=github-tags depName=github/copilot.vim versioning=semver extractVersion=^v(?<version>.*)$
ENV COPILOT_VIM_VERSION=1.59.0

RUN apk add -U bash jq curl pandoc zip unzip dotnet${DOTNET_VERSION}-sdk doxygen nodejs npm poetry nvim git sed
RUN rm -Rf /var/cache/apk/*

# Install opencode-desktop-linux-amd64.deb from latest release at https://github.com/anomalyco/opencode/releases
RUN curl -s https://api.github.com/repos/anomalyco/opencode/releases/latest | jq -r '.assets[] | select(.name | test("opencode-desktop-linux-amd64.deb")) | .browser_download_url' | xargs curl -L -o /tmp/opencode.deb && \
    dpkg -i /tmp/opencode.deb && \
    rm /tmp/opencode.deb

# Install copilot.vim plugin for neovim
RUN curl -L -o /tmp/copilot.vim.tar.gz https://github.com/github/copilot.vim/archive/refs/tags/v${COPILOT_VIM_VERSION}.tar.gz && \
    tar -xzf /tmp/copilot.vim.tar.gz -C /tmp && \
    mv /tmp/copilot.vim-${COPILOT_VIM_VERSION} /root/.config/nvim/pack/github/start/copilot.vim && \
    rm /tmp/copilot.vim.tar.gz

ENTRYPOINT ["/bin/bash"]
