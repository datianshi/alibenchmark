
PRIVATE_KEY_PATH=$1


#ECS_IP=$(terraform state show alicloud_instance.test | grep public_ip | tail -1 | awk '{print $3}')

DATABASE_HOST=$(terraform state show alicloud_db_instance.dc | grep connections.0.connection_string | awk '{print $3}')
DATABASE_NAME=$(terraform state show alicloud_db_instance.dc | grep db_name| awk '{print $3}')
DATABASE_USERNAME=$(terraform state show alicloud_db_instance.dc | grep master_user_name| awk '{print $3}')
DATABASE_PASSWORD=$(terraform state show alicloud_db_instance.dc | grep master_user_password| awk '{print $3}')

CMD="SPRING_PROFILES_ACTIVE=mysql-local \
DATABASE_HOST=${DATABASE_HOST} \
DATABASE_NAME=${DATABASE_NAME} \
DATABASE_USERNAME=${DATABASE_USERNAME} \
DATABASE_PASSWORD=${DATABASE_PASSWORD} \
nohup java -jar /root/spring-music.jar > /root/spring-music.log 2>&1 &"

for ((i=0;i<${TF_VAR_count};i++)) 
do
  ECS_IP=$(terraform state show alicloud_instance.test[${i}] | grep public_ip | tail -1 | awk '{print $3}')
  ssh -i ${PRIVATE_KEY_PATH} root@${ECS_IP} $CMD
done
