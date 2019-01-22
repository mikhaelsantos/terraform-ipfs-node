resource "aws_iam_role" "instance-role" {
  name               = "${var.enviroment}-${var.name}-instance-role"
  assume_role_policy = "${file("${var.path_to_assume_policy}")}"
}

resource "aws_iam_policy" "instance-policy" {
  name        = "${var.enviroment}-${var.name}-instance-policy"
  description = "Policy to configuration bucket"
  policy      = "${file("${var.path_to_policy}")}"
}

resource "aws_iam_policy_attachment" "policy-attach" {
  name       = "${var.enviroment}-${var.name}-policy-attachment"
  roles      = ["${aws_iam_role.instance-role.name}"]
  policy_arn = "${aws_iam_policy.instance-policy.arn}"
}

resource "aws_iam_instance_profile" "profile" {
  name  = "${var.enviroment}-${var.name}-profile"
  role = "${aws_iam_role.instance-role.name}"
}
