# FROM ubuntu:latest

# RUN apt-get update && apt-get install -y \ 
#     python3.10 \ 
#     python3-pip \
#     git

# RUN pip3 install pyYAML

# COPY feed.py /usr/bin/feed.py

# COPY entrypoint.sh /entrypoint.sh

# ENTRYPOINT ["/entrypoint.sh"]

FROM ubuntu:latest

# Install dependencies and clean up
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3-pip \
    git && \
    pip3 install pyYAML && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy application files
COPY feed.py /usr/bin/feed.py
COPY entrypoint.sh /entrypoint.sh

# Ensure the entrypoint script is executable
RUN chmod +x /entrypoint.sh

# Set the entry point
ENTRYPOINT ["/entrypoint.sh"]