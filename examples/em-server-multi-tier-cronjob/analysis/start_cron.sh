source /clone_server.sh

echo "Activating the environment..."
source setup/activate.sh

echo "Installing devcron..."
pip install devcron

# launch the cronjob
echo "Launch the cronjob"
# while true; do sleep 30; done;
devcron ../crontab >> /var/log/cron.console.stdinout 2>&1
