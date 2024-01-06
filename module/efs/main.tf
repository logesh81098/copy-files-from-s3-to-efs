###########################################################################################################
#                                Deploying EFS
###########################################################################################################
resource "aws_efs_file_system" "project-efs" {
  creation_token = "${var.project-name}-FileSystem"
  performance_mode = "generalPurpose"
  throughput_mode = "bursting"
  encrypted = true
  tags = {
    Name = "${var.project-name}-FileSystem"
  }
}


###########################################################################################################
#                                Creating Mount Points for EFS
###########################################################################################################

#Note: Mount Point require Security group, So before going with mount point creating Security groups

resource "aws_efs_mount_target" "mount-target-1" {
  file_system_id = aws_efs_file_system.project-efs.id
  subnet_id = var.subnet-1-id
  security_groups = [var.efs-security-group]
}

resource "aws_efs_mount_target" "mount-target-2" {
  file_system_id = aws_efs_file_system.project-efs.id
  subnet_id = var.subnet-2-id
  security_groups = [var.efs-security-group]
}


###########################################################################################################
#                                Creating Access Point for EFS
###########################################################################################################

resource "aws_efs_access_point" "efs-ap" {
  file_system_id = aws_efs_file_system.project-efs.id
  posix_user {
    uid = "1000"
    gid = "1000"
  }
  root_directory {
    path = "/efs"
    creation_info {
      owner_uid = "1000"
      owner_gid = "1000"
      permissions = "777"
    }
  }
}

##########################################################################################################
#Note:Number of resource: 3
##########################################################################################################