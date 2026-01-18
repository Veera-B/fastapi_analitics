# Download and install Python 3
ARG PYTHON_VERSION=3.13.9-slim-trixie
FROM python:3.13.9-slim-trixie

# SETUP LINUX OS DEPENDENCIES'

# Crete a virtual environment
# Install PYTHON dependencies

# Setup the python version as a build-time argument
# with python version 3.13.9 as default

FROM python:${PYTHON_VERSION}

# create virtual environment
RUN python -m venv /opt/venv

# Set the  virtual environment as the current location
ENV PATH=/opt/venv/bin:$PATH

# Update pip to the latest version
RUN pip install --upgrade pip

# Set python-related environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install the os dependencies for our mini VM
RUN apt-get update && apt-get install -y  bash \ 
    build-essential \ 
    libpq-dev \
    git \ 
    && rm -rf /var/lib/apt/lists/*

# Create the mini VM's code directory
RUN mkdir -p /code
WORKDIR /code/src

# Copy the requirements file into the mini VM
COPY ./requirements.txt /code/requirements.txt

#Make sure the bash script is executable
COPY boot/docker-run.sh /opt/run.sh 
RUN chmod +x /opt/run.sh
# Copy the project code into the container's CODE directory
COPY ./src /code/src
# Install the python dependencies
RUN pip install --no-cache-dir -r /code/requirements.txt

# Clean up apt cache to reduce image size
RUN apt-get remove --purge -y \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Run the FastAPI project via the runtime script
# when the container starts
CMD ["/opt/run.sh"]