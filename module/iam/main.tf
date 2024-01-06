#############################################################################################################
#                                   Creating IAM Role
#############################################################################################################
resource "aws_iam_role" "s3-to-efs-iam-role" {
  name = "${var.project-name}-iam-role"
  assume_role_policy = <<EOF
{
    "Version" : "2012-10-17",
    "Statement" : [
        {
            "Effect" : "Allow",
            "Action" : "sts:AssumeRole",
            "Principal" : {
                "Service" : "lambda.amazonaws.com"  
            }
        }
    ]
}
EOF
}

#############################################################################################################
#                                   Creating IAM Policy
#############################################################################################################
resource "aws_iam_policy" "s3-to-efs-iam-policy" {
  name = "${var.project-name}-iam-policy"
  policy = <<EOF
{
    "Version" : "2012-10-17",
    "Statement": [
        {
            "Sid" : "lambdaexecutionpolicy",
            "Effect" : "Allow",
            "Action" : [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "s3-object-lambda:WriteGetObjectResponse"
            ],
            "Resource" : "*"
        },
        {
            "Sid" : "lambdavpcaccess",
            "Effect" : "Allow",
            "Action" : [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "ec2:CreateNetworkInterface",
                "ec2:DescribeNetworkInterfaces",
                "ec2:DescribeSubnets",
                "ec2:DeleteNetworkInterface",
                "ec2:AssignPrivateIpAddresses",
                "ec2:UnassignPrivateIpAddresses"
            ],
            "Resource" : "*"
        },
        {
            "Sid" : "connectiontos3",
            "Effect" : "Allow",
            "Action" : [
                "s3:ListBucket",
                "s3:GetObjects",
                "s3:PutObjects",
                "s3:GetObjectNotification"
            ],
            "Resource" : "*"
        },
        {
            "Sid" : "connectiontoefs",
            "Effect" : "Allow",
            "Action" : [
                "elasticfilesystem:ClientWrite",
                "elasticfilesystem:ClientRead",
                "elasticfilesystem:ClientRootAccess",
                "elasticfilesystem:DescribeFileSystems",
                "elasticfilesystem:DescribeMountTargets"
            ],
            "Resource" : "*"
        }
    ]
}  
EOF
}

#############################################################################################################
#                                Attaching Role and Policy
#############################################################################################################
resource "aws_iam_role_policy_attachment" "role-policy-attachment" {
  role = aws_iam_role.s3-to-efs-iam-role.id
  policy_arn = aws_iam_policy.s3-to-efs-iam-policy.arn
}
