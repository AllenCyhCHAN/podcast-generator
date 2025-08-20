FROM ubuntu:latest

# Install dependencies and clean up
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3-venv \
    python3-pip \
    git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a virtual environment
RUN python3 -m venv /opt/venv

# Upgrade pip in the virtual environment
RUN /opt/venv/bin/pip install --upgrade pip

# Install packages in the virtual environment
RUN /opt/venv/bin/pip install pyYAML

# Copy application files
COPY feed.py /usr/bin/feed.py
COPY entrypoint.sh /entrypoint.sh

# Ensure the entrypoint script is executable
RUN chmod +x /entrypoint.sh

# Set the entry point
ENTRYPOINT ["/entrypoint.sh"]

# Use the virtual environment's Python interpreter
CMD ["/opt/venv/bin/python", "/usr/bin/feed.py"]