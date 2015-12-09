resource "aws_db_instance" "default" {
    identifier = "empire-sys"
    allocated_storage = 5
    storage_type = "standard"
    engine = "postgres"
    engine_version = "9.4.5"
    instance_class = "db.t1.micro"
    name = "postgres"
    username = "empire"
    password = "emp1r3pAAs"
    vpc_security_group_ids = ["${aws_security_group.rds.id}"]
    db_subnet_group_name = "${aws_db_subnet_group.default.id}"
}

resource "aws_db_subnet_group" "default" {
    name = "main"
    description = "RDS subnet group"
    subnet_ids = ["${aws_subnet.public.*.id}"]
    tags {
        Name = "RDS subnet"
    }
}
