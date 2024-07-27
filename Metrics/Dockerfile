# FROM playright with Ubunto Jammy 22
FROM mcr.microsoft.com/playwright:jammy

# Access as root user
USER root

# Set the results folder
ENV ROBOT_REPORTS_DIR /opt/robotframework/results

# Set the tests folder
ENV ROBOT_TESTS_DIR /opt/robotframework/

# Setup the timezone
ENV TZ=America/Sao_Paulo

# Update and Install Python
RUN apt-get update
RUN apt-get install -y python3-pip

# Install RobotFramework and Browser Library, nodejs and libtoc
RUN pip3 install robotframework
RUN pip3 install robotframework-browser
RUN pip3 install robotframework-faker
RUN pip3 install robotframework-libtoc
RUN pip3 install robotframework-requests
RUN rfbrowser init
RUN apt-get update
ENV NODE_PATH=/usr/lib/node_modules

# Workdir Directory
WORKDIR   /opt/robotframework/