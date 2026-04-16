package aws.ec2

import rego.v1

allowed_ec2_instance_type := "t2.micro"

deny contains msg if {
    rc := input.resource_changes[_]
    rc.mode == "managed"
    rc.type == "aws_security_group"
    rc.change.after != null

    ingress := object.get(rc.change.after, "ingress", [])[_]
    ssh_open_to_world(ingress)

    msg := sprintf("SSH (22) open to 0.0.0.0/0 is not allowed in Security Group: %s", [rc.address])
}

deny contains msg if {
    rc := input.resource_changes[_]
    rc.mode == "managed"
    rc.type == "aws_security_group_rule"
    rc.change.after != null

    after := rc.change.after
    lower(object.get(after, "type", "")) == "ingress"
    ssh_open_to_world(after)

    msg := sprintf("SSH (22) open to 0.0.0.0/0 is not allowed in Security Group Rule: %s", [rc.address])
}

deny contains msg if {
    rc := input.resource_changes[_]
    rc.mode == "managed"
    rc.type == "aws_instance"
    rc.change.actions[_] == "create"

    after := object.get(rc.change, "after", {})
    instance_type := object.get(after, "instance_type", "")
    instance_type != allowed_ec2_instance_type

    msg := sprintf("Only EC2 instance type %s is allowed. Resource %s uses %s", [allowed_ec2_instance_type, rc.address, instance_type])
}

ssh_open_to_world(rule) if {
    opens_ssh_port(rule)
    protocol_allows_ssh(rule)
    object.get(rule, "cidr_blocks", [])[_] == "0.0.0.0/0"
}

opens_ssh_port(rule) if {
    from_port := object.get(rule, "from_port", -1)
    to_port := object.get(rule, "to_port", -1)
    from_port <= 22
    to_port >= 22
}

protocol_allows_ssh(rule) if {
    protocol := lower(object.get(rule, "protocol", ""))
    protocol == "tcp"
}

protocol_allows_ssh(rule) if {
    protocol := lower(object.get(rule, "protocol", ""))
    protocol == "-1"
}