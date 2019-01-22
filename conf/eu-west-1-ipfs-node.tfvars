ipfs_region = "eu-west-1"
ipfs_env = "IPFST"
ipfs_enviroment = "ipfs-test"
ipfs_name = "ipfs-node"
ipfs_key_name = "<some_key>"
ipfs_image_id = "ami-00b36349b3dba2ec3"
ipfs_cluster = {
  min = 1
  max = 3
  desired = 1
  instance_type = "t3.micro"
}
ipfs_ingress_rules = [
  {
    "description" = "Opens ipfs to receive requests to port 8080"
    "protocol" = "tcp"
    "from_port" = 8080
    "to_port" = 8080
  },
  {
    "description" = "Opens ipfs to receive requests to port 4001"
    "protocol" = "tcp"
    "from_port" = 4001
    "to_port" = 4001
  },
  {
  "description" = "Opens ipfs to receive requests to port 8080"
  "protocol" = "tcp"
  "from_port" = 8081
  "to_port" = 8081
  },
  {
    "description" = "Opens ipfs to receive requests to port 8081"
    "protocol" = "udp"
    "from_port" = 4002
    "to_port" = 4002
  }]

ipfs_ssh_cidr_blocks = ["0.0.0.0/0"]
ipfs_path_to_init = "./init-config.tpl"
ipfs_path_to_policy = "./policy.json"
ipfs_path_to_assume_policy = "./assume-role-policy.json"

