FROM ubuntu
MAINTAINER user@user.com

# Update
RUN apt-get update

# Install required pkgs
RUN apt-get install -y python python-dev python-distribute python-pip 

# Install tools
RUN apt-get install -y iputils-ping curl

# Copy code here
COPY src /app

# Install requirements
RUN pip install -r /app/requirements.txt

# Working dir
WORKDIR /app

# Execute app
CMD ["python", "./main.py"]

# Expose port 80 
EXPOSE 80
