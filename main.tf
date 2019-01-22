data "template_file" "init-config" {
  template = "${file("${var.path_to_init}")}"
}

resource "aws_launch_configuration" "lc" {
  name_prefix  = "${var.name}-instance-lc-"
  image_id = "${var.image_id}"
  instance_type = "${var.cluster["instance_type"]}"
  key_name = "${var.key_name}"
  associate_public_ip_address = true
  user_data = "${data.template_file.init-config.rendered}"
  iam_instance_profile = "${aws_iam_instance_profile.profile.name}"
  security_groups = ["${aws_security_group.security_group.id}"]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "autoscaling-group" {
  vpc_zone_identifier = ["${var.subnets}"]
  name = "${var.enviroment}-${var.name}-autoscaling-group"
  max_size = "${var.cluster["max"]}"
  min_size = "${var.cluster["min"]}"
  desired_capacity ="${var.cluster["desired"]}"
  launch_configuration = "${aws_launch_configuration.lc.name}"
  tags= [
    {
      key = "Name"
      value = "${var.name}-instance"
      propagate_at_launch = true
    },
    {
      key = "Environment"
      value = "${var.enviroment}"
      propagate_at_launch = true
    }
  ]
}


