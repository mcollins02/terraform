resource "aws_ebs_volume" "jenkins_ebs_volume_home" {
  count             = "${var.create_ebs_jenkins ? 1 : 0}"
  availability_zone = "${var.jenkins_ebs_az}"
  size              = 250
  type              = "gp2"

  tags = {
    Name = "jenkins /jenkins"
  }
}

resource "aws_ebs_volume" "jenkins_ebs_volume_docker" {
  count             = "${var.create_ebs_jenkins_docker ? 1 : 0}"
  availability_zone = "${var.jenkins_ebs_az}"
  size              = 200
  type              = "gp2"

  tags = {
    Name = "jenkins-docker"
  }
}

resource "aws_volume_attachment" "jenkins_ebs_vol_attactment_jenkins" {
  count       = "${var.create_ebs_jenkins ? 1 : 0}"
  device_name = "/dev/xvdf"
  volume_id   = "${aws_ebs_volume.jenkins_ebs_volume_home.id}"
  instance_id = "${aws_instance.jenkins.id}"
}

resource "aws_volume_attachment" "jenkins_ebs_vol_attactment_docker" {
  count       = "${var.create_ebs_jenkins_docker ? 1 : 0}"
  device_name = "/dev/xvdg"
  volume_id   = "${aws_ebs_volume.jenkins_ebs_volume_docker.id}"
  instance_id = "${aws_instance.jenkins.id}"
}
