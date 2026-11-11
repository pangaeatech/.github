FROM dhi.io/debian-base:trixie-debian13-dev

# renovate: datasource=github-tags depName=github/copilot.vim versioning=semver extractVersion=^v(?<version>.*)$
ENV COPILOT_VIM_VERSION=1.59.0

# Install dependencies
RUN apt-get update
RUN apt-get install
RUN apt-get install -y --no-install-recommends jq curl pandoc zip unzip doxygen nodejs npm git sed python3-pip python3-venv python3-dev build-essential pipx neovim wget

# Install .NET SDK 10.0
RUN wget https://packages.microsoft.com/config/debian/13/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    rm packages-microsoft-prod.deb
RUN apt-get update
RUN apt-get install -y --no-install-recommends dotnet-sdk-10.0

# Install poetry
RUN pipx ensurepath
RUN pipx install poetry

# Install copilot.vim plugin for neovim
RUN curl -L -o /tmp/copilot.vim.tar.gz https://github.com/github/copilot.vim/archive/refs/tags/v${COPILOT_VIM_VERSION}.tar.gz && \
    tar -xzf /tmp/copilot.vim.tar.gz -C /tmp && \
    mkdir -p /root/.config/nvim/pack/github/start && \
    mv /tmp/copilot.vim-${COPILOT_VIM_VERSION} /root/.config/nvim/pack/github/start/copilot.vim && \
    rm /tmp/copilot.vim.tar.gz

# Install opencode-desktop-linux-amd64.deb from latest release at https://github.com/anomalyco/opencode/releases
RUN curl -s https://api.github.com/repos/anomalyco/opencode/releases/latest | jq -r '.assets[] | select(.name | test("opencode-desktop-linux-amd64.deb")) | .browser_download_url' | xargs curl -L -o /tmp/opencode.deb && \
    apt-get install -y --no-install-recommends /tmp/opencode.deb && \
    rm /tmp/opencode.deb

# Delete apt cache to reduce image size
RUN rm -Rf /var/lib/apt/lists/*

ENTRYPOINT ["/bin/bash"]
