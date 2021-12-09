FROM python:3.8-bullseye

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip and Install setuptools & wheel
RUN pip install --upgrade pip setuptools wheel

WORKDIR /usr/src/app

# Copy requirements.txt
COPY requirements.txt ./
RUN pip install -r requirements.txt

# Copy our source file into the container
COPY . .

# Just documentation.
# This container needs Docker or OpenShift to help with networking
EXPOSE 8000

# Command to run when container starts up
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]