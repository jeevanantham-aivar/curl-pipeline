# Security Scan Pipeline Repository

## Overview

This repository implements a comprehensive **security scanning CI/CD pipeline** using GitHub Actions. The pipeline automatically scans code for security vulnerabilities and infrastructure misconfigurations on every Pull Request, ensuring code quality and security compliance before merging.

### Technologies Used
- **Security Scanning**: 
  - **Bandit** - Python code security analysis
  - **Checkov** - Terraform/Infrastructure security scanning
- **CI/CD**: GitHub Actions with automated security validation
- **Cloud Platform**: AWS (ap-south-1 region) for report storage

## Project Structure

```
repo-root/
├── .github/
│   └── workflows/
│       └── security-scan.yml          # Main security scanning CI/CD pipeline
├── Terraform/                         # Infrastructure-as-Code (IaC) files
│   ├── environments/                  # Environment-specific configurations
│   │   ├── dev.tfvars                 # Development environment variables
│   │   └── prod.tfvars                # Production environment variables
│   ├── modules/                       # Reusable Terraform modules
│   │   └── ec2/                       # EC2 instance module
│   ├── main.tf                        # Root Terraform configuration
│   ├── variables.tf                   # Terraform variables
│   ├── output.tf                      # Terraform outputs
│   └── vulnerable.py                  # Example file for security testing
├── README.md                          # This documentation
└── .gitignore                         # Git ignore rules
```

### Folder Structure Explanation

#### Security Scan Pipeline
- **`.github/workflows/security-scan.yml`**: Main CI/CD pipeline that runs security scans
- **Trigger**: Automatically runs on Pull Requests
- **Purpose**: Ensures code security before merging

#### Application Code
- **Root level**: Contains application source code, Dockerfiles, and application-specific configurations
- **Python files**: Any `.py` files are scanned by Bandit for security vulnerabilities

#### Terraform Files
- **Terraform directory**: Contains all Infrastructure-as-Code files
- **Environment files**: `dev.tfvars` and `prod.tfvars` for different environments
- **Modules**: Reusable Terraform components

> **⚠️ Important**: This is the **standard Aivar repository folder structure** that all contributors must follow. Deviating from this structure will break the CI/CD pipeline and security scanning.

## Security Scan CI/CD Pipeline

### Workflow Overview
The `security-scan.yml` workflow is a comprehensive security scanning pipeline that automatically validates code quality and security on every Pull Request.

### Workflow Trigger
The security scanning pipeline is automatically triggered on **Pull Requests**:
- **Opened**: When a new PR is created
- **Synchronized**: When new commits are pushed to the PR
- **Reopened**: When a closed PR is reopened

### Environment Detection Logic

The pipeline intelligently detects the target environment based on branch patterns:

```yaml
if: |
  (startsWith(github.head_ref, 'feature/') && github.base_ref == 'develop') ||
  (github.head_ref == 'develop' && github.base_ref == 'main')
```

#### Branch Flow Strategy
1. **Feature Branches → Develop**: Uses `dev.tfvars` (Development environment)
   - Example: `feature/user-authentication` → `develop`
   - Purpose: Test new features in development environment

2. **Develop → Main**: Uses `prod.tfvars` (Production environment)
   - Example: `develop` → `main`
   - Purpose: Deploy tested features to production

#### Why This Logic?
- **Feature Branch Management**: Multiple feature branches can be developed simultaneously
- **Quality Gates**: All features are merged into `develop` for integration testing
- **Production Safety**: Only thoroughly tested code from `develop` reaches `main`
- **Efficiency**: Reduces merge conflicts and ensures systematic deployment

### Security Scanning Tools

#### 1. Bandit (Python Security)
- **Purpose**: Static analysis of Python code for security vulnerabilities
- **Scans**: All `.py` files in the repository
- **Checks for**:
  - Hardcoded passwords and secrets
  - SQL injection vulnerabilities
  - Insecure cryptographic functions
  - Shell injection risks
  - Insecure random number generation

#### 2. Checkov (Infrastructure Security)
- **Purpose**: Static analysis of Terraform code for security misconfigurations
- **Scans**: Terraform files (`.tf`, `.tfvars`) and generated plan files
- **Checks for**:
  - Insecure IAM policies
  - Publicly accessible resources
  - Missing encryption
  - Insecure network configurations
  - Compliance violations (CIS, AWS Best Practices)

### Pipeline Execution Flow

1. **Code Checkout**: Repository code is checked out
2. **AWS Authentication**: Configured using IAM role-based authentication
3. **Tool Installation**: Bandit and Checkov are installed
4. **Environment Detection**: Determines which `.tfvars` file to use
5. **Terraform Operations**:
   - `terraform init`: Initialize Terraform
   - `terraform plan`: Generate execution plan
   - Convert plan to JSON for Checkov analysis
6. **Security Scans**:
   - Bandit scans Python files
   - Checkov scans Terraform plan
7. **Report Generation**: Creates comprehensive security report
8. **S3 Upload**: Stores reports in AWS S3 for audit trail
9. **PR Comments**: Posts findings directly to PR with line-by-line links

## Developer Experience and Expectations

### After Creating a Pull Request

#### 1. Automated Workflow Execution
- The security scan workflow runs automatically
- Progress is visible in the **GitHub Actions** tab
- Real-time status updates are provided

#### 2. Security Report Access
- **S3 Storage**: All reports are stored in `s3://github-pullrequest-reports/{repo-name}/{branch-name}/`
- **Direct Links**: Reports are accessible via AWS Console and direct download links
- **Report Types**:
  - `bandit-report.json`: Python security findings
  - `checkov-report.json`: Infrastructure security findings
  - `report.md`: Human-readable summary

#### 3. PR Comment Integration
- **Line-by-line Comments**: Failed security findings are posted as PR comments
- **Direct Links**: Each comment includes a link to the exact line of code
- **Contextual Information**: Severity, confidence, and remediation guidance

### Developer Actions Required

#### 1. Review Security Findings
- **Read Comments**: Review all security findings posted in the PR
- **Understand Impact**: Each finding includes severity and potential impact
- **Follow Links**: Click on links to see the exact problematic code

#### 2. Remediate Issues
- **Fix Vulnerabilities**: Address security issues in your code
- **Update Infrastructure**: Modify Terraform configurations as needed
- **Test Changes**: Ensure fixes don't introduce new issues

#### 3. Provide Feedback
- **False Positives**: Comment on findings that are false positives
- **Justifications**: Explain why certain findings are not applicable
- **Documentation**: Add comments explaining security decisions

#### 4. Compliance Requirements
- **Folder Structure**: Must follow the prescribed folder structure
- **Naming Conventions**: Use standard naming for files and resources
- **Security Standards**: All code must pass security scans before merging

## Implementation Steps

### For New Contributors

#### 1. Repository Setup
```bash
# Clone the repository
git clone <repository-url>
cd <repository-name>

# Create feature branch
git checkout -b feature/your-feature-name
```

#### 2. Follow Folder Structure
- Place application code in the root directory
- Place Terraform code in the `Terraform/` directory
- Use environment-specific `.tfvars` files
- Follow module structure for reusable components

#### 3. Development Workflow
```bash
# Make your changes
# Follow the folder structure guidelines

# Commit and push
git add .
git commit -m "feat: add new feature"
git push origin feature/your-feature-name
```

#### 4. Create Pull Request
- Create PR from `feature/*` to `develop`
- Wait for security scan completion
- Review findings and remediate issues
- Address any PR comments

### For Repository Administrators

#### 1. AWS Setup
- Create S3 bucket: `github-pullrequest-reports`
- Configure IAM role: `arn:aws:iam::302263040839:role/Githubactions`
- Set up appropriate permissions for S3 access

#### 2. GitHub Configuration
- Ensure repository has GitHub Actions enabled
- Configure branch protection rules for `develop` and `main`
- Set up required status checks

#### 3. Workflow Configuration
- Ensure the `security-scan.yml` workflow is in `.github/workflows/`
- Verify environment variable files (`dev.tfvars`, `prod.tfvars`) exist
- Test the pipeline with a sample PR

## Key Implementation Guidelines

### 1. Folder Structure Compliance
- **Mandatory**: Follow the exact folder structure shown above
- **No Exceptions**: Pipeline depends on specific file locations
- **Consistency**: All team members must use the same structure

### 2. Security-First Development
- **Pre-commit**: Run security tools locally before pushing
- **Review**: Always review security findings before merging
- **Documentation**: Document security decisions and exceptions

### 3. Branch Management
- **Feature Branches**: Use `feature/*` prefix for new features
- **Integration**: Merge features into `develop` for testing
- **Production**: Only merge `develop` into `main` for production

### 4. Code Quality
- **Security**: Follow security best practices for all code
- **Python**: Follow PEP 8 and security best practices
- **Documentation**: Update README and inline comments

## Troubleshooting

### Common Issues

#### 1. Pipeline Failures
- **Check folder structure**: Ensure files are in correct locations
- **Verify permissions**: Check AWS IAM role permissions
- **Review logs**: Check GitHub Actions logs for specific errors

#### 2. Security Scan Issues
- **False positives**: Comment on findings with explanations
- **Tool versions**: Ensure local tools match pipeline versions
- **Configuration**: Check tool configuration files

#### 3. S3 Upload Issues
- **Bucket permissions**: Verify S3 bucket access
- **File paths**: Ensure report files exist before upload
- **AWS region**: Confirm region configuration

### Getting Help

1. **Check Documentation**: Review this README and inline comments
2. **Review Pipeline Logs**: Check GitHub Actions for detailed error messages
3. **Team Collaboration**: Discuss issues with team members
4. **Security Team**: Contact security team for policy questions

## Security Compliance

This repository implements security best practices:

- **Automated Scanning**: All code is automatically scanned for vulnerabilities
- **Audit Trail**: All security reports are stored in S3 for compliance
- **Line-by-line Review**: Security findings are directly linked to code
- **Environment Separation**: Development and production configurations are isolated
- **Role-based Access**: AWS access is controlled through IAM roles

## Contributing

1. **Follow the folder structure** - This is mandatory for pipeline functionality
2. **Create feature branches** - Use `feature/*` prefix
3. **Address security findings** - All security issues must be resolved or justified
4. **Document changes** - Update documentation as needed
5. **Test thoroughly** - Ensure changes work in both development and production

---

*This repository follows the Aivar standard for secure, compliant, and maintainable infrastructure code.*
