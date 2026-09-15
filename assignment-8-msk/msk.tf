resource "aws_msk_cluster" "kafka" {
    cluster_name = "tf-kafka-cluster"
    kafka_version = "3.6.0"
    number_of_broker_nodes = 2

    broker_node_group_info {
        instance_type = "kafka.t3.small"
        client_subnets = data.aws_subnets.public.ids
        security_groups = [aws_security_group.msk.id]

        storage_info {
            ebs_storage_info {
                volume_size = 10
            }
        }
    }

    encryption_info {
            encryption_in_transit {
                client_broker = "TLS_PLAINTEXT"
                in_cluster = true
            }
        }

        tags = {
            Name = "tf-kafka-cluster"
        }

}