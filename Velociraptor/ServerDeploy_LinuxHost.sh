#!/bin/bash

mkdir /opt/velociraptor && cd /opt/velociraptor



wget https://github.com/Velocidex/velociraptor/releases/download/v0.7.0/velociraptor-v0.7.0-3-linux-amd64 -O /opt/velociraptor/velociraptor_deploy

chmod +x  /opt/velociraptor/velociraptor_deploy

/opt/velociraptor/velociraptor_deploy config generate -i

read -p "Please enter the username you want to create as an admin for logging in the portal? " SUPER_USER
/opt/velociraptor/velociraptor_deploy  --config server.config.yaml user add $SUPER_USER --role administrator

#COMMAND_TO_RUN="sudo /bin/bash -c '/opt/velociraptor/velociraptor_deploy --config /opt/velociraptor/server.config.yaml frontend -v'"
#CRON_FILE=$(mktemp)
#echo "@reboot $COMMAND_TO_RUN" > $CRON_FILE
#crontab $CRON_FILE
#rm $CRON_FILE
#echo "Cron job for system restart added. Command to run: $COMMAND_TO_RUN"

cat <<EOF > /etc/systemd/system/velociraptor.service
[Unit]
Description=Velociraptor Service
After=syslog.target network.target

[Service]
Type=simple
Restart=always
RestartSec=120
LimitNOFILE=20000
Environment=LANG=en_US.UTF-8
ExecStart=/opt/velociraptor/velociraptor_deploy -c /opt/velociraptor/server.config.yaml frontend -v

[Install]
WantedBy=multi-user.target
EOF

sleep 5
systemctl enable velociraptor
sleep 7
systemctl start velociraptor
echo "...................................."
echo "Velociraptor installed as a service "



read -p "What is the internal Or public Ip of the server? " SRV_IP
TMP_LOCAL="https://localhost:8000"
VELO_PORTAL="https://$SRV_IP:8000"
ENDPOINTAGENT_CONFIG="/opt/velociraptor/client.config.yaml"
sed -i "s|$TMP_LOCAL|$VELO_PORTAL|g" "$ENDPOINTAGENT_CONFIG"
echo "Your Velociraptor portal URL is $VELO_PORTAL"


SWP_OLD1="bind_address: 127.0.0.1"
SWP_NEW1="bind_address: 0.0.0.0"
SRV_CONFIG="/opt/velociraptor/server.config.yaml"
sed -i "s|$SWP_OLD1|$SWP_NEW1|g" "$SRV_CONFIG"
echo "................................................................
........................................................................."
echo "All set. Fun Fact: RDR2 IS THE BEST GAME EVER"




echo "
                                         .=#@@%+:                                         
                                      :+%@@@@@@@@@*-                                      
                                  .=#@@@@@@@@@@@@@@@@#+:                                  
                               -+%@@@@@@@@@@@@@@@@@@@@@@@*-                               
                           .-*@@@@@@@@@@@@@*--+%@@@@@@@@@@@@#=.                           
                        :+%@@@@@@@@@@@@#=:      .=#@@@@@@@@@@@@%+-                        
                    .=*@@@@@@@@@@@@@*-              :+%@@@@@@@@@@@@#=.                    
                 :+%@@@@@@@@@@@@#=:                    .=*@@@@@@@@@@@@%*-                 
              =#@@@@@@@@@@@@@*-                            :+%@@@@@@@@@@@@#=.             
          .+#@@@@@@@@@@@@%+:                                  .=#@@@@@@@@@@@@%+:          
       -*@@@@@@@@@@@@@*-.                                         -*%@@@@@@@@@@@@*=       
     .@@@@@@@@@@@@@+:                                                .=@@@@@@@@@@@@@:     
     -@@@@@@@@@@@@@-                                                  :%@@@@@@@@@@@@+     
     -@@@@@@@@@@@@@@@*=.                                           -*@@@@@@@@@@@@@@@+     
     -@@@@@@@@@@@@@@@@@@%+:                                    :=#@@@@@@@@@@@@@@@@@@+     
     -@@@@@@@@@@@@@@@@@@@@@@*=.                             -*%@@@@@@@@@@@@@@@@@@@@@+     
     -@@@@@@@#-=#@@@@@@@@@@@@@@%+:                      .=#@@@@@@@@@@@@@@#+-*@@@@@@@+     
     -@@@@@@@-    -*@@@@@@@@@@@@@@@*-                -+%@@@@@@@@@@@@@@*-    .@@@@@@@+     
     -@@@@@@@-       :=#@@@@@@@@@@@@@@#+:        .=#@@@@@@@@@@@@@@#+:       .@@@@@@@+     
     -@@@@@@@-           -*@@@@@@@@@@@@@@@*-  :*%@@@@@@@@@@@@@@*-.          .@@@@@@@+     
     -@@@@@@@-              :=%@@@@@@@@@@@@@@@@@@@@@@@@@@@@%+:              .@@@@@@@+     
     -@@@@@@@-                 .-*@@@@@@@@@@@@@@@@@@@@@@#=.                 .@@@@@@@+     
     -@@@@@@@-                     :+%@@@@@@@@@@@@@@%+:                     .@@@@@@@+     
     -@@@@@@@-                         -#@@@@@@@@%=.                        .@@@@@@@+     
     -@@@@@@@-                          .@@@@@@@@-                          .@@@@@@@+     
     -@@@@@@@-                          .@@@@@@@@-                          .@@@@@@@+     
     -@@@@@@@-                          .@@@@@@@@-                          .@@@@@@@+     
     -@@@@@@@-                          .@@@@@@@@-                          .@@@@@@@+     
     -@@@@@@@-                          .@@@@@@@@-                          .@@@@@@@+     
     -@@@@@@@-                          .@@@@@@@@-                          .@@@@@@@+     
     -@@@@@@@-                          .@@@@@@@@-                          .@@@@@@@+     
     -@@@@@@@+                          .@@@@@@@@-                          -@@@@@@@+     
     -@@@@@@@@@*-                       .@@@@@@@@-                       :+%@@@@@@@@+     
     .@@@@@@@@@@@@#=.                   .@@@@@@@@-                    -*@@@@@@@@@@@@-     
       =#@@@@@@@@@@@@%+-                .@@@@@@@@-                :+#@@@@@@@@@@@@#=.      
          :+%@@@@@@@@@@@@#=.            .@@@@@@@@-             -*@@@@@@@@@@@@@*-          
             .=%@@@@@@@@@@@@%+:         .@@@@@@@@-         .+#@@@@@@@@@@@@%+:             
                 -*@@@@@@@@@@@@@*=.     .@@@@@@@@-      -*%@@@@@@@@@@@@*=.                
                    .+#@@@@@@@@@@@@%+:  :@@@@@@@@+  .=#@@@@@@@@@@@@%+:                    
                        -*%@@@@@@@@@@@@%@@@@@@@@@@@@@@@@@@@@@@@@*=.                       
                           .=#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%+:                           
                               =*@@@@@@@@@@@@@@@@@@@@@@@@#=.                              
                                  :+#@@@@@@@@@@@@@@@@%+-                                  
                                     .-*@@@@@@@@@@#=.                                     
                                         :+%@@%+-                                         
"

echo " Made by CyberJunkie "

#sleep 7
#/opt/velociraptor/velociraptor_deploy --config /opt/velociraptor/server.config.yaml frontend -v
