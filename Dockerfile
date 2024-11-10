FROM nvidia/cuda:12.4.1-cudnn-devel-ubuntu22.04

# Install system dependencies and Python packages
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        python3 \
        python3-dev \
        python3-venv \
        python3-pip \
	nvidia-utils-550 \
    && apt-get purge -y --auto-remove \
        build-essential \
        python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Create a virtual environment in /app/.venv
RUN python3 -m venv /app/.venv

# Activate the virtual environment and install Python dependencies
COPY ./ ./
RUN . /app/.venv/bin/activate && pip install --no-cache-dir -r requirements.txt

#RUN nvidia-smi
#RUN nvidia-smi || echo "GPU not available during build"

# Make sure the environment is activated in the entrypoint
EXPOSE 10300

ENTRYPOINT ["/bin/bash", "-c", "source /app/.venv/bin/activate && bash run.sh"]
