# Security Guidelines

## Overview

This document describes the security practices and tools used in the OUDS Flutter SDK project to maintain the highest standards of code quality and security.

## Automated Security Scanning

### Continuous Integration Security Checks

Every commit and pull request triggers automated security scans:

#### 1. **SAST - Semgrep Security Analysis**
- **When**: Every push and pull request
- **What**: Scans Dart/Flutter code for security vulnerabilities
- **Rules**: Security audit, OWASP Top 10, Dart-specific patterns
- **Excludes**: Generated files (`*.g.dart`, `*.freezed.dart`), build artifacts, tests
- **Output**: SARIF format in GitHub Security tab

#### 2. **Dart Static Analysis**
- **When**: Every push and pull request
- **Flags**: `--fatal-infos --fatal-warnings`
- **Scope**: All packages in workspace
- **Purpose**: Enforce language best practices

#### 3. **Flutter Analysis**
- **When**: Every push and pull request
- **Purpose**: Flutter framework-specific checks
- **Scope**: All Flutter packages

#### 4. **Secret Scanning - Gitleaks**
- **When**: Every push
- **What**: Scans for hardcoded secrets
- **Detects**: API keys, credentials, certificates, tokens
- **Config**: `.gitleaks.toml`

### Scheduled Security Scans

- **Frequency**: Weekly (every Monday at 1:00 UTC)
- **Tools**: Semgrep, Dart Analysis, Gitleaks
- **Purpose**: Continuous monitoring and compliance

---

## Code Review Process

### Branch Protection Rules

The `main` and `develop` branches are protected:

1. ✅ Require pull request reviews (minimum 1)
2. ✅ Require status checks to pass:
   - SAST Analysis (Semgrep)
   - Dart Analysis
   - Flutter Analyze
   - Build tests
3. ✅ Require branches to be up to date
4. ✅ Code owners review required

### Pull Request Workflow

```
1. Create feature branch from develop
   ↓
2. Make changes and push
   ↓
3. Automated checks run:
   - SAST Analysis
   - Tests
   - Code quality checks
   ↓
4. Request manual review
   ↓
5. Address feedback
   ↓
6. Approval received
   ↓
7. Merge to develop (or main for hotfixes)
```

---

## Dependency Security

### Managing Dart Packages

- **Source**: pub.dev only
- **Versioning**: Use exact or pinned version ranges
- **Updates**: Reviewed before merging
- **Advisories**: Security advisories checked daily

### Dependabot Integration

- **Frequency**: Weekly checks
- **Scope**: pubspec.yaml, pubspec.lock
- **Actions**:
  - Creates pull requests for updates
  - Security patches auto-merged (if tests pass)
  - Major updates require manual review

### Flutter SDK

- **Channel**: Stable (no beta/dev)
- **Updates**: Regular patch updates
- **Testing**: All tests run on each update
- **Pinning**: Version specified in GitHub Actions workflows

---

## Secure Development Practices

### Code Quality

1. **Static Analysis**: Mandatory passing checks
2. **Type Safety**: Strong typing enforced
3. **Null Safety**: Dart null safety enabled
4. **Documentation**: Security concerns documented

### Testing

- Unit tests for all features
- Integration tests for critical paths
- No hardcoded secrets in tests
- Mock external APIs (no real credentials)

### Documentation

- Inline comments for security-critical code
- README.md for general information
- SECURITY.md for vulnerability reporting
- CONTRIBUTING.md for development guidelines

---

## Permissions & Access Control

### GitHub Actions Permissions

All workflows use **least privilege** permissions:

```yaml
permissions:
  contents: read              # Read-only
  security-events: write      # Write SAST results only
  actions: read               # Read workflow metadata
```

### Secrets Management

- Use GitHub Secrets for sensitive data
- Secrets masked in logs automatically
- GitHub tokens rotated regularly
- Never hardcode secrets in code or configs

### Branch Protection

- Only admins can push to `main`
- Force-push disabled on protected branches
- Deletion of protected branches disabled

---

## Version Control Security

### Commit History

- All commits tracked in version control
- No commit rewriting on main branches
- Audit trail for all changes

### Tag Management

- Release tags on `main` branch only
- Tag naming: `MAJOR.MINOR.PATCH` (semver)
- Future: GPG-signed releases

---

## Incident Response

### Security Vulnerability Process

```
Report
  ↓
Acknowledge (48 hours)
  ↓
Investigate & Reproduce
  ↓
Develop Fix (private branch)
  ↓
Review & Test
  ↓
Release Patch Version
  ↓
Publish Security Advisory
  ↓
30-day public disclosure
```

### Embargo Period

- **Default**: 90 days coordinated disclosure
- **Early Notification**: Available for major users
- **Public Release**: 30 days after patch availability

### Contacts

- **Primary**: [opensource.contact@orange.com](mailto:opensource.contact@orange.com)
- **CERT**: [cert.cc@orange.com](mailto:cert.cc@orange.com)
- **Maintainers**: See [MAINTAINERS.md](./MAINTAINERS.md)

---

## Compliance Standards

### OWASP Top 10 (2021)

The project follows OWASP guidelines:

- ✅ A01: Broken Access Control
- ✅ A02: Cryptographic Failures
- ✅ A03: Injection
- ✅ A04: Insecure Design
- ✅ A05: Security Misconfiguration
- ✅ A06: Vulnerable Components
- ✅ A07: Authentication Failures
- ✅ A08: Data Integrity Failures
- ✅ A09: Logging/Monitoring Failures
- ✅ A10: SSRF

### OpenSSF Best Practices

The project aims for compliance with:
- SAST analysis enabled ✅
- Dependency scanning enabled ✅
- Branch protection configured ✅
- Version control used ✅
- Security policy published ✅

### License Compliance

- SPDX headers on all source files
- NOTICE.txt for third-party attribution
- Regular license audits
- MIT License compliance verified

---

## Security Tools Configuration

### Workflow: `.github/workflows/codeql.yml`

Runs Dart/Flutter security analysis on:
- Every push to `main` and `develop`
- Every pull request to `main` and `develop`
- Weekly schedule (Monday 1:00 UTC)
- Manual trigger via workflow_dispatch

**Configuration**:
```yaml
- Dart Analysis: --fatal-infos --fatal-warnings
- Flutter Analyze: --no-pub
- Semgrep Rules: security-audit, owasp-top-ten, dart
- Timeout: 60 minutes
- SARIF Upload: Enabled
```

### Dependency Scanning: `.github/dependabot.yml`

Monitors and updates:
- Dart packages (pubspec.yaml)
- GitHub Actions versions
- Frequency: Weekly

### Secret Scanning: `.gitleaks.toml`

Prevents hardcoded secrets:
- API keys
- Database credentials
- OAuth tokens
- Private certificates
- SSH keys

---

## Best Practices Checklist

- ✅ SAST enabled on all branches
- ✅ Secret scanning enabled
- ✅ Dependency updates automated
- ✅ Code review required
- ✅ Branch protection configured
- ✅ Version pinning (SHA-256)
- ✅ Least privilege permissions
- ✅ Audit logging enabled
- ✅ Security policy published
- ✅ Incident response plan
- ✅ OWASP compliance
- ✅ License compliance

---

## Resources

- [OWASP Top 10](https://owasp.org/Top10/)
- [OpenSSF Best Practices](https://bestpractices.coreinfrastructure.org/)
- [Dart Security](https://dart.dev/guides/security)
- [Flutter Security](https://flutter.dev/docs/testing/security-testing)
- [GitHub Security](https://github.com/security)

---

**Last Updated**: 2026-04-17  
**Maintained By**: OUDS Security Team  
**License**: MIT

