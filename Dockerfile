FROM ubuntu:latest

# Install Cron & Curl
RUN apt-get update && apt-get install -y cron curl
 
# Add crontab file in the cron directory
ADD crontab /etc/cron.d/f4f-login-cron

# Add F4F login script to /home
ADD f4f-login.sh /home/f4f-login.sh
 
# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/f4f-login-cron
 
# Run the command on container startup
CMD touch /var/log/f4f.log /etc/crontab /etc/cron.*/* && printenv | grep -v "no_proxy" >> /etc/environment && cron && tail -f /var/log/f4f.log