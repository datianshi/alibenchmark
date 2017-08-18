# Alibaba Cloud Excercise

## What does this project do

1. Benchmark ECS
2. Benchmark RDS
3. Three tiers application deployment (LB -> Middleware -> DB)

## Prerequisites

1. Setup an account at [Alibaba Cloud](https://www.alibabacloud.com/campaign/free-trial) with $300 credits
2. Create an admin user and get API access key and secret at [RAM](https://www.alibabacloud.com/product/ram#product-details)
3. Create a key/pair at alibaba cloud
4. create an env.sh to based on [env_template.sh](env_template.sh)
5. ```source env.sh```
6. Install terraform and [alibaba cloud terraform provider](https://github.com/alibaba/terraform-provider)
7. ```terraform plan``` to review the resources created
8. ```terraform apply``` to create the resources:

  * 1 Load Balancer
  * 2 ECS instances (ecs.n4.small, configurable) with ubuntu image and install necessary softwares from [user data](initiate.sh) when booting
  * 1 MySql Database instance (ds.mysql.t1.small, configurable)

## Benchmark   

**Note** The benchmark is done **only** with **ecs.n4.small** and **ds.mysql.t1.small** in **us-east-1** region. Other flavors benchmark testing can be easily reproduced by changing env.sh config and re-apply terraform

Log in to the ECS shell. Find the public ip either from the terraform scripts or ECS console

```
tstate show alicloud_instance.test[0] | grep public_ip

ssh -i [private_key] root@public_ip
```

1. ECS Benchmark

   * CPU - [report](test_results/cpuresult.txt)

    ```phoronix-test-suite benchmark c-ray```

   * Disk - [report](test_results/disktest.txt)

     ```phoronix-test-suite benchmark fio```

   * Network - [report](test_results/network.txt)

     There are two tests here:
     1. iperf to west coast -> iperf.he.net
     2. iperf to another VM in the same VPC

       run iperf3 server in another vm ```iperf3 -s &```

       ```phoronix-test-suite benchmark iperf```

2. RDS Benchmark

   Use sysbench oltp mysql test suite - 5 threads - 1 million records [report](test_results/mysql.txt)

   Find database info here: ```terraform state show alicloud_db_instance.dc```

   ```./mysqlbenchmark.sh [HOST] [USERNAME] [PASSWORD] [DATABASE]```

## Deploy Application

* [Spring Music](https://github.com/datianshi/spring-music-extend)

  A sample spring boot app that uses multiple database resources to serve albums storage

* SLB works as the load balancer with port 80 -> ECS 8080
* Two ECS instances run spring music app with port 8080
* One Mysql RDS to store apps' albums
* The packaged jar is stored in Object Storage Service. It will be pulled to the ECS VMS during start up/creation
* To deploy the app to multiple instances ```./deploy_app.sh [PRIVATE_KEY]``` [deploy_app.sh](deploy_app.sh)


## Tear Down resources

```terraform destroy```
